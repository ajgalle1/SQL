ALTER VIEW dbo.vwGetProductOrderInfo
AS
SELECT  C.LastName + ', ' + C.FirstName AS customername,
            C.CustomerID,
            C.Phone,
            C.EmailAddress,
            SOH.SalesOrderID,
            SOH.TotalDue AS linetotal, 
			SOD.OrderQty,
			SOD.ProductID,
			P.Name

FROM SalesLT.Product as P
LEFT JOIN SalesLT.SalesOrderDetail AS SOD ON SOD.ProductID = P.ProductID
LEFT JOIN SalesLT.SalesOrderHeader AS SOH on SOH.SalesOrderID = SOD.SalesOrderID
LEFT JOIN SalesLT.Customer AS C ON SOH.CustomerID = C.CustomerID

--Test cases
select * from dbo.vwGetProductOrderInfo

select * from dbo.vwGetProductOrderInfo
where customername = 'liu, kevin'
order by linetotal

select * from dbo.vwGetProductOrderInfo
where OrderQty IS NULL
