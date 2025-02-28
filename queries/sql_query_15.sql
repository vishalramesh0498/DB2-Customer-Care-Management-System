SELECT A.DepartmentID, AVG(C.DaysToResolve) AS AvgTimeToResolve
FROM students.Calls C
JOIN students.Agents A ON C.AgentID = A.AgentID
GROUP BY A.DepartmentID;