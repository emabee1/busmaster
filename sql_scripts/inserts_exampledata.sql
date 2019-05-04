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
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '8:30',
        50
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '8:45',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '9:25',
        50
    )(
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '10:00',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Workday'),
        '10:45',
        50
    ),


    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '8:30',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '9:00',
        40
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '9:40',
        30
    ),
    (
        (select category_id from category where name = 'workday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 2 Template for Workday'),
        '10:15',
        40
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Schoolday'),
        '7:00',
        40
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Schoolday'),
        '7:30',
        30
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'Bhf -> FHV'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Schoolday'),
        '7:45',
        40
    ),
    (
        (select category_id from category where name = 'schoolday'),
        (select path_id from path where path_description = 'FHV -> Bhf'),
        (select shift_day_template_id from shift_day_template where name = 'Shiftday 1 Template for Schoolday'),
        '8:15',
        30
    );

