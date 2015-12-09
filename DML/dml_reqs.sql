--first DML request
create view dml_sel_1 (id_station, stat_cnt) as select first 10 id_station, COUNT(id_station) as stat_cnt from route_stations, 
(select trains.id as tr_id, trains.id_stat_st as st_st_id, trains.id_stat_end as st_en_id from trains, 
(select id_route from schedule where st_date between date '01.01.2016' and date '02.01.2016') 
where trains.id = id_route) where route_stations.id_route = tr_id GROUP BY id_station order BY stat_cnt desc;
commit;

--2nd DML
create view dml_sel_2 (id_route, rt_cnt) as SELECT first 5 id_route, COUNT(id_route) as rt_cnt FROM schedule, 
	(select id_schedule from tickets, (select id_ticket from tickets_sold) where id = id_ticket) 
	WHERE schedule.st_date between date '01.01.2016' and date '02.01.2016' AND schedule.id = id_schedule 
	GROUP BY id_route order by rt_cnt desc;
commit;

--3rd DML
create or alter procedure dml_proc_3
as
BEGIN
  DELETE from db_stations where id not in (select DISTINCT id_station from route_stations order by id_station)
END
