```sql
create table CITY_STATE(ZipCode number(5) primary key,
			City varchar2(15),
			State varchar2(2));

create table PRODUCTS(ProductNum number(5) primary key,
			ProductDesc varchar2(30),
			UnitPrice number(6,2));

create table CUSTOMERS(CustNum number(5) primary key,
			CustFirstName varchar2(15),
			CustLastName varchar2(15),
			CustPhone number(10),
			CustShipAddress varchar(30),
			CustZipCode number(5),
			constraint CustF1 foreign key (CustZipCode) references CITY_STATE(ZipCode));

create table WAREHOUSES(WH_Code number(5) primary key,
			WH_Address varchar2(30),
			WH_ZipCode number(5),
			WH_Phone number(10),
			constraint WH_F1 foreign key (WH_ZipCode) references CITY_STATE(ZipCode));

create table INVENTORY(ProductNum number(5),
			WH_Code number(5),
			InvQTY number(10),
			primary key (ProductNum, WH_Code),
			constraint InvProF1 foreign key (ProductNum) references PRODUCTS(ProductNum),
			constraint InvProF2 foreign key (WH_Code) references WAREHOUSES(WH_Code));

create table ORDERS(
			OrderNum number(5) primary key,
			OrderDate date,
			ProductNum number(5),
			OrderQTY number(10),
			UnitPrice number(6,2),
			OrderAmount number(10,2),
			CustNum number(5),
			WH_Code number(5),
			OrderStatus varchar2(6),
			ShipDate date,
			ShipQTY number(10),
			ShipAmount number(10,2),
			constraint ProductF1 foreign key (ProductNum) references PRODUCTS(ProductNum),
			constraint CustomerF2 foreign key (CustNum) references CUSTOMERS(CustNum),
			constraint WHouseF3 foreign key (WH_Code) references WAREHOUSES(WH_Code));

create sequence Unique_OrderNum increment by 1 start with 40000;

insert into CITY_STATE
		values(90001, 'Los Angeles', 'CA');
insert into CITY_STATE
		values(90002, 'New York', 'NY');
insert into CITY_STATE
		values(90003, 'Dallas', 'TX');
insert into CITY_STATE
		values(90004, 'Cleaveland', 'OH');
insert into CITY_STATE
		values(90005, 'Las Vegas', 'NV');

insert into PRODUCTS
		values(10001, 'Cherry Bubble Gum 20pack', 1.73);
insert into PRODUCTS
		values(10002, 'Strawberry Bubble Gum 20pack', 1.67);
insert into PRODUCTS
		values(10003, 'Mint Bubble Gum 20pack', 1.51);
insert into PRODUCTS
		values(10004, 'Cool Breeze Bubble Gum 20pack', 1.49);
insert into PRODUCTS
		values(10005, 'Tropical Bubble Gum 20pack', 1.57);

insert into CUSTOMERS
		values(20001, 'Andrew', 'Martinez', 3105554444, '1234 First Avenue', 90001);
insert into CUSTOMERS
		values(20002, 'Barry', 'Allen', 3105550000, '4321 Second Street', 90002);
insert into CUSTOMERS
		values(20003, 'Shaquille', 'O''Neal', 3105551111, '1000 Beverly Avenue', 90003);
insert into CUSTOMERS
		values(20004, 'Kevin', 'Garnett', 3105552222, '1290 State Street', 90004);
insert into CUSTOMERS
		values(20005, 'Stephen', 'Curry', 3105553333, '145 Western Avenue', 90005);

insert into WAREHOUSES
		values(30001, '345 McDonald Avenue', 90001, 3330053190);
insert into WAREHOUSES
		values(30002, '711 McDonald Avenue', 90002, 3330053190);
insert into WAREHOUSES
		values(30003, '779 McDonald Avenue', 90003, 3330053190);
insert into WAREHOUSES
		values(30004, '495 McDonald Avenue', 90004, 3330053190);
insert into WAREHOUSES
		values(30005, '903 McDonald Avenue', 90005, 3330053190);

insert into INVENTORY
		values(10001, 30005, 515);
insert into INVENTORY
		values(10002, 30005, 633);
insert into INVENTORY
		values(10003, 30005, 1003);
insert into INVENTORY
		values(10004, 30005, 457);
insert into INVENTORY
		values(10005, 30005, 982);
insert into INVENTORY
		values(10001, 30004, 732);
insert into INVENTORY
		values(10002, 30004, 189);
insert into INVENTORY
		values(10003, 30004, 177);
insert into INVENTORY
		values(10004, 30004, 156);
insert into INVENTORY
		values(10005, 30004, 333);
insert into INVENTORY
		values(10001, 30003, 268);
insert into INVENTORY
		values(10002, 30003, 773);
insert into INVENTORY
		values(10003, 30003, 555);
insert into INVENTORY
		values(10004, 30003, 348);
insert into INVENTORY
		values(10005, 30003, 834);
insert into INVENTORY
		values(10001, 30002, 569);
insert into INVENTORY
		values(10002, 30002, 677);
insert into INVENTORY
		values(10003, 30002, 702);
insert into INVENTORY
		values(10004, 30002, 843);
insert into INVENTORY
		values(10005, 30002, 194);
insert into INVENTORY
		values(10001, 30001, 244);
insert into INVENTORY
		values(10002, 30001, 444);
insert into INVENTORY
		values(10003, 30001, 344);
insert into INVENTORY
		values(10004, 30001, 745);
insert into INVENTORY
		values(10005, 30001, 904);

insert into ORDERS
		values(Unique_OrderNum.nextval, '19/NOV/16',10001, 35, 1.50, 52.50, 20001, 30001, 'OPEN', null, null, null);
insert into ORDERS
		values(Unique_OrderNum.nextval, '02/DEC/16', 10002, 100, 1.50, 150.00, 20002, 30002, 'OPEN', null, null, null);
insert into ORDERS
		values(Unique_OrderNum.nextval, '22/OCT/16', 10003, 1000, 1.50, 1500.00, 20003, 30003, 'OPEN', null, null, null);
insert into ORDERS
		values(Unique_OrderNum.nextval, '09/NOV/16', 10004, 300, 1.50, 450.00, 20004, 30004, 'OPEN', null, null, null);
insert into ORDERS
		values(Unique_OrderNum.nextval, '11/NOV/16', 10005, 470, 1.50, 705.00, 20005, 30005, 'OPEN', null, null, null);
insert into ORDERS
		values(Unique_OrderNum.nextval, '23/MAR/16',10005, 35, 1.50, 52.50, 20005, 30005, 'CLOSED', '27/MAR/16', 27, 40.50);
insert into ORDERS
		values(Unique_OrderNum.nextval, '07/MAY/16', 10004, 100, 1.50, 150.00, 20003, 30004, 'CLOSED', '10/MAY/16', 91, 136.50);
insert into ORDERS
		values(Unique_OrderNum.nextval, '13/JUL/16', 10002, 1000, 1.50, 1500.00, 20004, 30002, 'CLOSED', '19/JUL/16', 997, 1495.50);
insert into ORDERS
		values(Unique_OrderNum.nextval, '24/AUG/16', 10001, 300, 1.50, 450.00, 20002, 30003, 'CLOSED', '03/SEP/16', 250, 375.00);
insert into ORDERS
		values(Unique_OrderNum.nextval, '17/NOV/16', 10003, 470, 1.50, 705.00, 20001, 30001, 'CLOSED', '27/NOV/16', 456, 684.00);
```
