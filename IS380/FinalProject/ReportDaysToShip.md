```sql
prompt
prompt
prompt ************************************
prompt ******* AVERAGE DAYS TO SHIP *******
prompt ************************************
prompt

column W heading "Warehouse" format 999999999;
column C heading "City" format a15;
column S heading "State" format a5;
column D heading "AverageDaysToShip" format 999999.99;

select ORDERS.WH_Code W, City C, State S, avg(trunc(ShipDate) - trunc(OrderDate)) D
from ORDERS, WAREHOUSES, CITY_STATE
where OrderStatus = 'CLOSED'
and ORDERS.WH_Code = WAREHOUSES.WH_Code
and WAREHOUSES.WH_ZipCode = CITY_STATE.ZipCode
group by ORDERS.WH_Code, City, State;
```
