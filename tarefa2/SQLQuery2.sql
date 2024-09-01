-- Consulta para encontrar o cliente com o maior numero de pedidos realizados
-- Considerando clientes que fizeram pedidos em todos os 4 trimestres do ano fiscal de 2013

SELECT top 1
    c.CustomerKey Codigo, 
    c.FirstName Nome,   
    c.LastName Sobrenome, 
    c.EmailAddress Email,
    c.Phone Contato,   
    COUNT(fis.SalesOrderNumber) Total_Pedidos,  
	 SUM(fis.SalesAmount) AS Valor_Total
FROM DimCustomer c
LEFT JOIN (
    SELECT DISTINCT CustomerKey
    FROM FactInternetSales
    WHERE OrderDate >= '20130101' AND OrderDate <= '20130331'
) AS Q1
    ON c.CustomerKey = Q1.CustomerKey
LEFT JOIN (
    SELECT DISTINCT CustomerKey
    FROM FactInternetSales
    WHERE OrderDate >= '20130401' AND OrderDate <= '20130630'
) AS Q2
    ON c.CustomerKey = Q2.CustomerKey
LEFT JOIN (
    SELECT DISTINCT CustomerKey
    FROM FactInternetSales
    WHERE OrderDate >= '20130701' AND OrderDate <= '20130930'
) AS Q3
    ON c.CustomerKey = Q3.CustomerKey
LEFT JOIN (
    SELECT DISTINCT CustomerKey
    FROM FactInternetSales
    WHERE OrderDate >= '20131001' AND OrderDate <= '20131231'
) AS Q4
    ON c.CustomerKey = Q4.CustomerKey
  and Q1.CustomerKey IS NOT NULL
  AND Q2.CustomerKey IS NOT NULL
  AND Q3.CustomerKey IS NOT NULL
  AND Q4.CustomerKey IS NOT NULL
JOIN FactInternetSales fis
    ON c.CustomerKey = fis.CustomerKey
WHERE
	fis.OrderDate >= '20130101' AND fis.OrderDate <= '20131231'
GROUP BY 
	c.CustomerKey,
	c.FirstName, 
	c.LastName, 
	c.EmailAddress, 
	c.Phone
ORDER BY 
	Total_Pedidos DESC

/* SELECT
    fis.SalesOrderNumber,  
    fis.OrderDate,       
    fis.SalesAmount      
FROM FactInternetSales AS fis
WHERE fis.CustomerKey = '11300'
  AND fis.OrderDate >= '20130101'
  AND fis.OrderDate <= '20131231'
ORDER BY fis.OrderDate*/
