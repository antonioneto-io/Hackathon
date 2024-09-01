/* Quais vendedores tiveram vendas com valor acima da media no
ultimo ano fiscal e tambem tiveram um crescimento de vendas.
superior a 10% em relacao ao ano anterior?*/

SELECT DISTINCT
    e.EmployeeKey AS Codigo_Funcionario,
    e.FirstName AS Nome,
    e.LastName AS Sobrenome,
    e.Title AS Cargo,
    ROUND(SUM(a.TotalVendasAnoAtual), 2) AS Total_Vendas_Atual,
    ROUND(AVG(c.CrescimentoPercentual) * 100, 2) AS Crescimento
FROM (
    SELECT 
        SalesTerritoryKey AS ChaveTerritorio,
        YEAR(OrderDate) AS Ano,
        SUM(SalesAmount) AS TotalVendasAnoAtual,
        AVG(SUM(SalesAmount)) OVER (PARTITION BY YEAR(OrderDate)) AS MediaVendasAno
    FROM FactInternetSales
    WHERE OrderDate <= '20140128'
    GROUP BY SalesTerritoryKey, YEAR(OrderDate)
) AS a
JOIN (
    SELECT 
        a.ChaveTerritorio,
        a.Ano AS AnoAtual,
        a.TotalVendasAnoAtual,
        b.TotalVendasAnoAnterior,
        CASE 
            WHEN b.TotalVendasAnoAnterior IS NULL THEN NULL
            ELSE (a.TotalVendasAnoAtual - b.TotalVendasAnoAnterior) * 1.0 / b.TotalVendasAnoAnterior
        END AS CrescimentoPercentual
    FROM (
        SELECT 
            SalesTerritoryKey AS ChaveTerritorio,
            YEAR(OrderDate) AS Ano,
            SUM(SalesAmount) AS TotalVendasAnoAtual
        FROM FactInternetSales
        WHERE OrderDate <= '20140128'
        GROUP BY SalesTerritoryKey, YEAR(OrderDate)
    ) AS a
    LEFT JOIN (
        SELECT 
            SalesTerritoryKey AS ChaveTerritorio,
            YEAR(OrderDate) AS Ano,
            SUM(SalesAmount) AS TotalVendasAnoAnterior
        FROM FactInternetSales
        WHERE OrderDate <= '20140128'
        GROUP BY SalesTerritoryKey, YEAR(OrderDate)
    ) AS b
        ON a.ChaveTerritorio = b.ChaveTerritorio
        AND a.Ano = b.Ano + 1
) AS c
    ON a.ChaveTerritorio = c.ChaveTerritorio
    AND a.Ano = c.AnoAtual
JOIN DimEmployee e
    ON e.SalesTerritoryKey = a.ChaveTerritorio
WHERE a.TotalVendasAnoAtual > a.MediaVendasAno
AND c.CrescimentoPercentual > 0.10
GROUP BY 
    e.EmployeeKey,
    e.FirstName,
    e.LastName,
    e.Title
