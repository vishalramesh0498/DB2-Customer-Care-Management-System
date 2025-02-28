SELECT I.IssueDescription, COUNT(C.CallIssueID) AS IssueCount
FROM students.Issues I
JOIN students.Calls C ON I.IssueID = C.CallIssueID
GROUP BY I.IssueDescription
ORDER BY IssueCount DESC
LIMIT 10;