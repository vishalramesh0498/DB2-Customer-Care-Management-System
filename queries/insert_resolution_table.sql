CREATE TABLE students.Resolution(
ResolutionID VARCHAR(50) NOT NULL PRIMARY KEY,
ResolutionDescription VARCHAR(50),
CustomerID VARCHAR(50) NOT NULL,
IssueID VARCHAR(50) NOT NULL,

FOREIGN KEY (CustomerID) REFERENCES students.Customers(CustomerID),
FOREIGN KEY (IssueID) REFERENCES students.Issues(IssueID)
) IN tsp01 INDEX IN tsp01;