SELECT c.*, i.IssueDescription
FROM students.Calls c
JOIN students.Issues i ON c.CallIssueID = i.IssueID
WHERE c.CustomerID = 'C100';