create or alter procedure TICKETS_SEARCH (
    ST_DATE date,
    ID_ST_ST integer,
    ID_ST_EN integer,
    MAX_TIME integer)
returns (
    NW_ROUTE integer)
as
declare variable TMP integer;
BEGIN
  for select R11 from trains, (select R11, id_train from routes,
  (select R11, id_route from schedule, (select id AS R11, id_schedule from tickets) where
  schedule.id = id_schedule and st_date = :st_date) where routes.id = id_route)
  where trains.id = id_train and ((id_stat_end - id_stat_st)*2) < :max_time and
  id_stat_st = :id_st_st and id_stat_end = :id_st_en into :nw_route do
    begin
      SUSPEND;
    end
END
