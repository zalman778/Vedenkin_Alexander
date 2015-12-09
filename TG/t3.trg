CREATE OR ALTER TRIGGER ROUTE_ST_CHECK FOR ROUTE_STATIONS
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable tmp int = 0;
declare variable tmp_time time = time '00:00:00';
begin
    select max(route_stations.id) from route_stations into NEW.id;
    NEW.id = NEW.id + 1;
    select COUNT(id) from route_stations WHERE id_route = NEW.id_route and
    id_station = NEW.id_station GROUP by id_route into :tmp;
    if (tmp != 0) then
       exception;
    else
      begin
         select st_cnt, st_time from route_stations WHERE id_route = NEW.id_route
         and st_cnt = (SELECT MAX(st_cnt) from route_stations WHERE
         id_route = NEW.id_route GROUP by id_route) into :tmp, :tmp_time;
         NEW.st_cnt = tmp + 1;
         tmp_time = dateadd(hour, 2, tmp_time);
         NEW.st_time = tmp_time;
      end

end
