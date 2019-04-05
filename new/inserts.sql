insert into station(station_name)
values ('A'), ('B'), ('C');

insert into route(route_number, description)
values
    ('Route 1', 'A -> B -> C and back');



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
    );


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

-- get stations of path A -> B -> C
select *
from stations_of_path
where path_id = (select path_id from path where path_description = 'A -> B -> C')
order by sort_no asc;