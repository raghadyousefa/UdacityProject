import time
import pandas as pd
import numpy as np

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york city': 'new_york_city.csv',
              'washington': 'washington.csv' }

def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    print('Hello! Let\'s explore some US bikeshare data!')
    # TO DO: get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    while True:
        city= input("Enter city  (chicago, new york city, washington ").lower()
        if city in ("chicago", "new york city", "washington"):
            break
        else:
            print("pleas enter raight city")


    # TO DO: get user input for month (all, january, february, ... , june)

    while True:
        month= input("Enter month('all', 'January', 'February', 'March', 'April', 'May', 'Jun')").lower()
        if month  in  ('january', 'february', 'march', 'april', 'may', 'jun'):
            break
        else:
            print("pleas enter raight month")


    # TO DO: get user input for day of week (all, monday, tuesday, ... sunday)
    while True:
        day= input("Enter day of week (all, monday, tuesday, wednesday, thursday, saturday, friday, sunday)").lower()
        if day in ("suterday", "sunday", "monday", "tuesday", "friday", "wednesday", "thursday", "all"):
            break
        else:
            print("pleas enter raight day")


    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
    df - Pandas DataFrame containing city data filtered by month and day
    """
    if city == 'new york city':
        df = pd.read_csv('new_york_city.csv')
        df['Start Time'] = pd.to_datetime(df['Start Time'])
        df['month'] = df['Start Time'].dt.month
        df['day'] = df['Start Time'].dt.dayofweek
    elif city == 'chicago':
        df = pd.read_csv('chicago.csv')
        df['Start Time'] = pd.to_datetime(df['Start Time'])
        df['month'] = df['Start Time'].dt.month
        df['day'] = df['Start Time'].dt.dayofweek
    elif city == 'washington':
        df = pd.read_csv('washington.csv')
        df['Start Time'] = pd.to_datetime(df['Start Time'])
        df['month'] = df['Start Time'].dt.month
        df['day'] = df['Start Time'].dt.dayofweek



        if month != 'all':

            months = ['january', 'february', 'march', 'april', 'may', 'jun']

            month = months.index(month) + 1



            df = df[df['month'] == month]



        if day != 'all':

            days = ["monday", "tuesday", "friday", "wednesday", "thursday", "suterday", "sunday"]

            day = days.index(day)



            df = df[df['day'] == day]


    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # TO DO: display the most common month
    common_month = df['month'].mode()[0]
    print('Most Popular month:', common_month)


    # TO DO: display the most common day of week
    common_day = df['day'].mode()[0]
    print('Most Popular day:', common_day)


    # TO DO: display the most common start hour

    df['hour'] = df['Start Time'].dt.hour

    popular_hour = df['hour'].mode()[0]

    print('Most Popular Start Hour:', popular_hour)







    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # TO DO: display most commonly used start station
    popular_start_station = df['Start Station'].mode()[0]

    print('Most Popular Start Station:', popular_start_station)

    # TO DO: display most commonly used end station
    popular_end_station = df['End Station'].mode()[0]

    print('Most Popular End Station:', popular_end_station)

    # TO DO: display most frequent combination of start station and end station trip
    df['combination']= df['Start Station'] + df['End Station']
    combination = df['combination'].mode()
    print('most frequent combination of start station and end station trip', combination)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # TO DO: display total travel time
    total_time =  df['Trip Duration'].sum()
    print('Total travel time:', total_time)

    # TO DO: display mean travel time
    mean_time =  df['Trip Duration'].mean()
    print('Mean travel time:', mean_time)



    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # TO DO: Display counts of user types
    user_types = df['User Type'].value_counts()

    print('Counts of user type', user_types)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


    # TO DO: Display counts of gender
    try:
        gender = df['Gender'].value_counts()

        print('Counts of gender', gender)

    # TO DO: Display earliest, most recent, and most common year of birth
        birth_year = df['Birth Year'].mode()
        earliest_year = df['Birth Year'].min()
        recent_year = df['Birth Year'].max()
        print('earliest birth year', earliest_year)
        print('Most recent birth year', recent_year)
        print('Most common birth year', birth_year)
    except KeyError:
        print(' washington does not hava gender and birth year col')



def viewdata(df):

    view_data = input('\Would you like to view 5 rows of individual trip data? Enter yes or no\n')
    start_loc = 0
    while (view_data.lower() == 'yes'):
        print(df.iloc[start_loc : start_loc+5])
        start_loc += 5
        view_display = input("Do you wish to continue?: ").lower()

        if view_display.lower() == 'no':
            break

def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)

        viewdata(df)

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break;


if __name__ == "__main__":
	main()
