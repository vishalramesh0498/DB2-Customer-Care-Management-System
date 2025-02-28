# DB2-Customer-Care-Database-Management
The project focuses on designing and implementing a customer care database using IBM DB2. It included schema design, relational table creation, indexing for faster queries, and establishing entity relationships.


**Step 1: Create a DB2 database on your computer**

Commands: 

```
db2 create database students on c:\
db2 list db directory
db2 get instance
db2 values current user
getmac
```

<img src="images\db creation.png"></img>

<img src="images\current user.png"></img>
 

**Step 2: Research and Prepare Dataset**

-	**Customers** 
    -	CustomerID – PRIMARY KEY – Unique identifier of Customer
        - C001, C002, …, C200
    -	Name – Name of the Customer
    -	Email – Email of the Customer
    -	Phone – Phone Number of the Customer
    -	Gender – Gender of the Customer
        -	Male, Female
    -	TotalSpent – Total Amount Spent by the Customer
    -	AccountStatus – Account Status of the Customer
        -	Active, Inactive
    -	CustomerType – Type of Customer
        -	Regular, Gold, Silver

-	**Agents**
    -	AgentID – PRIMARY KEY – Unique Identifier of Agent
        -	A01, A02, …, A50
    -	FirstName – First Name of Agent
    -	LastName – Last Name of Agent
    -	Email – Email of Agent
    -	Phone – Phone Number of Agent
    -	DepartmentID – Department Agent belong to
        -	D101, D102, D103, D104
    -	Role
        -	Customer Support, Technical Support
    -	Salary – Salary of Agent
    -	State – State from which agent is
    -	Country – Country from which agent is
        -	USA

-	**Calls**
    -	CallID – PRIMARY KEY – Unique identifier of the call
        -	CL001, CL002, …, CL200
    -	CustomerID – FOREIGN KEY – Unique identifier of Customer
        -	C001, C002, …, C200
    -	AgentID – FOREIGN KEY – Unique identifier of Agent
        -	A01, A02, …, A50
    -	CallDuration – Duration of call by agent and customer in minutes
    -	CallIssueID – FOREIGN KEY – Unique identifier specifying the call issue
        -	CI01, CI02, …, CI30
    -	Days to Resolve – Days took to resolve the issue
        -	-1: Not resolved
    -	IssueStatus – Status of the issue
        -	Unresolved, Resolved  

-	**Issues**
    -	IssueID – PRIMARY KEY – Unique identifier of issue
        -	CI01, CI02, …, CI30
    -	IssueDescription – Description of issue

-	**Resolutions**
    -	ResolutionID – PRIMARY KEY – Unique identifier of resolution
        -	R01, R02, …, R200
    -	ResolutionDescription – Description of resolution
    -	CustomerID – FOREIGN KEY – Unique identifier of customer
    -	IssueID – FOREIGN KEY – Unique identifier of issue

**Step 3: Load Data in the Database**

-	**Customers**

Commands:

```
db2 -tvf insert_customers_table.sql

CREATE TABLE students.Customers(
    CustomerID VARCHAR(50) NOT NULL PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(50),
    Gender VARCHAR(50),
    TotalSpent DECIMAL(10,2),
    AccountStatus VARCHAR(50), CustomerType VARCHAR(50)
    ) IN tsp01 INDEX IN tsp01;

db2 import from c:\inst2593\Project\Customers.csv of del skipcount 1 insert into students.customers
```
<img src = "images\insert_customers.png"></img>

-	**Agents**

Commands:

```
db2 -tvf insert_agents_table.sql

CREATE TABLE students.Agents(
    AgentID VARCHAR(50) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(50),
    DepartmentID VARCHAR(50) NOT NULL,
    Role VARCHAR(50),
    Salary INT, State VARCHAR(50), Country VARCHAR(50)
    ) IN tsp01 INDEX IN tsp01;

db2 import from c:\inst2593\Project\Agents.csv of del skipcount 1 insert into students.agents
```
<img src = "images\insert_agents.png"></img>

-	**Calls**

Commands:
```
db2 -tvf insert_calls_table.sql

CREATE TABLE students.Calls(
    CallID VARCHAR(50) NOT NULL PRIMARY KEY, CustomerID VARCHAR(50) NOT NULL, AgentID VARCHAR(50) NOT NULL, CallDuration INT, CallIssueID VARCHAR(50) NOT NULL,
    DaysToResolve INT, IssueStatus VARCHAR(50),
    
    FOREIGN KEY (CustomerID) REFERENCES students.Customers(CustomerID),
    FOREIGN KEY (AgentID) REFERENCES students.Agents(AgentID),
    FOREIGN KEY (CallIssueID) REFERENCES students.Issues(IssueID)
    ) IN tsp01 INDEX IN tsp01;

db2 import from c:\inst2593\Project\Calls.csv of del skipcount 1 insert into students.calls
```
<img src = "images\insert_calls.png"></img>
 
-	**Issues**

Commands:
```
db2 -tvf insert_issues_table.sql

CREATE TABLE students.Issues(
IssueID VARCHAR(50) NOT NULL PRIMARY KEY,
IssueDescription VARCHAR(100)
) IN tsp01 INDEX IN tsp01;

db2 import from c:\inst2593\Project\Issues.csv of del skipcount 1 insert into students.issues
```

<img src = "images\insert_issues.png"></img>

-	**Resolution**

Commands:
```
db2 -tvf insert_resolution_table.sql

CREATE TABLE students.Resolution(
ResolutionID VARCHAR(50) NOT NULL PRIMARY KEY,
ResolutionDescription VARCHAR(50),
CustomerID VARCHAR(50) NOT NULL,
IssueID VARCHAR(50) NOT NULL,

FOREIGN KEY (CustomerID) REFERENCES students.Customers(CustomerID),
FOREIGN KEY (IssueID) REFERENCES students.Issues(IssueID)
) IN tsp01 INDEX IN tsp01;

db2 import from c:\inst2593\Project\Resolution.csv of del skipcount 1 insert into students.resolution
```
<img src = "images\insert_resolution.png"></img>

**Step 4: Operations**
-	Insert data into calls table

    Commands:
```
db2 -tvf insert_new_values_into_calls_table.sql

INSERT INTO students.calls (CallID, CustomerID, AgentID, CallDuration, CallIssueID, DaysToResolve, IssueStatus)
VALUES ('CL201', 'C001', 'A24', 16, 'CI21', 11, 'Resolved');
```
<img src = "images\insert_values_into_calls.png"></img>

-	Update data in calls table

    Commands:
```
db2 UPDATE students.calls 
SET IssueStatus = ‘Unresolved’ , DaysToResolve = -1
WHERE CallID = ‘CL201’
```

<img src = "images\update_values_in_calls.png"></img>

-	Delete data in calls table

    Commands:
```
db2 DELETE FROM students.calls 
WHERE CallID = ‘CL201’
```

<img src = "images\delete_values_in_calls.png"></img>

**Step 5: Backup your Database**

Commands:
```
db2 UPDATE DATABASE CONFIGURATION USING logarchmeth1 “DISK:C:\inst2593\archive” logprimary 2 logsecond 10 logfilsiz 1000 LOGINDEXBUILD OFF

db2 connect reset

db2 force application all

db2 terminate

db2 deactivate database students

db2 BACKUP DATABASE STUDENTS TO c:\inst2593\backup COMPRESS
```
<img src = "images\backup database.png"></img>

**Step 6: Do SQL Queries in your Database**

-	Total Number of Calls Handled by Each Agent
    - Count the calls handled by each agent

```
db2 -tvf sql_query_1.sql

SELECT AgentID, COUNT(*) AS TotalCalls
FROM students.Calls
GROUP BY AgentID;
```
<img src = "images\q_1.png"></img>

-	Average Call Duration
    - Calculate the average duration of calls

```
db2 -cfg sql_query_2.sql

SELECT AVG(CallDuration) AS AvgCallDuration
FROM students.Calls;
```
<img src = "images\q_2.png"></img>

-	Most common issues reported by customers
    - Identify the most frequently reported issues
    
```
db2 -cfg sql_query_3.sql

SELECT I.IssueDescription, COUNT(C.CallIssueID) AS IssueCount
FROM students.Issues I
JOIN students.Calls C ON I.IssueID = C.CallIssueID
GROUP BY I.IssueDescription
ORDER BY IssueCount DESC
LIMIT 10;
```

<img src = "images\q_3.png"></img>

-	List of Calls Longer Than a Certain Duration
    -	Find all calls exceeding a specific duration

```
db2 -cfg sql_query_4.sql

SELECT *
FROM students.Calls
WHERE CallDuration > 20;
```

<img src = "images\q_4.png"></img>

-	Number of Resolved vs Unresolved Issues
    -	Compare the count of resolved and unresolved issues.
    
```
db2 -cfg sql_query_5.sql

SELECT IssueStatus, COUNT(*) AS IssueCount
FROM students.Calls
GROUP BY IssueStatus;
```

<img src = "images\q_5.png"></img>

-	Agents Who Have Resolved the Most Issues
    -   Rank agents based on the number of issues they have resolved.
        
```
db2 -cfg sql_query_6.sql

SELECT a.AgentID, a.FirstName, a.LastName, COUNT(*) AS ResolvedIssues
FROM students.Agents a
JOIN students.Calls c ON a.AgentID = c.AgentID
WHERE c.IssueStatus = 'Resolved'
GROUP BY a.AgentID, a.FirstName, a.LastName
ORDER BY ResolvedIssues DESC
LIMIT 10;
```
<img src = "images\q_6.png"></img>

-	Customer Calls History 
    -	Retrieve the call history for a specific customer
        
```
db2 -cfg sql_query_7.sql

SELECT c.*, i.IssueDescription
FROM students.Calls c
JOIN students.Issues i ON c.CallIssueID = i.IssueID
WHERE c.CustomerID = 'C100';
```
<img src = "images\q_7.png"></img>

-	Department-Wise Call Distribution 
    -	Analyze how calls are distributed across different departments
    
```
db2 -cfg sql_query_8.sql

SELECT a.DepartmentID, COUNT(*) AS CallCount
FROM students.Agents a
JOIN students.Calls c ON a.AgentID = c.AgentID
JOIN students.Calls ON c.CustomerID = c.CustomerID
GROUP BY a.DepartmentID;
```
<img src = "images\q_8.png"></img>

-	Issues Resolved Within a Day 
    -	List issues that were resolved within one day of reporting  
    
```
db2 -cfg sql_query_9.sql

SELECT I.IssueDescription, COUNT(C.CallIssueID) AS IssueCount
FROM students.Issues I
JOIN students.Calls C ON I.IssueID = C.CallIssueID
GROUP BY I.IssueDescription
ORDER BY IssueCount DESC
LIMIT 10;
```
<img src = "images\q_9.png"></img>

-	Longest Waiting Time for Customers 
    -	Identify the call with the longest waiting time   
        
```
db2 -cfg sql_query_11.sql

SELECT *
FROM students.Calls
ORDER BY CallDuration DESC
LIMIT 10;
```
<img src = "images\q_11.png"></img>

-	Repeat Calls from Customers 
    -	Find customers who made repeat calls within a short period  
    
```
db2 -cfg sql_query_12.sql

SELECT CustomerID, COUNT(*) AS RepeatCallCount
FROM students.Calls
GROUP BY CustomerID
HAVING COUNT(*) > 1;
```
<img src = "images\q_12.png"></img>

-	Agent Performance Analysis	
    -	Assess agent performance based on call handling and issue resolution    
    
```
db2 -cfg sql_query_13.sql

SELECT a.AgentID, a.FirstName, 
    COUNT(DISTINCT c.CallID) AS HandledCalls,
    COUNT(DISTINCT i.IssueID) AS ResolvedIssues
FROM students.Agents a
LEFT JOIN students.Calls c ON a.AgentID = c.AgentID
LEFT JOIN students.Issues i ON c.CallIssueID = i.IssueID
GROUP BY a.AgentID, a.FirstName
ORDER BY ResolvedIssues DESC, HandledCalls DESC;
```
<img src = "images\q_13.png"></img>

-	Customer Feedback on Resolutions
    -	Link customer feedback to specific resolutions    

```
db2 -cfg sql_query_14.sql

SELECT R.ResolutionID, R.ResolutionDescription, C.IssueStatus
FROM students.Resolution R
JOIN students.Calls C ON R.IssueID = C.CallIssueID
WHERE C.IssueStatus = 'Resolved';
```
<img src = "images\q_14.png"></img>

-	Time Taken to Resolve Issues by Department
    -	Compare the average time taken to resolve issues across departments    
    
```
db2 -cfg sql_query_3.sql

SELECT A.DepartmentID, AVG(C.DaysToResolve) AS AvgTimeToResolve
FROM students.Calls C
JOIN students.Agents A ON C.AgentID = A.AgentID
GROUP BY A.DepartmentID;
```
<img src = "images\q_15.png"></img>