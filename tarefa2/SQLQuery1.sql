-- trazer os 10 produtos mais vendidos na categoria bike do ultimos dois anos que houveram vendas
SELECT TOP 10
    dp.EnglishProductName Nome_Produto,   
    SUM(fis.OrderQuantity) Qtd_Vendas, 
	SUM(fis.SalesAmount) Valor_Total      
FROM
	FactInternetSales AS fis
INNER JOIN DimProduct AS dp
    ON fis.ProductKey = dp.ProductKey    
INNER JOIN DimProductSubcategory AS dps
    ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey  
INNER JOIN DimProductCategory AS dpc
    ON dps.ProductCategoryKey = dpc.ProductCategoryKey  
WHERE 
	dpc.EnglishProductCategoryName = 'Bikes' 
    AND fis.OrderDate <= '20140128'  -- ultima venda 
GROUP BY
	dp.EnglishProductName  
ORDER BY
	Qtd_Vendas DESC  