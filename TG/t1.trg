CREATE OR ALTER trigger auto_incr_wt for db_wagon_types
active before insert
AS
begin
    select max(db_wagon_types.id) from db_wagon_types into NEW.id;
    NEW.id = NEW.id + 1;
end
