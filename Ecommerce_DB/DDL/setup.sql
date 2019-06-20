-- DROP DATABASE
USE master;
DROP DATABASE IF EXISTS Ecommerce;
GO

-- CREATE DATABASE
CREATE DATABASE Ecommerce;
GO

-- CREATE SCHEMA
USE Ecommerce;
GO
CREATE SCHEMA customers AUTHORIZATION dbo;
GO
CREATE SCHEMA products AUTHORIZATION dbo;
GO
CREATE SCHEMA orders AUTHORIZATION dbo;
GO


-- CREATE TABLES
USE Ecommerce;
GO
CREATE TABLE customers.customers
(
  customerid CHAR(16) PRIMARY KEY,
  email NVARCHAR(50) NOT NULL UNIQUE,
  firstname NVARCHAR(50) NOT NULL,
  lastname NVARCHAR(50) NOT NULL,
  phone CHAR(10),
  dateofbirth DATE
);

CREATE TABLE customers.addresses
(
  addressid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  addresstype CHAR(5),
  streetaddress NVARCHAR(100),
  zipcode VARCHAR(9),
  cstate VARCHAR(2),
  city NVARCHAR(50),
  country NVARCHAR(50)
);

CREATE TABLE customers.passwords
(
  customerid CHAR(16) PRIMARY KEY FOREIGN KEY REFERENCES customers.customers (customerid),
  cpassword NVARCHAR(25) NOT NULL
);

CREATE TABLE customers.securityQuestions
(
  questionid CHAR(16) PRIMARY KEY,
  questiontext NVARCHAR(50)
);

CREATE TABLE customers.securityAnswers
(
  answerid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  questionid CHAR(16) FOREIGN KEY REFERENCES customers.securityQuestions (questionid),
  answertext NVARCHAR(100)
);

CREATE TABLE customers.paymentInfo
(
  paymentid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  stripeid VARCHAR(16) NOT NULL,
  lastfour CHAR(4) NOT NULL,
  expiration DATE NOT NULL
);

CREATE TABLE customers.rewards
(
  customerid CHAR(16) PRIMARY KEY FOREIGN KEY REFERENCES customers.customers (customerid),
  points INT NOT NULL
);

CREATE TABLE customers.inbox
(
  messageid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  mSubject VARCHAR(25) NOT NULL,
  message NVARCHAR(200) NOT NULL,
  mDate DATE NOT NULL
);

CREATE TABLE customers.credits
(
  customerid CHAR(16) PRIMARY KEY FOREIGN KEY REFERENCES customers.customers (customerid),
  amount DECIMAL(8,2) NOT NULL
);

CREATE TABLE customers.customFields
(
  fieldid CHAR(16) PRIMARY KEY,
  fieldname NVARCHAR(25) NOT NULL,
  fdescription NVARCHAR(50)
);

CREATE TABLE customers.customInfo
(
  infoid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  fieldid CHAR(16) FOREIGN KEY REFERENCES customers.customFields (fieldid),
  information NVARCHAR(50)
);

CREATE TABLE customers.customerservice
(
  issueid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  issuestatus BIT DEFAULT 0,
  datecreated TIMESTAMP,
  dateclosed SMALLDATETIME,
  customertext NVARCHAR(200),
  notes NVARCHAR(200)
);

CREATE TABLE products.products
(
  productid CHAR(16) PRIMARY KEY,
  productstatus BIT DEFAULT 0,
  productname NVARCHAR(50),
  pdescription NVARCHAR(300),
  manufacturer NVARCHAR(30),
  model NVARCHAR(25),
  producttype NVARCHAR(25),
  pcategory NVARCHAR(25),
  productsku VARCHAR(10),
  producturl NVARCHAR(50),
  productreward INT,
  productidentifier NVARCHAR(15),
  isbn10 CHAR(10),
  isbn13 CHAR(13),
  upc VARCHAR(12),
  ispackage BIT DEFAULT 0
);

CREATE TABLE customers.wishlists
(
  listid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  listname VARCHAR(50),
  listdescription VARCHAR(100)
);

CREATE TABLE customers.whishlistItems
(
  itemsid CHAR(16) PRIMARY KEY,
  listid CHAR(16) FOREIGN KEY REFERENCES customers.wishlists (listid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  productcount INT DEFAULT 1
);

CREATE TABLE customers.registries
(
  registryid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  registryname NVARCHAR(50),
  rdescription NVARCHAR(100)
);

CREATE TABLE customers.registryItems
(
  itemsid CHAR(16) PRIMARY KEY,
  registryid CHAR(16) FOREIGN KEY REFERENCES customers.registries (registryid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  productcount INT DEFAULT 1
);

CREATE TABLE products.categories
(
  categoryid CHAR(16) PRIMARY KEY,
  categorytype VARCHAR(4),
  cdescription NVARCHAR(100),
  categoryname NVARCHAR(25),
  parentcategory CHAR(16) FOREIGN KEY REFERENCES products.categories (categoryid)
);

CREATE TABLE products.assignedCategories
(
  assignedid CHAR(16) PRIMARY KEY,
  categoryid CHAR(16) FOREIGN KEY REFERENCES products.categories (categoryid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid)
);

CREATE TABLE products.images
(
  imageid CHAR(16) PRIMARY KEY,
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  imageurl NVARCHAR(50),
  ismain BIT DEFAULT 0
);

CREATE TABLE products.questions
(
  questionid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  questiondate SMALLDATETIME,
  questiontext NVARCHAR(200)
);

CREATE TABLE products.answers
(
  answerid CHAR(16) PRIMARY KEY,
  questionid CHAR(16) FOREIGN KEY REFERENCES products.questions (questionid),
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  commenttext NVARCHAR(50)
);

CREATE TABLE products.discounts
(
  discountid CHAR(16) PRIMARY KEY,
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  discounttype CHAR(4),
  amount MONEY,
  rate INT,
  startdate DATE,
  starttime TIME,
  enddate DATE,
  endtime TIME
);

CREATE TABLE products.packages
(
  packageid CHAR(16) PRIMARY KEY,
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  packageitem CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  itemcount INT
);

CREATE TABLE products.collections
(
  collectionid CHAR(16) PRIMARY KEY,
  title NVARCHAR(25),
  cdescription NVARCHAR(50)
);

CREATE TABLE products.collectionItems
(
  itemid CHAR(16) PRIMARY KEY,
  collectionid CHAR(16) FOREIGN KEY REFERENCES products.collections (collectionid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid)
);

CREATE TABLE products.options
(
  optionid CHAR(16) PRIMARY KEY,
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  productoption NVARCHAR(25),
  odescription NVARCHAR(50)
);

CREATE TABLE products.inventories
(
  inventoryid CHAR(16) PRIMARY KEY,
  optionid CHAR(16) FOREIGN KEY REFERENCES products.options (optionid),
  price MONEY,
  quantity INT,
  minquantity INT
);

CREATE TABLE products.reviews
(
  reviewid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  rating INT CHECK (rating >= 1 AND rating <= 5)
);

CREATE TABLE products.reviewComments
(
  commentid CHAR(16) PRIMARY KEY,
  reviewid CHAR(16) FOREIGN KEY REFERENCES products.reviews (reviewid),
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  commentdate SMALLDATETIME
);

CREATE TABLE products.reviewImages
(
  imageid CHAR(16) PRIMARY KEY,
  reviewid CHAR(16) FOREIGN KEY REFERENCES products.reviews (reviewid),
  imageurl NVARCHAR(50)
);

CREATE TABLE orders.discounts
(
  discountid CHAR(16) PRIMARY KEY,
  discounttype CHAR(4),
  amount MONEY,
  rate INT,
  startdate DATE,
  starttime TIME,
  enddate DATE,
  endtime TIME
);

CREATE TABLE orders.giftCards
(
  giftcardid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  email NVARCHAR(50),
  firstname NVARCHAR(50),
  lastname NVARCHAR(50),
  issuedate DATE,
  amount MONEY
);

CREATE TABLE orders.purchases
(
  orderid CHAR(16) PRIMARY KEY,
  customerid CHAR(16) FOREIGN KEY REFERENCES customers.customers (customerid),
  totalamount MONEY,
  orderdate DATE,
  discountid CHAR(16) FOREIGN KEY REFERENCES orders.discounts (discountid),
  paymenttype VARCHAR(6),
  lastfour VARCHAR(10),
  giftcardid CHAR(16) FOREIGN KEY REFERENCES orders.giftCards (giftcardid)
);

CREATE TABLE orders.purchaseItems
(
  itemid CHAR(16) PRIMARY KEY,
  orderid CHAR(16) FOREIGN KEY REFERENCES orders.purchases (orderid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  price MONEY
);

CREATE TABLE orders.purchaseReturns
(
  returnid CHAR(16) PRIMARY KEY,
  orderid CHAR(16) FOREIGN KEY REFERENCES orders.purchases (orderid),
  returntype VARCHAR(6),
  notes NVARCHAR(50)
);

CREATE TABLE orders.returnItems
(
  itemid CHAR(16) PRIMARY KEY,
  returnid CHAR(16) FOREIGN KEY REFERENCES orders.purchaseReturns (returnid),
  productid CHAR(16) FOREIGN KEY REFERENCES products.products (productid),
  amount MONEY
);
GO