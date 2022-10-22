USE ettaylor

--1
SELECT
	StaffName = UPPER(StaffName),
	StaffGender,
	StaffSalary
FROM MsStaff
WHERE StaffSalary > 5000000

--2
SELECT
	SalesDate,
	CustomerName,
	CustomerAddress,
	CustomerPhone
FROM TrSalesHeader th JOIN MsCustomer mc
	ON th.CustomerId = mc.CustomerId
WHERE DATENAME(MONTH, SalesDate) = 'September'

--3
SELECT
	ClothesId = REPLACE(mc.ClothesId, 'CL', 'CLOTHES '),
	ClothesName,
	ClothesPrice = CONCAT('Rp. ', ClothesPrice),
	Quantity = SUM(Quantity)
FROM MsClothes mc JOIN TrSalesDetail td
	ON mc.ClothesId = td.ClothesId
WHERE Quantity >= 3
GROUP BY mc.ClothesId, ClothesName, ClothesPrice


--4
SELECT
	mc.CustomerId,
	CustomerName,
	[Average Quantity] = AVG(Quantity),
	[Total Transaction] = COUNT(th.SalesId)
FROM MsCustomer mc JOIN TrSalesHeader th
	ON mc.CustomerId = th.CustomerId
	JOIN TrSalesDetail td
	ON th.SalesId = td.SalesId
WHERE CustomerAddress LIKE '% Street'
	AND DATEDIFF(YEAR, CustomerDOB, GETDATE()) > 20
GROUP BY mc.CustomerId, CustomerName
UNION
SELECT
	mc.CustomerId,
	CustomerName,
	[Average Quantity] = AVG(Quantity),
	[Total Transaction] = COUNT(th.SalesId)
FROM MsCustomer mc JOIN TrSalesHeader th
	ON mc.CustomerId = th.CustomerId
	JOIN TrSalesDetail td
	ON th.SalesId = td.SalesId
WHERE CustomerAddress LIKE '% HILL'
	AND DATEDIFF(YEAR, CustomerDOB, GETDATE()) > 20
GROUP BY mc.CustomerId, CustomerName

--5
SELECT DISTINCT
	ClothesName,
	ClothesTypeName,
	ClothesPrice,
	[Sold in Month] = DATENAME(MONTH, SalesDate)
FROM MsClothes mc JOIN MsClothesType mct
	ON mc.ClothesTypeId = mct.ClothesTypeId
	JOIN TrSalesDetail td 
	ON td.ClothesId = mc.ClothesId
	JOIN TrSalesHeader th
	ON td.SalesId = th.SalesId
WHERE ClothesPrice > 300000
	AND ClothesTypeName IN ('Dress', 'Blouse')

--6
SELECT
	ms.StaffId,
	StaffName = CHARINDEX(StaffName, ' ', SUBSTRING(StaffName, ' ', LEN(StaffName)))
FROM MsStaff ms JOIN TrSalesHeader th
	ON ms.StaffId = th.StaffId
	JOIN TrSalesDetail td
	ON th.SalesId = td.SalesId



--7
CREATE VIEW [Female Staffs]
AS
SELECT
	StaffName = 'Ms. ' + LEFT(StaffName, CHARINDEX(' ', StaffName, 1)),
	StaffAddress,
	StaffPhone,
	StaffDOB,
	StaffGender
FROM MsStaff
WHERE StaffGender = 'Female'

SELECT * FROM [Female Staffs]

--8
CREATE VIEW [Customer that get discount]
AS
SELECT
	CustomerName,
	CustomerAddress,
	CustomerPhone,
	CustomerDOB,
	SUM(ClothesPrice * Quantity) AS [Total Transaction]
FROM MsCustomer mc JOIN TrSalesHeader th
	ON mc.CustomerId = th.CustomerId
	JOIN TrSalesDetail td
	ON td.SalesId = th.SalesId
	JOIN MsClothes ms
	ON ms.ClothesId = td.ClothesId
WHERE YEAR(SalesDate) = 2021
GROUP BY CustomerName, CustomerAddress, CustomerPhone, CustomerDOB
HAVING SUM(ClothesPrice * Quantity) > 700000
ORDER BY [Total Transaction]


--9
ALTER TABLE MsClothes
ADD ClothesDescription VARCHAR(255)

ALTER TABLE MsClothes
ADD CONSTRAINT DescriptionLength CHECK(LEN(ClothesDescription) > 10)

SELECT * FROM MsClothes

--10
BEGIN TRAN
UPDATE MsClothes
SET ClothesPrice = ClothesPrice - 20000 
WHERE ClothesSize IN ('L', 'XL', 'XXL')

ROLLBACK

SELECT * FROM MsClothes