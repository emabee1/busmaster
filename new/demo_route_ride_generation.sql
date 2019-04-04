create table if not exists category (
    category_id serial,
    name varchar(255) not null,
    primary key (category_id)
);

insert into category(name)
values('workday'), ('schoolday'), ('saturday'), ('sunday_holiday');


create table if not exists route (
    route_id serial,
    route_number varchar(255),
    description varchar(255),

    primary key (route_id)
);

insert into route(route_number, description)
values('route 1', '(a -> b -> c), (c -> b -> a)'), ('route 2', '(d -> e -> f )');

create table if not exists start_time_of_route_per_category (
    start_id serial,
    category_id integer,
    route_id integer,
    start_time time,
    required_capacity integer,

    primary key (start_id),
    foreign key (category_id) references category(category_id),
    foreign key (route_id) references route(route_id)
);



insert into start_time_of_route_per_category(category_id, route_id, start_time)
values (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 1'),
        '8:00'
        ),
       (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 1'),
        '9:00'
        ),
       (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 1'),
        '10:00'
        );

insert into start_time_of_route_per_category(category_id, route_id, start_time)
values (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 2'),
        '8:30'
        ),
       (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 2'),
        '9:30'
        ),
       (
        (select category_id from category where name = 'workday'),
        (select route_id from route where route_number = 'route 2'),
        '10:30'
        );


-- generate all route_rides for a workday
select current_date as date, *
from start_time_of_route_per_category, route
where category_id = (select category_id from category where name = 'workday');