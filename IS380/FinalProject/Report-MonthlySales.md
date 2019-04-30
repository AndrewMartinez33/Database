```sql
prompt
prompt ************************************
prompt ******* MONTHLY SALES REPORT *******
prompt ************************************

column OrderMonth heading 'Order|Month' format a10;
column Product heading 'Product No.' format 99999;
column Describe heading 'Product Name' format a30;
column Count heading 'No. of Orders' format 9999;
column Units heading 'Total ' format 999999;
column tAmount heading 'Total Units' format $999,999.99;

select to_char(trunc(O.OrderDate), 'mm/yyyy') OrderMonth, O.ProductNum Product, P.ProductDesc Describe, count(O.OrderNum) Count, sum(O.OrderQTY) Units, sum(O.OrderQTY * O.UnitPrice) tAmount
from ORDERS O, PRODUCTS P
where O.ProductNum = P.ProductNum
group by to_char(trunc(O.OrderDate), 'mm/yyyy'), O.ProductNum, ProductDesc
order by OrderMonth, O.ProductNum, ProductDesc;
```
