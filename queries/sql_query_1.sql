SELECT AgentID, COUNT(*) AS TotalCalls
FROM students.Calls
GROUP BY AgentID;