-- ettaylor

-- CREATE
CREATE DATABASE ettaylor
GO
USE ettaylor
GO
CREATE TABLE MsClothesType(
	ClothesTypeId CHAR(5) PRIMARY KEY CHECK(ClothesTypeId LIKE 'CT[0-9][0-9][0-9]'),
	ClothesTypeName VARCHAR(50) NOT NULL
)

CREATE TABLE MsClothes(
	ClothesId CHAR(5) PRIMARY KEY CHECK(ClothesId LIKE 'CL[0-9][0-9][0-9]'),
	ClothesTypeId CHAR(5) FOREIGN KEY REFERENCES MsClothesType(ClothesTypeId) ON DELETE CASCADE ON UPDATE CASCADE,
	ClothesName	VARCHAR(100) NOT NULL,
	ClothesPrice INT NOT NULL,
	ClothesSize VARCHAR(5) NOT NULL
)

CREATE TABLE MsCustomer(
	CustomerId CHAR(5) PRIMARY KEY CHECK(CustomerId LIKE 'CM[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerPhone VARCHAR(12) NOT NULL,
	CustomerDOB DATE NOT NULL
)

CREATE TABLE MsStaff(
	StaffId CHAR(5) PRIMARY KEY CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffAddress VARCHAR(255) NOT NULL,
	StaffPhone VARCHAR(12) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffSalary INT NOT NULL,
	StaffGender VARCHAR(10) NOT NULL
)

CREATE TABLE TrSalesHeader(
	SalesId CHAR(5) PRIMARY KEY CHECK(SalesId LIKE 'SA[0-9][0-9][0-9]'),
	CustomerId CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
	StaffId CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
	SalesDate DATE NOT NULL
)

CREATE TABLE TrSalesDetail(
	SalesId CHAR(5) FOREIGN KEY REFERENCES TrSalesHeader(SalesId) ON UPDATE CASCADE ON DELETE CASCADE,
	ClothesId CHAR(5) FOREIGN KEY REFERENCES MsClothes(ClothesId) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL,
	PRIMARY KEY(SalesId, ClothesId)
)


-- INSERT 

INSERT INTO MsCustomer VALUES
('CM001','Brenda Ccomini', '81 Kinsman Street', '081938502819', '07-21-1999'),
('CM002','Helenelizabeth Corbally', '2 Aberg Parkway', '081938501823', '06-22-2000'),
('CM003','Jessey Golder', '9 Fordem Street', '081932392192', '10-31-1998'),
('CM004','Rozanna Richel', '730 Longview Street', '081985010527', '09-14-2001'),
('CM005','Deny Faireclough', '38402 Daystar Point', '081381840192','05-16-2000'),
('CM006','Ericka Dosdill', '5 Union Terrace', '081931422292','06-09-2002'),
('CM007','Mora Ricardot', '6 South Hill', '081910022292', '02-06-2001'),
('CM008','Tiphany Tothacot', '7 Melby Road', '081938201042', '06-18-1999'),
('CM009','Susanne Wherton', '046 Jenna Hill', '081938104192', '11-10-2000'),
('CM010','Cinderella O''Shea', '89 Moose Street', '08183104822', '08-05-2001')


INSERT INTO MsStaff VALUES
('SF001', 'Marguerite Joselevitch', '03607 Sullivan Alley', '082810473920', '04-27-2021', 4900000, 'Female'),
('SF002', 'Jerrie Drew-Clifton', '8366 Vahlen Circle', '082810410520', '08-07-2020', 5800000, 'Male'),
('SF003', 'Herta Bennet', '1785 Johnson Center', '082820411920', '07-02-2020', 4000000, 'Male'),
('SF004', 'Larine MacIlhargy', '4 Sunfield Pass', '082810401120', '04-13-2021', 4100000, 'Female'),
('SF005', 'Teresa Tumelty', '37 Schurz Way', '082815821920', '11-09-2021', 5020000, 'Female'),
('SF006', 'Hilton Ansteys', '44676 Crescent Oaks Point','082815017920',  '06-05-2020', 6240000, 'Male'),
('SF007', 'Bartram Oakeshott', '7700 Upham Parkway', '08281047610', '10-10-2020', 7430000, 'Male'),
('SF008', 'Wyatan Fereday', '2 Hovde Street', '082810672920', '08-30-2020', 5040000, 'Male'),
('SF009', 'Cami Fyfe', '58 Burrows Avenue', '082810105720', '10-22-2021', 4260000, 'Female'),
('SF010', 'Beniamino Scoone', '0 Jenna Parkway', '082882013920', '09-07-2020', 7600000, 'Male')


INSERT INTO MsClothesType VALUES
('CT001', 'Dress'),
('CT002', 'T-Shirt'),
('CT003', 'Sweater'),
('CT004', 'Hoodie'),
('CT005', 'Blouse')


INSERT INTO MsClothes VALUES
('CL001', 'CT001', 'Aryn Dress', 441000, 'S'),
('CL002', 'CT004', 'Crissie Hoodie', 231000, 'M'),
('CL003', 'CT003', 'Max Sweater', 233000, 'XL'),
('CL004', 'CT005', 'Fredra Blouse', 140000, 'L'),
('CL005', 'CT001', 'Barbee Dress', 158000, 'S'),
('CL006', 'CT005', 'Cherey Blouse', 363000, 'M'),
('CL007', 'CT002', 'Nananne T-Shirt', 244000, 'XS'),
('CL008', 'CT003', 'Benito Sweater', 247000, 'XXL'),
('CL009', 'CT005', 'Wini Blouse', 242000, 'XXS'),
('CL010', 'CT001', 'Roley Dress', 264000, 'L')


INSERT INTO TrSalesHeader VALUES
('SA001', 'CM002', 'SF002', '03/17/2021'),
('SA002', 'CM004', 'SF005', '08/23/2021'),
('SA003', 'CM007', 'SF001', '07/20/2021'),
('SA004', 'CM001', 'SF006', '11/03/2021'),
('SA005', 'CM009', 'SF008', '09/04/2021'),
('SA006', 'CM002', 'SF009', '09/17/2021'),
('SA007', 'CM005', 'SF002', '06/16/2021'),
('SA008', 'CM006', 'SF001', '03/09/2021'),
('SA009', 'CM003', 'SF009', '08/15/2021'),
('SA010', 'CM010', 'SF010', '10/12/2021'),
('SA011', 'CM009', 'SF008', '10/11/2021'),
('SA012', 'CM003', 'SF004', '10/09/2021')


INSERT INTO TrSalesDetail VALUES
('SA001', 'CL002', 1),
('SA002', 'CL005', 3),
('SA003', 'CL010', 4),
('SA004', 'CL004', 2),
('SA005', 'CL005', 3),
('SA006', 'CL009', 2),
('SA007', 'CL008', 3),
('SA008', 'CL006', 4),
('SA009', 'CL006', 2),
('SA010', 'CL001', 1),
('SA011', 'CL005', 1),
('SA012', 'CL001', 4)