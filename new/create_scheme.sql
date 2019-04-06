drop function if exists generate_rides;
drop function if exists apply_shift_day_template;
drop table if exists suspension;
drop table if exists planned_ride;
drop table if exists shift_day;
drop table if exists bus;
drop table if exists timetable;
drop table if exists stations_of_path;
drop table if exists path;
drop table if exists route;
drop table if exists station;
drop table if exists category;


create table if not exists category (
    category_id serial,
    name varchar(255) not null,
    primary key (category_id)
);

insert into category(name)
values('workday'), ('schoolday'), ('saturday'), ('sunday_holiday');


create table if not exists station (
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
    -- needed because a path might be different depending on workday / schoolday / ..
    category_id integer not null,
    path_description varchar(255),

    primary key (path_id),
    foreign key (route_id) references route(route_id),
    foreign key (category_id) references category(category_id)
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
    constraint capacity_gt_zero check (capacity >= 0),
    constraint seats_gt_zero check (seats >= 0),
    constraint capacity_gt_seats check (capacity >= seats)
);


create table if not exists shift_day (
    shift_day_id serial,
    bus_id integer,
    category_id integer,
    -- each combination of date and name SHOULD be unique for a better overview
    -- it's not a must, the user is responsible for it
	  date date not null,
    name varchar(255) not null,
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

-- first param: date, second: category_name
create function generate_rides(date date, category_name text) returns void
  AS $$
    insert into planned_ride(path_ride_id, date, shift_day_id)
    select path_ride_id, date as date, null as shift_day_id
    from timetable inner join path on timetable.path_id = path.path_id
    where timetable.category_id = (select category_id from category where name = category_name);
  $$
language sql;



-- first param: old shift_day_id (template), second: new shift_day_id (must already exist), third: date of day (rides must already be generated before calling this!)
create function apply_shift_day_template(template_shift_day_id integer, new_shift_day_id integer, date_ date) returns void
  AS $$
    update planned_ride
    set shift_day_id = new_shift_day_id
  where (path_ride_id in (select path_ride_id from planned_ride P where P.shift_day_id = template_shift_day_id)) and date = date_;
  $$
language sql;
