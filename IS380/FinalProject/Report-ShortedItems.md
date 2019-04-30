```sql
prompt
prompt *********************************
prompt ******* SHORT SHIP REPORT *******
prompt *********************************

column P heading 'Product Number' format 99999;
column N heading 'Product Name' format a30;
column S heading 'ShortShip QTY' format 999999;
column A heading 'ShortShip Amount' format $999,999.99;

select ORDERS.ProductNum P, ProductDesc N, sum(OrderQTY - ShipQTY) S, sum(OrderAmount - ShipAmount) A
from ORDERS, PRODUCTS 
where OrderStatus = 'CLOSED'
and ShipQTY < OrderQTY
and ORDERS.ProductNum = PRODUCTS.ProductNum
group by ORDERS.ProductNum, ProductDesc;
```
