-- DROP TABLES
DROP TABLE IF EXISTS orders.returnItems;
DROP TABLE IF EXISTS orders.purchaseReturns;
DROP TABLE IF EXISTS orders.purchaseItems;
DROP TABLE IF EXISTS orders.purchases;
DROP TABLE IF EXISTS orders.giftCards;
DROP TABLE IF EXISTS orders.discounts;
DROP TABLE IF EXISTS products.reviewImages;
DROP TABLE IF EXISTS products.reviewComments;
DROP TABLE IF EXISTS products.reviews;
DROP TABLE IF EXISTS products.inventories;
DROP TABLE IF EXISTS products.options;
DROP TABLE IF EXISTS products.collectionItems;
DROP TABLE IF EXISTS products.collections;
DROP TABLE IF EXISTS products.packages;
DROP TABLE IF EXISTS products.discounts;
DROP TABLE IF EXISTS products.answers;
DROP TABLE IF EXISTS products.questions;
DROP TABLE IF EXISTS products.images;
DROP TABLE IF EXISTS products.assignedCategories;
DROP TABLE IF EXISTS products.categories;
DROP TABLE IF EXISTS customers.registryItems;
DROP TABLE IF EXISTS customers.registries;
DROP TABLE IF EXISTS customers.whishlistItems;
DROP TABLE IF EXISTS customers.wishlists;
DROP TABLE IF EXISTS products.products;
DROP TABLE IF EXISTS customers.customerservice;
DROP TABLE IF EXISTS customers.customInfo;
DROP TABLE IF EXISTS customers.customFields;
DROP TABLE IF EXISTS customers.credits;
DROP TABLE IF EXISTS customers.inbox;
DROP TABLE IF EXISTS customers.rewards;
DROP TABLE IF EXISTS customers.paymentInfo;
DROP TABLE IF EXISTS customers.securityAnswers;
DROP TABLE IF EXISTS customers.securityQuestions;
DROP TABLE IF EXISTS customers.passwords;
DROP TABLE IF EXISTS customers.addresses;
DROP TABLE IF EXISTS customers.customers;

-- DROP SCHEMA
DROP SCHEMA IF EXISTS products;
DROP SCHEMA IF EXISTS customers;
DROP SCHEMA IF EXISTS orders;

-- DROP DATABASE
USE master;
DROP DATABASE IF EXISTS Ecommerce;