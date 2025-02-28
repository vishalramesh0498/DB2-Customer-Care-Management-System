SELECT R.ResolutionID, R.ResolutionDescription, C.IssueStatus
FROM students.Resolution R
JOIN students.Calls C ON R.IssueID = C.CallIssueID
WHERE C.IssueStatus = 'Resolved';