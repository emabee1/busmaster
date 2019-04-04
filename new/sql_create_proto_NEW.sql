create table if not exists category (
    category_id serial,
    name varchar(255) not null,
    primary key (category_id)
);

insert into category(name)
values('workday'), ('schoolday'), ('saturday'), ('sunday_holiday');

CREATE TABLE IF NOT EXISTS station (
    station_id serial,
    station_name varchar(255) not null,
    location_description varchar(255),
    primary key (station_id)
);


-- select * from stations_of_path
-- where path_id = YY
-- order by sort_no asc;
create table if not exists stations_of_path (
    path_id serial,
    station_id integer,
    distance_from_previous integer,
    time_from_previous integer,
    sort_no integer,        -- used to keep order of path in db
    primary key (path_id),
    foreign key (path_id) references path(path_id)
);

create table if not exists path (
    path_id serial,
    category_id integer,
    path_description varchar(255),

    primary key (path_id)
);


create table if not exists route (
    route_id serial,
    route_number varchar(255),
    description varchar(255),

    primary key (route_id),
);


-- select * from paths_of_route
-- where route_id = XX;
create table if not exists paths_of_route (

    -- TODO: maybe surrogate key instead of composite
    route_id integer,
    path_id integer,
    primary key (route_id, path_id),
    foreign key (path_id) references path(path_id)
);

-- select * from starttimes_of_category_per_route
-- where route_id = XX and category_id = YY
-- order by start_time asc;
create table if not exists start_time_of_route_per_category (
    start_id serial,
    category_id integer,
    route_id integer,
    start_time time,
    required_capacity integer,

    primary key (start_id),
    foreign key (category_id) references category(category_id),
    foreign key (route_id) references route(route_id)
)

-- ABOVE IS OK
-- -----------------------------------------------------------------

create table if not exists route_ride (
    route_ride_id serial,
    route_id integer,
    path_id integer not null,
    start_id integer not null,
    primary key(route_ride_id),
    foreign key(route_id) references route(route_id),
    foreign key(path_id) references path(path_id),
    foreign key(start_id) references start_time_of_route_per_category(start_id)
);


create table if not exists route_ride_of_shift_day (
    route_ride_id integer,
    shift_day_id integer,
);

create table if not exists shift_day (
    shift_day_id serial,
    bus_id integer,
    category_id integer,
    primary key (shift_day_id),
    foreign key (bus_id) references bus(bus_id),
    foreign key (category_id) references category(category_id)
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




create table if not exists timetable (
    timetable_id serial,
    valid_from date,
    valid_to date,
    primary key (timetable_id),
    constraint valid_from_before_valid_to check (valid_from <= valid_to)
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









create table if not exists route_ride (
    route_ride_id serial,
    shift_day_id integer,
    start_time_id integer,
    path_id integer,
    primary key (route_ride_id),
    foreign key (shift_day_id) references shift_day(shift_day_id),
    foreign key (start_time_id) references start_time(start_time_id),
    foreign key (path_id) references path(path_id)
);

