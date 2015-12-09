CREATE OR ALTER trigger control_ticket for tickets_sold
active before delete or update
AS
begin
    if (OLD.id in (select tickets_sold.id_pass from tickets_sold)) then
        exception;
end
