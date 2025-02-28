CREATE TABLE students.Calls(
CallID VARCHAR(50) NOT NULL PRIMARY KEY,
CustomerID VARCHAR(50) NOT NULL,
AgentID VARCHAR(50) NOT NULL,
CallDuration INT,
CallIssueID VARCHAR(50) NOT NULL,
DaysToResolve INT,
IssueStatus VARCHAR(50),

FOREIGN KEY (CustomerID) REFERENCES students.Customers(CustomerID),
FOREIGN KEY (AgentID) REFERENCES students.Agents(AgentID),
FOREIGN KEY (CallIssueID) REFERENCES students.Issues(IssueID)
) IN tsp01 INDEX IN tsp01;