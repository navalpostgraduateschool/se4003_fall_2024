import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def simulate_power_load(days, min_power, max_power, power_distribution='constant', to_csv=False, filename=None):
    if filename is not None:
        to_csv = True
    
    # Total number of 5-minute intervals in the specified number of days
    total_minutes = days * 24 * 60
    time_intervals = np.arange(0, total_minutes, 5) / 60.0  # In hours, 5-minute intervals

    # Generate power data based on the distribution type
    if power_distribution == 'constant':
        power = np.full(len(time_intervals), max_power)
    
    elif power_distribution == 'uniform_random':
        power = np.random.uniform(min_power, max_power, len(time_intervals))
    
    elif power_distribution == 'gaussian_random':
        mean_power = (max_power + min_power) / 2
        stddev = (max_power - min_power) / 4  # Rough rule of thumb for standard deviation
        power = np.clip(np.random.normal(mean_power, stddev, len(time_intervals)), min_power, max_power)
    
    elif power_distribution == 'workweek':
        power = np.full(len(time_intervals), min_power)
        for i, t in enumerate(time_intervals):
            # Calculate hour in the day and the day of the week (modulo days for 1-week repeat)
            day_of_week = int(t // 24) % 7
            hour_of_day = t % 24
            if day_of_week < 5 and 8 <= hour_of_day < 17:  # Mon-Fri, 8am-5pm
                power[i] = max_power
    
    elif power_distribution == 'work_sans_weekend':
        power = np.full(len(time_intervals), min_power)
        for i, t in enumerate(time_intervals):
            # Calculate hour in the day
            hour_of_day = t % 24
            if 8 <= hour_of_day < 17:  # Every day, 8am-5pm
                power[i] = max_power

    # Create DataFrame
    df = pd.DataFrame({
        'Time_hours': time_intervals,
        'Power_kW': power
    })

    # Save to CSV if a filename is provided
    if to_csv:
        if filename is None:
            filename = f'{power_distribution}_{days}days.csv'
        
        df.to_csv(filename, index=False)
        print(f'Simulated power saved to {filename}')
    
    return df


def plot_power_load(df, power_distribution=None):
    """
    Plot the power load data from the given dataframe.

    Parameters:
    df (pd.DataFrame): DataFrame containing time and power data.
                       It should have 'Time_hours' and 'Power_kW' columns,
                       otherwise, the first two columns will be used with a warning.
    """
    if power_distribution is None:
        plot_title = 'Power Load over Time'
    else:
        plot_title = f'Power Load ({power_distribution} distribution)'
        
    # Check if the necessary columns exist
    if 'Time_hours' not in df.columns or 'Power_kW' not in df.columns:
        print("Warning: 'Time_hours' or 'Power_kW' columns not found. Using the first two columns instead.")
        time_column = df.columns[0]
        power_column = df.columns[1]
    else:
        time_column = 'Time_hours'
        power_column = 'Power_kW'
    
    # Get time and power data
    time_data = df[time_column]
    power_data = df[power_column]

    # Calculate the number of days based on the time data (each day is 24 hours)
    num_days = int(time_data.max() // 24) + 1

    # Use full weekday names if <= 7 days, otherwise use abbreviated weekday names
    if num_days <= 7:
        days_of_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    else:
        days_of_week = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

    # Generate the weekday labels and the positions for the x-ticks
    tick_positions = np.arange(12, num_days * 24, 24)  # Middle of each day (12 hours into the day)
    tick_labels = [days_of_week[i % 7] for i in range(num_days)]

    # Plot the data
    plt.figure(figsize=(12, 6))
    plt.plot(time_data, power_data, label='Power Load (kW)')

    # Add grid lines between day breaks
    for i in range(0, num_days * 24, 24):
        plt.axvline(x=i, color='lightgray', linestyle='--', linewidth=0.7)

    # Set x-axis labels to the middle of each day
    plt.xticks(tick_positions, tick_labels)

    # Adding labels and title
    plt.xlabel('Day of the Week')
    plt.ylabel('Power (kW)')
    plt.title(plot_title)

    # Show the plot
    plt.tight_layout()
    plt.show()

