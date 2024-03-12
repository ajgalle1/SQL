--Assuming table exists; use alter. Otherwise, create
ALTER PROCEDURE dbo.GetCustomerPurchaseData
    @StartsWith NVARCHAR(30) = NULL,
    @OrderMin MONEY = NULL,
    @OrderMax MONEY = NULL
AS
BEGIN
	    SELECT 
            C.LastName + ', ' + C.FirstName AS FullName,
            C.CustomerID,
            C.Phone,
            C.EmailAddress,
            O.SalesOrderID,
            O.SubTotal,
            O.TaxAmt,
            O.TotalDue
        FROM 
            SalesLT.Customer AS C
        INNER JOIN 
            SalesLT.SalesOrderHeader AS O ON O.CustomerId = C.CustomerID
        WHERE 
            C.LastName LIKE @StartsWith + '%'
            AND (@OrderMin IS NULL OR O.TotalDue >= @OrderMin)
            AND (@OrderMax IS NULL OR O.TotalDue <= @OrderMax)
        ORDER BY 
            FullName;
    
END

--Test cases
exec dbo.GetCustomerPurchaseData -- 32 results
exec dbo.GetCustomerPurchaseData 'C' -- expects 5 results
exec dbo.GetCustomerPurchaseData 'C', 15000.0 -- expects 3 results
exec dbo.GetCustomerPurchaseData 'C', 15000.0, 30000.0 -- expects 1 result
exec dbo.GetCustomerPurchaseData 'C', 30000.0, 15000.0 -- expects 0 results

