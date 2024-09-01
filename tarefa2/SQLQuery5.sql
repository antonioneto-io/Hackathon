/* o crescimento anual das vendas por produto nos ultimos dois anose quais produtos apresentaram 
uma tendencia de crescimento nas vendas em ambos os anos*/
-- o periodo que escolhi
DECLARE @DataFim DATE = '20140128';
DECLARE @DataInicio DATE = DATEADD(YEAR, -2, @DataFim);
-- CTE para calcular as vendas anuais
WITH VendasAnuais AS (
    SELECT 
        p.ProductKey, 
        p.EnglishProductName AS NomeProduto,
        YEAR(fis.OrderDate) AS Ano,
        SUM(fis.SalesAmount) AS ValorTotal
    FROM FactInternetSales fis
    JOIN DimProduct p ON fis.ProductKey = p.ProductKey
    WHERE fis.OrderDate BETWEEN @DataInicio AND @DataFim
    GROUP BY p.ProductKey, p.EnglishProductName, YEAR(fis.OrderDate)
),-- CTE para calcular o crescimento anual
CrescimentoAnual AS (
    SELECT 
        a.ProductKey,
        a.NomeProduto,
        a.Ano,
        a.ValorTotal AS VendasAnoAtual,
        LAG(a.ValorTotal) OVER (PARTITION BY a.ProductKey ORDER BY a.Ano) AS VendasAnoAnterior,
        CASE 
            WHEN LAG(a.ValorTotal) OVER (PARTITION BY a.ProductKey ORDER BY a.Ano) IS NULL 
            THEN NULL
            ELSE a.ValorTotal - LAG(a.ValorTotal) OVER (PARTITION BY a.ProductKey ORDER BY a.Ano)
        END AS Crescimento
    FROM VendasAnuais a
)
SELECT 
    ca.ProductKey AS Codigo_Produto,
    ca.NomeProduto AS Nome_Produto,
    ca.Ano AS Ano,
    ROUND(ca.VendasAnoAtual, 2) AS Vendas_Ano_Atual,
    ROUND(ca.Crescimento, 2) AS Crescimento_Valor
FROM CrescimentoAnual ca
WHERE ca.Crescimento > 0
ORDER BY ca.ProductKey, ca.Ano
