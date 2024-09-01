/*Em qual mes do ano ocorrem mais vendas (em valor total,
considerando apenas os meses em que a receita m�dia por
venda foi superior a 50 unidades moneterias?*/
WITH VendasMensais AS (
    SELECT 
        YEAR(OrderDate) Ano,
        MONTH(OrderDate) Mes,
        SUM(SalesAmount) TotalVendas,
        COUNT(SalesOrderNumber) TotalPedidos
    FROM FactInternetSales
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
)

SELECT TOP 1
    Ano, 
    Mes, 
    ROUND(TotalVendas, 2) ValorTotal,
    TotalPedidos,
    ROUND(TotalVendas * 1.0 / TotalPedidos, 2) ReceitaMediaPorVenda
FROM VendasMensais
WHERE ROUND(TotalVendas * 1.0 / TotalPedidos, 2) > 500
ORDER BY ValorTotal DESC
