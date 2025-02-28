SELECT IssueStatus, COUNT(*) AS IssueCount
FROM students.Calls
GROUP BY IssueStatus;