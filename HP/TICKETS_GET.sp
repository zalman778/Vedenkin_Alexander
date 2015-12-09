create or alter procedure TICKETS_GET (
    P_LIMIT integer)
returns (
    NW_ROUTE integer)
as
declare variable TMP2 integer = 0;
declare variable TMP0 date = '01.01.2016';
declare variable TMP1 date = '01.02.2016';
BEGIN
  while (tmp2 < 12) do
  begin
    FOR select id_route from schedule, (select id_schedule, price from tickets,
    (select id_ticket from tickets_sold) where tickets.id = id_ticket)
    where schedule.id = id_schedule and schedule.st_date between :tmp0
    and :tmp1 group by id_route having sum(price) > :p_limit into :nw_route do
      BEGIN
        SUSPEND;
      END
    tmp0 = dateadd(month, 1, tmp0);
    tmp1 = dateadd(month, 1, tmp0);
    tmp2 = tmp2 + 1;
  end
END
