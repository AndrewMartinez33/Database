```sql
prompt
prompt **************************
prompt ******* OPEN ORDER *******
prompt **************************
prompt

select 'Today''s Date: ', sysdate 
	from dual;

accept vCustNum prompt 'Enter the Customer Number: ';
select '	Customer Name: '||initcap(CustLastName)||', '||initcap(CustFirstName)
	from CUSTOMERS
	where CustNum = &vCustNum;
select '	Shipping Address: '||CustShipAddress
	from CUSTOMERS
	where CustNum = &vCustNum;
select '	City, State Zip: '||initcap(City)||', '||initcap(State)||' '||ZipCode
	from CUSTOMERS, CITY_STATE
	where CustNum = &vCustNum
	and CustZipCode = ZipCode;
select '	Phone: ('||substr(CustPhone,1,3)||') '||substr(CustPhone,4,3)||'-'||substr(CustPhone,7,4)
	from CUSTOMERS
	where CustNum = &vCustNum;

prompt
accept vProductNum prompt 'Enter the Product Number: ';
select '	Product Number: '||ProductNum
	from PRODUCTS
	Where ProductNum = &vProductNum;
select '	Product Description: '||ProductDesc
	from PRODUCTS
	Where ProductNum = &vProductNum;
select '	Unit Price: $'||UnitPrice
	from PRODUCTS
	Where ProductNum = &vProductNum;

prompt
accept vOrderQTY prompt 'Enter Quantity Ordered: ';

select '	Amount Ordered: $'||&vOrderQTY * (select UnitPrice from PRODUCTS where ProductNum = &vProductNum)
	from dual;
 
set heading on

prompt
prompt Please Choose From The Following Warehouses:

column INVENTORY.WH_Code heading 'Warehouses' format a5;
column CityState heading 'City, State' format a20;
column InvQTY heading "Inventory" format 9999;

select INVENTORY.WH_Code, initcap(City)||', '||initcap(State) CityState, InvQTY
	from INVENTORY, WAREHOUSES, CITY_STATE
	where productNum = &vProductNum
	and INVENTORY.WH_Code = WAREHOUSES.WH_Code
	and WH_ZipCode = CITY_STATE.ZipCode;

prompt
accept vWH_Code prompt 'Enter the Warehouse Code: ';

insert into ORDERS(OrderNum, OrderDate, ProductNum, OrderQTY, UnitPrice, OrderAmount, CustNum, WH_Code, OrderStatus, ShipDate, ShipQTY, ShipAmount)
		select Unique_OrderNum.nextval, sysdate, &vProductNum, &vOrderQTY, UnitPrice, &vOrderQTY * UnitPrice, &vCustNum, &vWH_Code, 'OPEN', null, null, null
		from PRODUCTS 
		where ProductNum = &vProductNum;

commit;

set heading off
prompt
prompt******Your Order Status is: OPEN

select '	Your Order Number is: '||Unique_OrderNum.currval
	from dual;
```
