SELECT a.AgentID, a.FirstName, 
       COUNT(DISTINCT c.CallID) AS HandledCalls,
       COUNT(DISTINCT i.IssueID) AS ResolvedIssues
FROM students.Agents a
LEFT JOIN students.Calls c ON a.AgentID = c.AgentID
LEFT JOIN students.Issues i ON c.CallIssueID = i.IssueID
GROUP BY a.AgentID, a.FirstName
ORDER BY ResolvedIssues DESC, HandledCalls DESC;