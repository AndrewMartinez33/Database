# JOINS

## INNER JOIN (default) : ALL MATCHES FROM BOTH TABLES

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
INNER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## LEFT OUTER JOIN : ALL VALUES FROM LEFT WITH MATCHES FROM RIGHT (NON MATCHES WILL BE DISPLAYED AS NULL)

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
LEFT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## RIGHT OUTER JOIN : ALL RECORDS IN THE RIGHT TABLE WITH MATCHES FROM LEFT. NULL FOR NON MATCH

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
RIGHT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## FULL OUTER JOIN : ALL THE ROWS IN BOTH TABLES. IF NO MATCH THEN NULL.

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
FULL OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## CROSS JOIN : ALL RECORDS FROM RIGHT WITH ALL RECORDS FROM LEFT. LARGE RESULTS

## SELF JOIN : ALL RECORDS MATCHED WITH OTHER RECORDS FROM THE SAME TABLE.
