--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2
-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET client_min_messages = warning;
-- SET row_security = off;

--
-- Data for Name: bus; Type: TABLE DATA; Schema: public; Owner: bus_master
--
ALTER SEQUENCE category_category_id_seq RESTART WITH 1;
ALTER SEQUENCE path_path_id_seq RESTART WITH 1;
ALTER SEQUENCE bus_bus_id_seq RESTART WITH 1;
ALTER SEQUENCE planned_ride_planned_ride_id_seq RESTART WITH 1;
ALTER SEQUENCE route_route_id_seq RESTART WITH 1;
ALTER SEQUENCE shift_day_shift_day_id_seq RESTART WITH 1;
ALTER SEQUENCE station_station_id_seq RESTART WITH 1;
ALTER SEQUENCE suspension_suspended_id_seq RESTART WITH 1;
ALTER SEQUENCE timetable_path_ride_id_seq RESTART WITH 1;


DELETE FROM public.stations_of_path WHERE TRUE;
DELETE FROM public.station WHERE TRUE;
DELETE FROM public.planned_ride WHERE TRUE;
DELETE FROM public.shift_day WHERE TRUE;
DELETE FROM public.suspension WHERE TRUE;
DELETE FROM public.bus WHERE TRUE;
DELETE FROM public.path_ride WHERE TRUE;
DELETE FROM public.path WHERE TRUE;
DELETE FROM public.category WHERE TRUE;
DELETE FROM public.route WHERE TRUE;

insert into category(name)
values('workday'), ('schoolday'), ('saturday'), ('sunday_holiday');

INSERT INTO public.bus (licence_plate_number, capacity, seats, operational_area, current_km) VALUES ('BZ-BUS1', 20, 12, 'Schülerfahrten', 29010);
INSERT INTO public.bus (licence_plate_number, capacity, seats, operational_area, current_km) VALUES ('BZ-BUS2', 48, 23, 'Innenstadtfahrten', 12345);
INSERT INTO public.bus (licence_plate_number, capacity, seats, operational_area, current_km) VALUES ('BZ-BUS3', 88, 60, 'Charterfahrten', 1300);


--
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.route (route_number, description) VALUES ('Route 1', 'A -> B -> C and back');
INSERT INTO public.route (route_number, description) VALUES ('Route 2', 'A -> C and back');
INSERT INTO public.route (route_number, description) VALUES ('Route 3', 'D -> D');


--
-- Data for Name: path; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.path (route_id, category_id, path_description) VALUES (1, 1, 'A -> B -> C');
INSERT INTO public.path (route_id, category_id, path_description) VALUES (1, 1, 'C -> B -> A');
INSERT INTO public.path (route_id, category_id, path_description) VALUES (2, 4, 'A -> C');
INSERT INTO public.path (route_id, category_id, path_description) VALUES (2, 4, 'C -> A');
INSERT INTO public.path (route_id, category_id, path_description) VALUES (3, 3, 'D -> D');


--
-- Data for Name: shift_day; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.shift_day (bus_id, category_id, "date", name) VALUES (1, 1, '2019-05-05', 'New bus in the haselstauden area');
INSERT INTO public.shift_day (bus_id, category_id, "date", name) VALUES (1, 1, '2019-05-05', 'Old bus in the schoren area');
INSERT INTO public.shift_day (bus_id, category_id, "date", name) VALUES (2, 3, '2019-05-05', 'City bus in the city');


--
-- Data for Name: timetable; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (1, 2, '09:00:00', 30);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (2, 1, '07:00:00', 20);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (2, 2, '08:00:00', 30);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (1, 1, '08:00:00', 20);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (4, 3, '14:00:00', 20);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (4, 4, '14:45:00', 20);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (3, 5, '09:00:00', 25);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (3, 5, '09:15:00', 25);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (3, 5, '09:30:00', 25);
INSERT INTO public.path_ride (category_id, path_id, start_time, required_capacity)VALUES (3, 5, '09:45:00', 25);


--
-- Data for Name: planned_ride; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (1, '2019-05-05', NULL);
INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (2, '2019-05-05', NULL);
INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (1, '2019-05-05', 1);
INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (2, '2019-05-05', 1);
INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (1, '2019-05-05', 2);
INSERT INTO public.planned_ride (path_ride_id, "date", shift_day_id) VALUES (2, '2019-05-05', 2);


--
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.station (station_name, location_description) VALUES ('B', 'Saegerbruecke');
INSERT INTO public.station (station_name, location_description) VALUES ('C', 'Lustenau Dorfzentrum');
INSERT INTO public.station (station_name, location_description) VALUES ('A', 'Messepark');
INSERT INTO public.station (station_name, location_description) VALUES ('D', 'Bahnhof');
INSERT INTO public.station (station_name, location_description) VALUES ('F', 'Marktplatz');


--
-- Data for Name: stations_of_path; Type: TABLE DATA; Schema: public; Owner: bus_master
--

INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno)  VALUES (2, 2, 2, 10, 3);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (3, 1, 2, 10, 2);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (2, 1, 0, 0, 1);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (4, 2, 0, 0, 1);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (3, 2, 4, 20, 2);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (4, 1, 4, 20, 3);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (2, 3, 0, 0, 1);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (4, 3, 6, 30, 2);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (4, 4, 0, 0, 1);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (2, 4, 6, 30, 2);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (5, 5, 0, 0, 1);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (2, 5, 1, 7, 2);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (3, 5, 2, 10, 3);
INSERT INTO public.stations_of_path (station_id, path_id, distance_from_previous, time_from_previous, sortno) VALUES (5, 5, 1, 6, 4);


--
-- PostgreSQL database dump complete
--

