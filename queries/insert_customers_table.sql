CREATE TABLE students.Customers(
CustomerID VARCHAR(50) NOT NULL PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(100),
Phone VARCHAR(50),
Gender VARCHAR(50),
TotalSpent DECIMAL(10,2),
AccountStatus VARCHAR(50),
CustomerType VARCHAR(50)
) IN tsp01 INDEX IN tsp01;