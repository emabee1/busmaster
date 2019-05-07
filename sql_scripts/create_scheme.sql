drop table if exists suspension cascade;
drop table if exists planned_ride cascade;
drop table if exists shift_day cascade;
drop table if exists shift_day_template cascade;
drop table if exists bus cascade;
drop table if exists path_ride cascade;
drop table if exists stations_of_path cascade;
drop table if exists path cascade;
drop table if exists route cascade;
drop table if exists station cascade;
drop table if exists category cascade;
drop table if exists driver cascade;
drop table if exists driver_shift cascade;

alter sequence if exists bus_bus_id_seq restart;
alter sequence if exists category_category_id_seq restart;
alter sequence if exists path_path_id_seq restart;
alter sequence if exists path_ride_path_ride_id_seq restart;
alter sequence if exists planned_ride_planned_ride_id_seq restart;
alter sequence if exists route_route_id_seq restart;
alter sequence if exists shift_day_shift_day_id_seq restart;
alter sequence if exists shift_day_template_shift_day_template_id_seq restart;
alter sequence if exists station_station_id_seq restart;
alter sequence if exists stations_of_path_stations_of_path_id_seq restart;
alter sequence if exists suspension_suspended_id_seq restart;
alter sequence if exists driver_driver_id_seq restart;
alter sequence if exists driver_shift_driver_shift_id_seq restart;

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


create table if not exists path (
    path_id serial,
    route_id integer,
    path_description varchar(255),
    category_id integer,
    primary key (path_id),
    foreign key (route_id) references route(route_id),
    foreign key (category_id) references category(category_id)
);


create table if not exists stations_of_path (
    stations_of_path_id serial,
    station_id integer,
    path_id integer,
    distance_from_previous integer,
    time_from_previous integer,
    sort_no integer,        -- used to keep order of path in db (-> mapped to list)
    primary key (stations_of_path_id),
    foreign key (station_id) references station(station_id),
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
    constraint capacity_gt_zero check (capacity > 0),
    constraint seats_gt_zero check (seats >= 0),
    constraint capacity_gt_seats check (capacity >= seats)
);


create table if not exists shift_day_template
(
    shift_day_template_id serial,
    bus_id integer,
    category_id integer not null,
    name varchar(255) not null,
    primary key (shift_day_template_id),
    foreign key (category_id) references category(category_id),
    foreign key (bus_id) references bus (bus_id),
    constraint bus_can_only_be_in_one_template_per_category unique (bus_id, category_id)
);


create table if not exists path_ride (
    path_ride_id serial,
    category_id integer not null,
    path_id integer not null,
    shift_day_template_id  integer,
    start_time time not null,
    required_capacity integer,
    primary key (path_ride_id),
    foreign key (category_id) references category(category_id),
    foreign key (path_id) references path(path_id),
    foreign key (shift_day_template_id) references shift_day_template (shift_day_template_id)
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



create table if not exists planned_ride (
    planned_ride_id serial,
    path_ride_id integer,
    date date,
    shift_day_id integer,
    primary key(planned_ride_id),
    foreign key(shift_day_id) references shift_day(shift_day_id),
    foreign key(path_ride_id) references path_ride (path_ride_id)
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

create table if not exists driver (
    driver_id serial,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    primary key (driver_id)
);

create table if not exists driver_shift (
    driver_shift_id serial,
    driver_id integer,
    start_time time not null,
    end_time time not null,
    shift_day_id integer not null,
    primary key (driver_shift_id),
    foreign key (driver_id) references driver(driver_id),
    foreign key (shift_day_id) references shift_day(shift_day_id)
);

create table if not exists customer (
    customer_id serial,
    titel varchar(255),
    firstname varchar(255) not null,
    lastname varchar(255) not null,
    address varchar(255) not null,
    company varchar(255),
    phone varchar(30) not null,
    email varchar(255) not null,
   primary key (customer_id)
); 

create table if not exists charter_ride (
    charter_ride_id serial,
    label varchar(255) not null,
    description varchar(2048),
    from_timestamp timestamp with time zone not null,
    to_timestamp timestamp with time zone not null,
    price money not null,
    status integer not null,
    driver_id_1 integer,
    driver_id_2 integer,
    bus_id integer,
    customer_id integer,
    primary key (charter_ride_id),
    foreign key (driver_id_1) references driver(driver_id),
    foreign key (driver_id_2) references driver(driver_id),
    foreign key (bus_id) references bus(bus_id),
    foreign key (customer_id) references customer(customer_id)
);

create table if not exists equipment (
    equipment_id serial,
    label varchar(255) not null,
    description varchar(2048),
    seats_used integer,
    fixed boolean not null,
    bus_id integer,
    primary key(equipment_id),
    foreign key (bus_id) references bus(bus_id)
);

create table if not exists charter_ride_equipment(
    charter_ride_equipment_id serial,
    charter_ride_id integer not null,
    equipment_id integer not null,
    primary key (charter_ride_equipment_id),
    foreign key (charter_ride_id) references charter_ride(charter_ride_id),
    foreign key (equipment_id) references equipment(equipment_id)
);
