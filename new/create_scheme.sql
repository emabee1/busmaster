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

create table if not exists route (
    route_id serial,
    route_number varchar(255) not null,
    description varchar(255),

    primary key (route_id)
);

-- path belongs to exactly one route, easier than 1 to n
create table if not exists path (
    path_id serial,
    route_id integer not null,
    category_id integer not null,    --needed because a path might be different depending on workday / schoolday / ..
    path_description varchar(255),

    primary key (path_id),
    foreign key (route_id) references route(route_id)
);

-- select * from stations_of_path
-- where path_id = YY
-- order by sort_no asc;
create table if not exists stations_of_path (
    stations_of_path_id serial,
    station_id integer,
    path_id integer,
    distance_from_previous integer,
    time_from_previous integer,
    sort_no integer,        -- used to keep order of path in db
    primary key (stations_of_path_id),
    foreign key (station_id) references station(station_id),
    foreign key (path_id) references path(path_id)
);

-- Timetable: hier werden Startzeiten für Pfade hinterlegt, abhängig von Category (Wochenende, Werktag, ..)
-- -> daraus lassen sich alle benötigten path_rides generieren pro tag und kategorie 
-- Bsp:
-- generate path rides for workday
-- select current_date, * 
-- from timetable
-- where category_id = (select category_id from category where name = 'workday');

create table if not exists timetable (
    path_ride_id serial,
    category_id integer not null,
    path_id integer not null,
    start_time time not null,
    required_capacity integer,

    primary key (path_ride_id),
    foreign key (category_id) references category(category_id),
    foreign key (path_id) references path(path_id)
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

create table if not exists shift_day (
    shift_day_id serial,
    bus_id integer,
    category_id integer,
	date date,
    primary key (shift_day_id),
    foreign key (bus_id) references bus(bus_id),
    foreign key (category_id) references category(category_id)
);


-- save all planned rides (generated from timetable)
create table if not exists planned_ride (
    planned_ride_id serial,
    -- this path_ride represents a path + category + start_time + needed capacity
    path_ride_id integer,       
    date date,
    shift_day_id integer,

    primary key(planned_ride_id),
    foreign key(shift_day_id) references shift_day(shift_day_id),
    foreign key(path_ride_id) references timetable(path_ride_id)
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

