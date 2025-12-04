CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE ans INT;

  -- handle invalid input
  IF N IS NULL OR N <= 0 THEN
    RETURN NULL;
  END IF;

  -- if fewer than N distinct salaries, return NULL
  IF (SELECT COUNT(DISTINCT salary) FROM Employee) < N THEN
    RETURN NULL;
  END IF;

  -- take the minimum of the top N distinct salaries -> the N-th highest
  SELECT MIN(salary) INTO ans
  FROM (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT N
  ) AS topN;

  RETURN ans;
END
