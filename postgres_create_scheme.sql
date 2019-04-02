CREATE TABLE IF NOT EXISTS station (
    station_id serial,
    station_name varchar(255) not null,
    location_description varchar(255),
    primary key (station_id)
);


create table if not exists bus (
    bus_id serial,
    licence_plate_number varchar(7),
    capacity integer,
    seats integer,
    operational_area varchar(255),
    current_km integer,
    primary key (bus_id),
    constraint current_km_gt_zero check (current_km >= 0),
    constraint capacity_gt_zero check (capacity >= 0)
);

/*
    enum or own table..?
*/
create type category AS enum ('workday', 'schoolday', 'saturday', 'sunday_holiday');


create table if not exists timetable (
    timetable_id serial,
    valid_from date,
    valid_to date,
    primary key (timetable_id),
    constraint valid_from_before_valid_to check (valid_from <= valid_to)
);


create table if not exists shift_day (
    shift_day_id serial,
    bus_id integer,
    shift_date date,
    shift_category category,
    primary key (shift_day_id),
    foreign key (bus_id) references bus(bus_id)
);

create table if not exists suspension (
    suspended_id serial,
    bus_id integer,
    start_date date,
    end_date date,
    cause varchar(255),
    primary key (suspended_id),
    foreign key (bus_id) references bus(bus_id),
    constraint start_date_before_end_date check (end_date >= start_date)
);

create table if not exists category_start_times (
    category_start_time_id serial,
    category_name category,
    primary key (category_start_time_id)
);

create table if not exists start_time (
    start_time_id serial,
    category_start_time_id integer,
    start_time time,
    required_capacity integer,
    primary key (start_time_id),
    foreign key (category_start_time_id) references category_start_times(category_start_time_id)
);

create table if not exists route (
    route_id serial,
    timetable_id integer,
    route_number varchar(255),
    variation varchar(255),

    primary key (route_id),
    foreign key (timetable_id) references timetable(timetable_id)
);

create table if not exists paths (
    path_id serial,
    category_start_time_id integer,
    route_id integer,
    path_description varchar(255),

    primary key (path_id),
    foreign key (category_start_time_id) references category_start_times(category_start_time_id),
    foreign key (route_id) references route(route_id)
);

create table if not exists path_station (
    path_station_id serial,
    path_id integer,
    station_id integer,
    distance_from_previous integer,
    time_from_previous integer,
    primary key (path_station_id),
    foreign key (path_id) references paths(path_id)
    foreign key (station_id) references station(station_id)
);


create table if not exists route_ride (
    route_ride_id serial,
    shift_day_id integer,
    start_time_id integer,
    path_id integer,
    primary key (route_ride_id),
    foreign key (shift_day_id) references shift_day(shift_day_id),
    foreign key (start_time_id) references start_time(start_time_id),
    foreign key (path_id) references paths(path_id)
);

