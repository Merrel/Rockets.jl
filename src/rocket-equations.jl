export g₀,
       exhaust_velocity, delta_velocity, rocket_thrust, mass_flow
# These are equations related to rocketry from Tsiolkovsky rocket equation
#  https://en.wikipedia.org/wiki/Tsiolkovsky_rocket_equation

const global g₀ = 9.80665 # Acceleration of gravity on earth in m/s²


"""
    exhaust_velocity(Isp)
Calculates the exhaust velocity `vₑ` of a rocket engine. 
We utilize specific impulse (Isp) which is the value usually provided 
when looking up info about a rocket engine. Isp is defined as:
    
    Isp = vₑ/g₀
    
Where `g₀ = 9.8` is the accerlation of gravity on earth. You don't change
this calculation just because you use the rocket engine on another planet. Isp
is simply defined under earth conditions.

## Example of  Rocket Egine Isp at sea level.
- Merline Engine 282 seconds. Dry weight 470 Kg. Thrust 0.845e6 N. Diameter 1.25m.
- RD-180 Engine 311 seconds. 5 480 Kg. Thrust 4.15e6 N  
"""
exhaust_velocity(Isp::Number) =  Isp * g₀

"""
    delta_velocity(vₑ, m₀, mf)
Tsiolkovsky rocket equation, for calculating `Δv`, the maxiumum change in velocity for
a rocket with total initial mass of `m₀`, and final mass of `mf`. The mass of the propellant is thus `m₀ - mf`.

Usually you are not given the exhaust velocity of the the propellant. So Calulation would be:

    vₑ = exhaust_velocity(282)
    Δv = delta_velocity(vₑ, m₀, mf)
"""
delta_velocity(vₑ::Number, m₀::Number, mf::Number) = vₑ*log(m₀/mf)

"""
    rocket_thrust(Isp, mass_flow)

Calculate the thrust generated by a rocket engine with specific impulse of `Isp` and
mass flow of `mass_flow`. Specific impulse says something about efficiency of engine:
how much force you get out of one unit of propellant.
"""
rocket_thrust(Isp::Number, mass_flow::Number) = g₀ * Isp * mass_flow

"""
    mass_flow(thrust, Isp)
Get mass flow in Kg/s of propellant for an engine with given `thrust` and specific impulse `Isp`.

## Example
    
    # Calculating mass flow for a Falcon 9 rocket.

    engine_thrust = 0.845e6            # Newton
    Isp           = 282                # Specific impulse in seconds
    thrust    = engine_thrust * 9      # There are 9 merlin engines on Falcon 9
    mflow1  = mass_flow(thrust, Isp)    # Total mass flow in rocket. Kg/s

    # Should get similar result from using burn time and total propellant
    burn_time = 162          # Number of seconds first stage engines will burn
    propellant_mass = 395700 # About 400 tons
    mflow2 = propellant_mass / burn_time 
"""
mass_flow(thrust::Number, Isp::Number) = thrust / (Isp * g₀)