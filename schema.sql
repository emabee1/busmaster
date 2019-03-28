CREATE TABLE IF NOT EXISTS bus_master.category
    (
        category STRING, -- PRIMARY KEY
        description STRING,
        PRIMARY KEY (category)
    );

INSERT INTO bus_master.category (category) VALUES ('workday');
INSERT INTO bus_master.category (category) VALUES ('schoolday');
INSERT INTO bus_master.category (category) VALUES ('saturday');
INSERT INTO bus_master.category (category) VALUES ('sunday_holiday');

CREATE TABLE IF NOT EXISTS bus_master.station
    (
        station_id STRING, -- PRIMARY KEY
        name STRING,
        location_descriptor STRING,
        PRIMARY KEY (station_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.path_station
    (
        path_station_id STRING, -- PRIMARY KEY
        station_id STRING, -- FOREIGN KEY
        path_id STRING, -- FOREIGN KEY
        distance_from_previous INT,
        time_from_previous INT,
        PRIMARY KEY (path_station_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.bus
    (
        bus_id STRING, -- PRIMARY KEY
        capacity INT,
        seats INT,
        operational_area STRING,
        current_km INT,
        PRIMARY KEY (bus_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.suspended
    (
        suspended_id STRING, -- PRIMARY KEY
        bus_id STRING, -- FOREIGN KEY
        start_date TIMESTAMP,
        end_date TIMESTAMP,
        cause STRING,
        PRIMARY KEY (suspended_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.shift_day
    (
        shift_day_id STRING, -- PRIMARY KEY
        date TIMESTAMP,
        category STRING,
        bus_id STRING, -- FOREIGN KEY
        PRIMARY KEY (shift_day_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.timetable
    (
        timetable_id STRING, -- PRIMARY KEY
        valid_from TIMESTAMP,
        valid_to TIMESTAMP,
        PRIMARY KEY (timetable_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.starttime
    (
        starttime_id STRING, -- PRIMARY KEY
        time TIMESTAMP,
        required_capacity INT,
        category_starttimes_id STRING, -- FOREIGN KEY
        PRIMARY KEY (starttime_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.category_starttimes
    (
        category_starttimes_id STRING, -- PRIMARY KEY
        category STRING,
        path_id STRING, -- FOREIGN KEY
        PRIMARY KEY (category_starttimes_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.route
    (
        route_id STRING, -- PRIMARY KEY
        number INT,
        variation STRING,
        timetable_id STRING, -- FOREIGN KEY
        PRIMARY KEY (route_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.path
    (
        path_id STRING, -- PRIMARY KEY
        description STRING,
        route_id STRING, -- FOREIGN KEY
        PRIMARY KEY (path_id)
    );

CREATE TABLE IF NOT EXISTS bus_master.route_ride
    (
        route_ride_id STRING, -- PRIMARY KEY
        shift_day_id STRING, -- FOREIGN KEY
        starttime_id STRING, -- FOREIGN KEY
        route_id STRING, -- FOREIGN KEY
        path_id STRING, -- FOREIGN KEY
        PRIMARY KEY (route_ride_id)
    );
