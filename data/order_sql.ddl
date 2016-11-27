DROP TABLE OrderedProduct;
DROP TABLE Invoice;
DROP TABLE Rating;
DROP TABLE Grow;
DROP TABLE WorksAt;
DROP TABLE Greenhouse;
DROP TABLE Employee;
DROP TABLE Account;
DROP TABLE warehouse;
DROP TABLE Product;
DROP TABLE CactiSpecies;


CREATE TABLE Account (
email  VARCHAR(75) PRIMARY KEY,
pass  VARCHAR(50) NOT NULL,
fullName  VARCHAR(50) NOT NULL,
phone  VARCHAR(10),
billingAddress  VARCHAR(100) NOT NULL,
shippingAddres  VARCHAR(100) NOT NULL,
preferredPayment  VARCHAR(75),
accountType  VARCHAR(10) CHECK (accountType IN ('Customer')));


CREATE TABLE Warehouse (
     whouseName  VARCHAR(20),
     whouseLocation  VARCHAR(80) NOT NULL,
     PRIMARY KEY (whouseName));

CREATE TABLE Invoice (
orderId  INT IDENTITY NOT NULL,
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
CONSTRAINT FK_Invoice_Account FOREIGN KEY (accountUsername) REFERENCES Account(email),
CONSTRAINT FK_Invoice_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName));
    
 CREATE TABLE CactiSpecies (
species  VARCHAR(50) PRIMARY KEY,
food  VARCHAR(50) NOT NULL,
sunLevel  INTEGER CHECK (sunLevel BETWEEN 1 and 10),
waterLevel  INTEGER CHECK (waterLevel BETWEEN 1 and 10));   

CREATE TABLE Product (
productId  INT IDENTITY NOT NULL,
weight  DECIMAL(5,2) NOT NULL,
productName  VARCHAR(50) NOT NULL,
species VARCHAR(50),
price  DECIMAL (9,2) NOT NULL,
Inventory  INTEGER,
category CHAR(2) CHECK (category IN ('AC', 'FT', 'CS')),
picture VARCHAR(50),	
PRIMARY KEY (productId),
CONSTRAINT FK_Product_CactiSpecies FOREIGN KEY (species) REFERENCES CactiSpecies (species));


CREATE TABLE OrderedProduct (
productId    INT,
orderId  INT,
quantity  INTEGER CHECK (quantity >= 0),
PRIMARY KEY (productId, orderId),
CONSTRAINT FK_OrderedProduct_Product FOREIGN KEY (productId) REFERENCES Product (productId),
CONSTRAINT FK_OrderedProduct_Invoice FOREIGN KEY (orderId) REFERENCES Invoice (orderId));



CREATE TABLE Greenhouse (
ghouseId   VARCHAR(50),
ghouseLocation   VARCHAR(80) NOT NULL,
whouseName VARCHAR(20) NOT NULL,
PRIMARY KEY (ghouseId),
CONSTRAINT FK_Greenhouse_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName));
    

CREATE TABLE Grow (
ghouseId  VARCHAR(50),
species  VARCHAR(50),
PRIMARY KEY (ghouseId, species),
CONSTRAINT FK_Grow_Greenhouse FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId),
CONSTRAINT FK_Grow_CactiSpecies FOREIGN KEY (species) REFERENCES CactiSpecies (species));


CREATE TABLE Rating(
accountUser  VARCHAR(50),
productId  INT, 
stars  INTEGER CHECK(stars BETWEEN 0 and 5),
review  VARCHAR(150),
PRIMARY KEY(accountUser, productId),
CONSTRAINT FK_Rating_Product FOREIGN KEY(productId) REFERENCES Product(productId),
CONSTRAINT FK_Rating_Account FOREIGN KEY(accountUser) REFERENCES Account(email));


CREATE TABLE Employee (
empId  VARCHAR(50),
empName  VARCHAR(50) NOT NULL,
title  CHAR(2) CHECK (title IN ('AD', 'SP', 'GH', 'WH')),
email  VARCHAR(75) NOT NULL,
pass  VARCHAR(50) NOT NULL
empSuperId  VARCHAR(50),
whouseName  VARCHAR(20),
PRIMARY KEY(empId),
CONSTRAINT FK_Employee_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse(whouseName),
CONSTRAINT FK_Employee_Employee FOREIGN KEY (empSuperId) REFERENCES Employee(empId));
    
    
CREATE TABLE WorksAt (
ghouseId  VARCHAR(50),
empId  VARCHAR(50),
PRIMARY KEY(ghouseId, empId),
CONSTRAINT FK_WorksAt_Greenhouse FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId),
CONSTRAINT FK_WorksAt_Employee FOREIGN KEY (empId) REFERENCES Employee (empId));
   

INSERT INTO CactiSpecies VALUES ('Cereus peruvianus', 'Garden fertilizer', 3, 5);
INSERT INTO CactiSpecies VALUES ('Grafted Gymnocalycium Cultivars', 'Pro-Mix Health Fertilizer', 8, 3);
INSERT INTO CactiSpecies VALUES ('Echinopsis chamaecereus cultivar', 'Garden Fertilizer', 7, 6);
INSERT INTO CactiSpecies VALUES ('Pilosocereus pachycladus', 'Starter Fertilizer', 10, 7);
INSERT INTO CactiSpecies VALUES ('Cereus tetragonus', 'Garden Fertilizer', 6, 8);
INSERT INTO CactiSpecies VALUES ('Austrocylindropuntia subulata monstrose', 'Nutrition Fertilizer', 9, 2);
INSERT INTO CactiSpecies VALUES ('Epiphyllum hybrids', 'Starter Fertilizer', 10, 4);
INSERT INTO CactiSpecies VALUES ('Opuntia microdasys', 'Pro-Mix health Fertilizer', 5, 3);
INSERT INTO CactiSpecies VALUES ('Echinopsis', 'Nutrition Fertilizer', 8, 8);
INSERT INTO CactiSpecies VALUES ('Stenocereus pruinosus', 'Garden Fertilizer', 7, 1);

INSERT INTO Account VALUES('bobsmith@fancycacti.com','pass', 'Bob Smith','2505551011', '444 Fake St, Faketown, BC, Canada V1R 7K6','444 Fake St, BC, Canada V1R 7K6','NULL','Admin')
INSERT INTO Account VALUES('johnjacob@gmail.com','pass', 'John Jacob', '2506827140', '652 Fake Ave, Faketown, BC Canada F5F 6F5','652 Fake Ave, Faketown, BC Canada F5F 6F5','Mastercard','Customer')
INSERT INTO Account VALUES('janedoe@fancycacti.com','pass', 'Jane Doe','2505551211', '8554 Fake St, Faketown, BC Canada G7T 6F7','8554 Fake St, Faketown, BC Canada G7T 6F7','NULL','Supervisor')


DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Cereus peruvianus', 12.99, 10, 'CS', 'cp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Grafted Gymnocalycium Cultivars', 18.99, 10, 'CS', 'ggc.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Echinopsis chamaecereus cultivar', 24.99, 10, 'CS', 'ecc.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Pilosocereus pachycladus', 12.99, 10, 'CS', 'pp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Cereus tetragonus', 28.99, 10, 'CS', 'ct.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Austrocylindropuntia subulata monstrose', 10.00, 10, 'CS', 'asm.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Epiphyllum hybrids', 22.00, 10, 'CS', 'eh.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Opuntia microdasys', 12.99, 10, 'CS', 'om.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Echinopsis', 28.99, 10, 'CS', 'e.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(2.00, 'Cacti', 'Stenocereus pruinosus', 10.00, 10, 'CS', 'sp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Pink Bow', null, 3.00, 10, 'AC', 'pb.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Blue Bow', null, 3.00, 10, 'AC', 'bb.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Yellow Bow', null, 3.00, 10, 'AC', 'yb.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (1.00, 'Brown Pot', null, 10.00, 10, 'AC', 'bp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Grey Pot', null, 10.00, 10, 'AC', 'gp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Black Pot', null, 3.00, 10, 'AC', 'blp.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Black Tie', null, 4.50, 10, 'AC', 'bt.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'Red Tie', null, 4.50, 10, 'AC', 'rt.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (0.50, 'White Tie', null, 4.50, 10, 'AC', 'wt.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (5.00, 'Garden Fertilizer', null, 25.00, 10, 'FT', 'ft.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (5.00, 'Pro-Mix Health Fertilizer', null, 35.00, 10, 'FT', 'ft.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (5.00, 'Starter Fertilizer', null, 20.00, 10, 'FT', 'ft.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES (5.00, 'Nutrition Fertilizer', null, 25.00, 10, 'FT', 'ft.png');
DECLARE @productId INT
INSERT INTO Product (weight, productName, species, price, Inventory, category, picture)
	VALUES(5.00, 'Cacti Soil', null, 15.00, 10, 'FT', 'ft.png');
	
	
INSERT INTO Warehouse VALUES('CactiOne', 'CactiVille');

INSERT INTO Greenhouse VALUES(1, 'CactiVille', 'CactiOne');
INSERT INTO Greenhouse VALUES(2, 'SucculentCity', 'CactiOne');

INSERT INTO Employee VALUES(1, 'Bob Smith', 'AD', NULL, NULL);
INSERT INTO Employee VALUES(2, 'Jane Doe', 'SP', NULL, 'CactiOne');
INSERT INTO Employee VALUES(3, 'Kyla Reid', 'WH', 1, 'CactiOne');
INSERT INTO Employee VALUES(4, 'Megan Kurz', 'SP', NULL, NULL);
INSERT INTO Employee VALUES(5, 'Jared Wright', 'GH', 4, NULL);
INSERT INTO Employee VALUES(6, 'Anastasia Skobkareva', 'GH', NULL, NULL);
INSERT INTO Employee VALUES(7, 'McNeil Bob', 'GH', 6, NULL);


INSERT INTO WorksAt VALUES(1,4);
INSERT INTO WorksAt VALUES(1,5);
INSERT INTO WorksAt VALUES(2,6);
INSERT INTO WorksAt VALUES(2,7);

INSERT INTO Grow VALUES(1,'Cereus peruvianus');
INSERT INTO Grow VALUES(1,'Grafted Gymnocalycium Cultivars');
INSERT INTO Grow VALUES(1,'Pilosocereus pachycladus');
INSERT INTO Grow VALUES(1,'Cereus tetragonus');
INSERT INTO Grow VALUES(1,'Opuntia microdasys');
INSERT INTO Grow VALUES(1,'Echinopsis');
INSERT INTO Grow VALUES(1,'Stenocereus pruinosus');

INSERT INTO Grow VALUES(2,'Cereus peruvianus');
INSERT INTO Grow VALUES(2,'Echinopsis chamaecereus cultivar');
INSERT INTO Grow VALUES(2,'Cereus tetragonus');
INSERT INTO Grow VALUES(2,'Austrocylindropuntia subulata monstrose');
INSERT INTO Grow VALUES(2, 'Epiphyllum hybrids');
INSERT INTO Grow VALUES(2, 'Opuntia microdasys');