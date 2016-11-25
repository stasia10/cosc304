DROP TABLE Invoice;
DROP TABLE Account;
DROP TABLE OrderedProduct;
DROP TABLE Greenhouse;
DROP TABLE Grow;
DROP TABLE warehouse;
DROP TABLE Rating;
DROP TABLE Employee;
DROP TABLE Product;
DROP TABLE CactiSpecies;
DROP TABLE WorksAt;

CREATE TABLE Account (
username  VARCHAR(50),
pass  VARCHAR(50) NOT NULL,
fullName  VARCHAR(50) NOT NULL,
billingAddress  VARCHAR(100) NOT NULL,
shippingAddres  VARCHAR(100) NOT NULL,
preferredPayment  VARCHAR(75),
accountType  VARCHAR(10) CHECK (accountType IN ('Customer', 'Admin', 'Supervisor')),
email  VARCHAR(75) NOT NULL,
phone  VARCHAR(10),
PRIMARY KEY(username));

CREATE TABLE Warehouse (
     whouseName  VARCHAR(20),
     whouseLocation  VARCHAR(80) NOT NULL,
     PRIMARY KEY (whouseName));

CREATE TABLE Invoice (
orderId  VARCHAR(50),
totalAmount  DECIMAL(9,2) CHECK (totalAmount>=0),
weight  DECIMAL(9, 3) CHECK (weight>=0),
orderDate  DATE NOT NULL,
paymentType  VARCHAR(50),
shipDate  DATE NOT NULL,
shipType  VARCHAR(50) NOT NULL,
expectedDelivery  DATE,
accountUsername  VARCHAR(50) NOT NULL,
whouseName  VARCHAR(20) NOT NULL,
PRIMARY KEY (orderId),
FOREIGN KEY (accountUsername) REFERENCES Account (username)
    ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName)
    ON DELETE CASCADE ON UPDATE CASCADE );
    
    
CREATE TABLE Product (
productId  VARCHAR(50),
weight  DECIMAL(5,2) NOT NULL,
productName  VARCHAR(50) NOT NULL,
price  DECIMAL (9,2) NOT NULL,
Inventory  INTEGER,
PRIMARY KEY (productId));


CREATE TABLE OrderedProduct (
productId    VARCHAR(50),
orderId  VARCHAR(50),
quantity  INTEGER CHECK (quantity >= 0),
PRIMARY KEY (productId, orderId),
FOREIGN KEY (productId) REFERENCES Product (productId)
    ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (orderId) REFERENCES Invoice (orderId)
    ON DELETE NO ACTION ON UPDATE CASCADE);



CREATE TABLE Greenhouse (
ghouseId   VARCHAR(50),
ghouseLocation   VARCHAR(80) NOT NULL,
whouseName VARCHAR(20) NOT NULL,
PRIMARY KEY (ghouseId),
FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName)
    ON DELETE NO ACTION ON UPDATE CASCADE);

CREATE TABLE CactiSpecies (
productId  VARCHAR(50),
species  VARCHAR(50),
food  VARCHAR(50) NOT NULL,
sunLevel  INTEGER CHECK (sunLevel BETWEEN 1 and 10),
waterLevel  INTEGER CHECK (waterLevel BETWEEN 1 and 10),
PRIMARY KEY (species, productId),
FOREIGN KEY (productId) REFERENCES Product (productId)
    ON DELETE NO ACTION ON UPDATE CASCADE);
    

CREATE TABLE Grow (
ghouseId  VARCHAR(50),
productId  VARCHAR(50),
species  VARCHAR(50),
PRIMARY KEY (ghouseId, productId, species),
FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId)
    ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (species, productId) REFERENCES CactiSpecies (species, productId)
    ON DELETE NO ACTION ON UPDATE CASCADE);


CREATE TABLE Rating(
accountUser  VARCHAR(50),
productId  VARCHAR(50), 
stars  INTEGER CHECK(stars BETWEEN 0 and 5),
review  VARCHAR(150),
PRIMARY KEY(accountUser, productId),
FOREIGN KEY(productId) REFERENCES Product(productId)
    ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY(accountUser) REFERENCES Account(username)
    ON DELETE NO ACTION ON UPDATE CASCADE);


CREATE TABLE Employee (
empId  VARCHAR(50),
empName  VARCHAR(50) NOT NULL,
title  CHAR(2) CHECK (title IN ('AD', 'SP', 'GH', 'WH')),
empSuperId  VARCHAR(50),
whouseName  VARCHAR(20),
PRIMARY KEY(empId),
FOREIGN KEY (whouseName) REFERENCES Warehouse(whouseName)
    ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (empSuperId) REFERENCES Employee(empId)
    ON DELETE NO ACTION ON UPDATE NO ACTION);
    
    
CREATE TABLE WorksAt (
ghouseId  VARCHAR(50),
empId  VARCHAR(50),
PRIMARY KEY(ghouseId, empId),
FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId)
    ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (empId) REFERENCES Employee (empId)
    ON DELETE NO ACTION ON UPDATE CASCADE);

