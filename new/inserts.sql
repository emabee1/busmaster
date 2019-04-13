-- insert stations
insert into station(station_name)
values ('A'), ('B'), ('C');

-- create new route 1
insert into route(route_number, description)
values
    ('Route 1', 'A -> B -> C and back');



-- add paths to routes
insert into path(route_id, category_id, path_description)
values
    (
        (select route_id from route where route_number = 'Route 1'),
        (select category_id from category where name = 'workday'),
        'A -> B -> C'
    ),
    (
        (select route_id from route where route_number = 'Route 1'),
        (select category_id from category where name = 'workday'),
        'C -> B -> A'
    );

-- add stations to path
insert into stations_of_path (station_id, sort_no, path_id)
values
    (
        (select station_id from station where station_name = 'A'),
        1,
        (select path_id from path where path_description = 'A -> B -> C')
    ),
    (
        (select station_id from station where station_name = 'B'),
        2,
        (select path_id from path where path_description = 'A -> B -> C')
    ),
    (
        (select station_id from station where station_name = 'C'),
        3,
        (select path_id from path where path_description = 'A -> B -> C')
    ),

    (
        (select station_id from station where station_name = 'C'),
        3,
        (select path_id from path where path_description = 'C -> B -> A')
    ),
    (
        (select station_id from station where station_name = 'B'),
        2,
        (select path_id from path where path_description = 'C -> B -> A')
    ),
   (
        (select station_id from station where station_name = 'A'),
        1,
        (select path_id from path where path_description = 'C -> B -> A')
    );


-- create new bus
insert into bus(licence_plate_number, capacity, seats, operational_area, current_km)
values
       ('B-BUS1', 20, 12, 'Linienbus', 29010),
       ('B-BUS2', 40, 20, 'Linienbus', 0);


insert into shift_day_template(bus_id, category_id, name)
values
       (
        (select bus_id from bus where licence_plate_number = 'B-BUS1'),
        (select category_id from category where name = 'workday'),
        'Shiftday 1 Template for Workday'
       ),
       (
        (select bus_id from bus where licence_plate_number = 'B-BUS2'),
        (select category_id from category where name = 'workday'),
        'Shiftday 2 Template for Workday'
       );



-- create timetable for paths and categories
insert into path_ride(category_id, path_id, shift_day_template_id, start_time)
values
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'A -> B -> C'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '8:00'
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'C -> B -> A'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '9:00'
    );



select path_ride_id, start_time, required_capacity, shift_day_template.name, category.name as category, path_description, bus.licence_plate_number, bus.capacity
from path_ride
    inner join shift_day_template on path_ride.shift_day_template_id = shift_day_template.shift_day_template_id
    inner join category on path_ride.category_id = category.category_id
    inner join path on path_ride.path_id = path.path_id
    inner join bus on shift_day_template.bus_id = bus.bus_id;



select generate_rides('4.12.2019', 'workday');



-- create shift for 05.05.2019 with bus1
insert into shift_day(bus_id, category_id, date, name)
values (
         (select bus_id from bus where licence_plate_number = 'BZ-BUS1'),
         (select category_id from category where name = 'workday'),
        '05.05.2019',
        'New bus in the haselstauden area'
       );



-- show all planned rides with details
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

select * from timetable;

select *
from planned_ride
inner join path_ride on planned_ride.path_ride_id = path_ride.path_ride_id
left outer join shift_day_template on path_ride.shift_day_template_id = shift_day_template.shift_day_template_id
where date = '04.12.2019';




