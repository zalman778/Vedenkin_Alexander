CREATE OR ALTER TRIGGER TRIG_DEL_WAG FOR DB_WAGONS
ACTIVE BEFORE DELETE POSITION 0
AS
declare variable tmp int;
begin
    for select id from tickets, (select id_schedule as R1 from db_wagons where
    db_wagons.id = OLD.id) where tickets.id_schedule = R1 into :tmp do
    begin
        update tickets set is_active = 0 where id = :tmp;
    end
end
