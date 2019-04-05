create table test (
    id serial,
    path text,
    shift_id integer,
    date date,
    primary key (id)
);

insert into test (path, shift_id, date)
values
       ('A -> B', 1, '05.05.2019'),
       ('A -> B', 1, '05.05.2019'),
       ('A -> B', null, '06.05.2019'),
        ('A -> B', null, '06.05.2019');


select * from test;


-- duplicate assignment from shift_id 1 to new shift with id 5 on '06.05.2019'
update test
set shift_id = 5
where (path in (select path from test T where T.shift_id = 1)) and date = '06.05.2019';

delete from test where 1=1;