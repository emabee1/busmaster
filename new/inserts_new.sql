-- insert stations
-- insert stations
insert into station(station_name)
values ('Bhf'), ('Klostergasse'), ('Rathaus'), ('Stadtbad'), ('Sägerbrücke');



-- create new route 1
insert into route(route_number, description)
values
    ('Linie 2', 'Bhf <-> FHV');


-- create new bus
insert into bus(licence_plate_number, capacity, seats, operational_area, current_km)
values
       ('DO-BUS1', 50, 50, 'Linienfahrten', 10000),
       ('DO-BUS2', 50, 20, 'Linienfahrten', 30000),
       ('DO-BUS3', 50, 50, 'Linienfahrten', 50000);


-- add paths to routes
insert into path(route_id, category_id, path_description)
values
    (
        (select route_id from route where route_number = 'Linie 2'),
        (select category_id from category where name = 'workday'),
        'Bhf -> FHV'
    ),
    (
        (select route_id from route where route_number = 'Linie 2'),
        (select category_id from category where name = 'workday'),
        'FHV -> Bhf'
    );


-- generate path Bhf -> FHV
insert into stations_of_path (station_id, sort_no, path_id, time_from_previous)
values
    (
        (select station_id from station where station_name = 'Bhf'),
        1,
        (select path_id from path where path_description = 'Bhf -> FHV'),
        0
    ),
    (
        (select station_id from station where station_name = 'Klostergasse'),
        2,
        (select path_id from path where path_description = 'Bhf -> FHV'),
        4
    ),
    (
        (select station_id from station where station_name = 'Rathaus'),
        3,
        (select path_id from path where path_description = 'Bhf -> FHV'),
        3
    ),
    (
        (select station_id from station where station_name = 'Stadtbad'),
        4,
        (select path_id from path where path_description = 'Bhf -> FHV'),
        5
    ),
    (
        (select station_id from station where station_name = 'Sägerbrücke'),
        5,
        (select path_id from path where path_description = 'Bhf -> FHV'),
        2
    );

-- generate path FHV -> Bhf
insert into stations_of_path (station_id, sort_no, path_id, time_from_previous)
values
    (
        (select station_id from station where station_name = 'Sägerbrücke'),
        1,
        (select path_id from path where path_description = 'FHV -> Bhf'),
        0
    ),
    (
        (select station_id from station where station_name = 'Stadtbad'),
        2,
        (select path_id from path where path_description = 'FHV -> Bhf'),
        4
    ),
    (
        (select station_id from station where station_name = 'Rathaus'),
        3,
        (select path_id from path where path_description = 'FHV -> Bhf'),
        3
    ),
    (
        (select station_id from station where station_name = 'Klostergasse'),
        3,
        (select path_id from path where path_description = 'FHV -> Bhf'),
        5
    ),
    (
        (select station_id from station where station_name = 'Bhf'),
        4,
        (select path_id from path where path_description = 'FHV -> Bhf'),
        2
    );


insert into shift_day_template(bus_id, category_id, name)
values
       (
        (select bus_id from bus where licence_plate_number = 'DO-BUS1'),
        (select category_id from category where name = 'workday'),
        'Shiftday 1 Template for Workday'
       ),
       (
        (select bus_id from bus where licence_plate_number = 'DO-BUS2'),
        (select category_id from category where name = 'workday'),
        'Shiftday 2 Template for Workday'
       );



-- create path_rides for paths and categories
insert into path_ride(category_id, path_id, shift_day_template_id, start_time, required_capacity)
values
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '8:00',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '9:00',
        50
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '8:30',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '9:30',
        40
    );




select path_ride_id, start_time, required_capacity, shift_day_template.name, category.name as category, path_description, bus.licence_plate_number, bus.capacity
from path_ride
    inner join shift_day_template on path_ride.shift_day_template_id = shift_day_template.shift_day_template_id
    inner join category on path_ride.category_id = category.category_id
    inner join path on path_ride.path_id = path.path_id
    inner join bus on shift_day_template.bus_id = bus.bus_id;



select generate_rides('4.13.2019', 'workday');


select planned_ride_id, planned_ride.date, route.route_number, path.path_description, start_time, required_capacity, category.name as category, shift_day_template.name as template, planned_ride.shift_day_id, shift_day.name, bus.bus_id, licence_plate_number, shift_day.name as shift_day_name
from planned_ride
  inner join path_ride on planned_ride.path_ride_id = path_ride.path_ride_id
  inner join category on category.category_id = path_ride.category_id
  inner join path on path_ride.path_id = path.path_id
  inner join route on path.route_id = route.route_id
  left outer join shift_day on planned_ride.shift_day_id = shift_day.shift_day_id
  left outer join bus on shift_day.bus_id = bus.bus_id
  left outer join shift_day_template on path_ride.shift_day_template_id = shift_day_template.shift_day_template_id
  order by planned_ride.date asc;

