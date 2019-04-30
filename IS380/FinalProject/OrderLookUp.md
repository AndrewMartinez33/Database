```sql
prompt
prompt ****************************
prompt ******* ORDER DETAIL *******
prompt ****************************
prompt

accept vOrderNum prompt 'Please Enter the Order Number: ';

prompt

select 'Order Number: '||OrderNum
	from ORDERS
	where OrderNum = &vOrderNum;
select 'Order Status: '||OrderStatus
	from ORDERS
	where OrderNum = &vOrderNum;

select 'Customer Number: '||CustNum
	from ORDERS
	where OrderNum = &vOrderNum;
select '	'||initcap(CustLastName)||', '||initcap(CustFirstName)
	from ORDERS, CUSTOMERS
	where OrderNum = &vOrderNum
	and ORDERS.CustNum = CUSTOMERS.CustNum;
select '	'||CustShipAddress
	from ORDERS, CUSTOMERS
	where OrderNum = &vOrderNum
	and ORDERS.CustNum = CUSTOMERS.CustNum;
select '	'||initcap(City)||', '||initcap(State)||' '||CustZipCode
	from ORDERS, CUSTOMERS, CITY_STATE
	where OrderNum = &vOrderNum
	and ORDERS.CustNum = CUSTOMERS.CustNum
	and CustZipCode = ZipCode;
select '	('||substr(CustPhone,1,3)||') '||substr(CustPhone,4,3)||'-'||substr(CustPhone,7,4)
	from ORDERS, CUSTOMERS
	where OrderNum = &vOrderNum
	and ORDERS.CustNum = CUSTOMERS.CustNum;

prompt

select 'Product Number: '||ProductNum
	from ORDERS
	where OrderNum = &vOrderNum;
select '	Item Description: '||ProductDesc
	from ORDERS, PRODUCTS
	where OrderNum = &vOrderNum
	and ORDERS.ProductNum = PRODUCTS.ProductNum;
select '	Unit Price: $'||UnitPrice
	from ORDERS
	where OrderNum = &vOrderNum;

prompt

select 'Order Date: '||OrderDate
	from ORDERS
	where OrderNum = &vOrderNum;
select 'Shipping Date: '||ShipDate
	from ORDERS
	where OrderNum = &vOrderNum;
	

select '	Quantity Ordered: '||OrderQTY
	from ORDERS
	where OrderNum = &vOrderNum;
select '	Amount Ordered: $'||OrderAmount
	from ORDERS
	where OrderNum = &vOrderNum;
select '	Quantity Shipped: '||ShipQTY
	from ORDERS
	where OrderNum = &vOrderNum;
select '	Amount Shipped: $'||ShipAmount
	from ORDERS
	where OrderNum = &vOrderNum;

prompt

select 'Shipping Warehouse: '||WH_Code
	from ORDERS
	where OrderNum = &vOrderNum;
select '	'||WH_Address
	from ORDERS, WAREHOUSES
	where OrderNum = &vOrderNum
	and ORDERS.WH_Code = WAREHOUSES.WH_Code;
select '	'||initcap(City)||', '||initcap(State)||' '||WH_ZipCode
	from ORDERS, WAREHOUSES, CITY_STATE
	where OrderNum = &vOrderNum
	and ORDERS.WH_Code = WAREHOUSES.WH_Code
	and WH_ZipCode = ZipCode;
select '	('||substr(WH_Phone,1,3)||') '||substr(WH_Phone,4,3)||'-'||substr(WH_Phone,7,4)
	from ORDERS, WAREHOUSES
	where OrderNum = &vOrderNum
	and ORDERS.WH_Code = WAREHOUSES.WH_Code;
 ```
