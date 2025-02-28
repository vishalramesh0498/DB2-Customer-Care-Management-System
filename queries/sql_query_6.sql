SELECT a.AgentID, a.FirstName, a.LastName, COUNT(*) AS ResolvedIssues
FROM students.Agents a
JOIN students.Calls c ON a.AgentID = c.AgentID
WHERE c.IssueStatus = 'Resolved'
GROUP BY a.AgentID, a.FirstName, a.LastName
ORDER BY ResolvedIssues DESC
LIMIT 10;