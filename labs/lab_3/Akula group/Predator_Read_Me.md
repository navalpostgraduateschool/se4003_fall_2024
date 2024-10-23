# Lab 03: 'Lasers to Kill Sharks'
This lab investigates the feasibility of designing a directed energy weapon (DEW, or a laser) to shoot down enemey drones in purpose of protecting friendly ground and naval forces.

**Objectives**:
- Determine likely drone threats that DEWs could defeat
- Determine power load requirements for different engagement models
- Analyze operational impacts such as shot count, recharge time, and breaking points for the system
  
*Rapid kill capability and high kill probability* is **critical** for an effective DEW employment against threat drone targets.

----------
## Team Members
- Scrum Master: Hank C. Responsible for keeping the team on task and resolving issues.
- Domain Expert:  Jake R. The go-to person for knowledge about directed energy weapons and Navy ship power systems.
- Developer: Steve L. Gather data, conduct analysis, and design solutions.
- Tester: Siddiq H. Ensures the accuracy and quality of the work, and checks for any design issues.

---------- 

## "Predator Drone" (MQ-9) Specs
| Specification    | Details                                                                                       |
|-------------------|-----------------------------------------------------------------------------------------------|
| **Operational Range**   | Approximately 1,150 nautical miles (about 2,130 km)             |
| **Loiter Time**    | Up to 27 hours                                                                    |
| **Altitude**          | Up to 50,000 feet (15,240 meters)                                      |
| **Speed**         | Cruise speed of around 85mph;  Max speed 135 mph                             |
| **Size**          | - **Length** 36 feet 1 inch (11.0 meters)                                                   |
|                   | - **Wingspan** 66 feet (20.1 meters)                                                        |
|                   | - **Height** 12 feet 4 inches (3.76 meters)                                                 |

---------- 

# Impact of Humidity on Lasers in Counter-UAV Applications

## Overview
The effectiveness of lasers employed for counter-UAV (Unmanned Aerial Vehicle) applications can be significantly influenced by humidity in the atmosphere. This document outlines the effects of humidity on laser performance and provides relevant mathematical considerations.

## Effects of Humidity on Laser Effectiveness

1. **Absorption**: 
   - Water vapor in the atmosphere can absorb certain wavelengths of laser light, particularly in the infrared range.
   - This absorption reduces the intensity of the laser that reaches the target, potentially decreasing its effectiveness.

2. **Scattering**: 
   - Increased humidity can lead to the scattering of laser beams.
   - Water droplets in the air can scatter the light, broadening the beam and reducing focus on the target.

3. **Beam Divergence**: 
   - Higher humidity can cause the laser beam to diverge more than in dry conditions, making it challenging to maintain a tight focus on UAVs.

## Mathematical Considerations

While there isn't a single formula universally applicable to the impact of humidity on laser effectiveness, several principles can be applied:

1. **Beer-Lambert Law**:
   The Beer-Lambert law describes the attenuation of light as it travels through a medium, expressed as formula:
   the intensity of the light after traveling a distance (I) equals the initial intensity of the light ( sub 0) times the attenuation coefficient (e^x), influenced by humidty and laser wavelength

2. **Scattering Coefficient**:
   The scattering effect can be described using a scattering coefficient (\( \beta \)):
   \[
   I = I_0 \cdot e^{-(\alpha + \beta)x}
   \]

3. **Effective Power**:
   The effective power of the laser on the target can be expressed as:
   \[
   P_{\text{effective}} = P_0 \cdot e^{-(\alpha + \beta)x}
   \]
   Where:
   - \( P_0 \) = initial power of the laser

## Conclusion
In summary, humidity can significantly reduce the effectiveness of lasers used for counter-UAV applications through absorption and scattering. The Beer-Lambert law and considerations of scattering coefficients provide a mathematical framework for estimating the impact of humidity on laser intensity as it travels through the atmosphere.

---------- 

# A Key Laser-Health Monitoring Requirement
This project will require the user/operator to know the health of the battery or power source for the laser at all times. This will help inform the user/operator in the operation of the laser when engaging a single target multiple times, or multiple targets at once. The software for this feature of our system will take the following example format:

## class Battery:
    def __init__(self, capacity_wh):
        self.capacity_wh = capacity_wh  # Total battery capacity in watt-hours
        self.remaining_energy_wh = capacity_wh  # Remaining energy in watt-hours
        self.current_draw_w = 0  # Current draw in watts

    def set_current_draw(self, current_w):
        """Set the current draw of the laser in watts."""
        self.current_draw_w = current_w

    def update_remaining_energy(self, time_hours):
        """
        Update the remaining energy based on current draw and time.
        
        :param time_hours: Time in hours for which the current is drawn.
        """
        energy_used = self.current_draw_w * time_hours
        self.remaining_energy_wh -= energy_used
        
        if self.remaining_energy_wh < 0:
            self.remaining_energy_wh = 0  # Prevent negative energy

    def get_remaining_energy_percentage(self):
        """Return the remaining energy as a percentage of total capacity."""
        return (self.remaining_energy_wh / self.capacity_wh) * 100

## Example Usage
if __name__ == "__main__":
    # Create a battery with a capacity of 100 Wh
    laser_battery = Battery(100)

    # Simulate setting a current draw of 20 watts
    laser_battery.set_current_draw(20)

    # Simulate 1 hour of operation
    laser_battery.update_remaining_energy(1)

    # Get remaining energy percentage
    remaining_energy = laser_battery.get_remaining_energy_percentage()
    print(f"Remaining energy: {remaining_energy:.2f}%")

## Explanation:
Battery Class: This class represents the battery with methods to set the current draw, update remaining energy based on time, and get the remaining energy as a percentage.
set_current_draw(): Method to define how much power the laser is using.
update_remaining_energy(): Calculates remaining energy after a specified time.
get_remaining_energy_percentage(): Returns how much energy is left in percentage form.

# Laser Battery Status Example Table 
## Battery Status Table

| **Battery Capacity (Wh)** | **Remaining Energy (Wh)** | **Remaining Energy (%)** | **Status**        |
|----------------------------|---------------------------|--------------------------|-------------------|
| 100                        | 80                        | 80.00%                   | Sufficient Charge  |
| 100                        | 60                        | 60.00%                   | Sufficient Charge  |
| 100                        | 40                        | 40.00%                   | Moderate Charge    |
| 100                        | 20                        | 20.00%                   | Low Charge         |
| 100                        | 0                         | 0.00%                    | Critical Charge    |

## Interpretation
- **Sufficient Charge**: The battery is in good condition, and the laser can be fired multiple times.
- **Moderate Charge**: The user should be mindful of energy consumption.
- **Low Charge**: Immediate recharging or replacement is recommended.
- **Critical Charge**: The battery is depleted; operat

---------- 

# Remaining Questions

1. What are the expected atmospheric conditions in which the laser system will be operated?  Understanding factors like rain, fog, dust, and temperature will help optimize the software for different environments (for example, what anticipated climate for a specific region, or expecting worldwide deployment).

1. What level of automation does the user desire for the laser system?

1. What specific data points and feedback mechanisms are most critical for the user to monitor during laser operation? This might include target information, laser status, power levels, cooling system performance, and recharge status.  

