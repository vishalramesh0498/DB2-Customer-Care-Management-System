SELECT CustomerID, COUNT(*) AS RepeatCallCount
FROM students.Calls
GROUP BY CustomerID
HAVING COUNT(*) > 1;