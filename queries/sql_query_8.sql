SELECT a.DepartmentID, COUNT(*) AS CallCount
FROM students.Agents a
JOIN students.Calls c ON a.AgentID = c.AgentID
GROUP BY a.DepartmentID;