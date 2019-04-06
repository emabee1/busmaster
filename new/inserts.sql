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


-- create timetable for paths and categories
insert into timetable(category_id, path_id, start_time)
values
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'A -> B -> C'),
        '8:00'
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'C -> B -> A'),
        '9:00'
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'A -> B -> C'),
        '7:00'
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'C -> B -> A'),
        '8:00'
    );

-- create new bus
insert into bus(licence_plate_number)
values ('BZ-BUS1');


-- create shift for 05.05.2019 with bus1
insert into shift_day(bus_id, category_id, date, name)
values (
         (select bus_id from bus where licence_plate_number = 'BZ-BUS1'),
         (select category_id from category where name = 'workday'),
        '05.05.2019',
        'New bus in the haselstauden area'
       );


-- create another shift for 06.05.2019 with bus1 (shift_day_id = 2)
insert into shift_day(bus_id, category_id, date, name)
values (
         (select bus_id from bus where licence_plate_number = 'BZ-BUS1'),
         (select category_id from category where name = 'workday'),
        '06.05.2019',
        'Old bus in the schoren area'
       );


-- reuse shift_day configuration of shift day one on 05.05.2019
-- and apply it to same rides on 06.05.2019 with shift_day id = 2
update planned_ride
set shift_day_id = 2
where (path_ride_id in (select path_ride_id from planned_ride P where P.shift_day_id = 1)) and date = '06.05.2019';


-- call generate_rides function
select generate_rides('3.3.2019', 'workday');
select generate_rides('4.3.2019', 'workday');
select generate_rides('5.3.2019', 'workday');

-- manually assign rides to shift_day 1 (-> use case)
update planned_ride
set shift_day_id = 1
where planned_ride_id = 1 or planned_ride_id = 2;




-- apply shift_day with id=1 to shift_Day with id=2 on 5.3.2019
select apply_shift_day_template(1, 2, '5.3.2019');


-- show all planned rides with details
select planned_ride_id, planned_ride.date, route.route_number, path.path_description, start_time, required_capacity, category.name as category, planned_ride.shift_day_id, bus.bus_id, licence_plate_number, shift_day.name as shift_day_name
from planned_ride
  inner join timetable on planned_ride.path_ride_id = timetable.path_ride_id
  inner join category on category.category_id = timetable.category_id
  inner join path on timetable.path_id = path.path_id
  inner join route on path.route_id = route.route_id
  left outer join shift_day on planned_ride.shift_day_id = shift_day.shift_day_id
  left outer join bus on shift_day.bus_id = bus.bus_id
  order by planned_ride.date asc;

select * from timetable;
