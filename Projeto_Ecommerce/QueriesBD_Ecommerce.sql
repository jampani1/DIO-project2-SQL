-- Recuperando Informações com queries SQL

-- Seleção da base completa de clientes
SELECT * FROM clients;


-- Seleção da base completa de Estoques
SELECT * FROM warehouses;


-- Seleção de apenas uma ocorrência dos LOCAIS da Base de Estoques
SELECT DISTINCT location FROM warehouses;


-- Mapeamento de Estoques em São Paulo, a partir de uma condição
SELECT * FROM warehouses
	WHERE location = 'SP';


-- Mapeamento de Clientes na mesma região, por CEP
SELECT * FROM clients
	WHERE ZipCode LIKE '04%';


-- Seleçao de Pedidos por Cliente, trazendo a informação de status do pedido
SELECT concat(Fname, ' ', Lname) as FullName, c.ZipCode, idOrder, o.OrStatus
	FROM orders o, clients c
	WHERE c.idClient = o.idClient;


-- Seleção dos itens de cada Pedido
SELECT o.idPOrder as idOrder, p.Pname as Product, o.OQuantity as Qtd, round(p.UnPrice,2) as UnPrice, round((OQuantity * UnPrice),2) as FinalPrice, o.POStatus
	FROM productOrder o, products p
	WHERE idPOproduct = idProduct;


-- Seleção de Pedidos por Cliente, com informação dos produtos do Pedido
SELECT po.idPOrder as idOrder, concat(c.Fname, ' ', c.Lname) as FullName, p.Pname as Product, po.OQuantity as Qtd, round(p.UnPrice,2) as UnPrice, round((OQuantity * UnPrice),2) as FinalPrice, po.POStatus
	FROM productOrder po, products p, clients c, orders o
	WHERE idPOproduct = idProduct and o.idOrder = po.idPOrder and o.idClient = c.idClient
    	ORDER BY FullName;


-- Confirmação de Pagamento de Pedido com o valor total e Status do Pagamento
SELECT po.idPOrder, concat(c.Fname, ' ', c.Lname) as FullName, ROUND(SUM((po.OQuantity * p.UnPrice)),2) as FinalPrice, py.PayMethods, py.PayStatus
	FROM productOrder po, orders o, clients c, products p, payments py
    	WHERE po.idPOproduct = p.idProduct AND po.idPOrder = o.idOrder AND o.idClient = c.idClient AND c.idClient = py.idClient;


-- Classificação de Vendedores por Comissão
SELECT r.Rname, r.ZipCode, p.Pname, pr.RQuantity, round((pr.RQuantity * p.UnPrice), 2) as GrossPrice, round((pr.RQuantity * p.UnPrice * 0.05), 2) as Commission
	FROM productRetailer pr, products p, retailers r
    	WHERE pr.idPRetailer = r.idRetailer AND pr.idPRproduct = p.idProduct 
    	ORDER BY Commission DESC;


-- Having Statement: Classificação de Vendedores com 2+ Produtos vendidos
SELECT r.Rname, r.ZipCode, p.Pname, COUNT(*) as TotalSales, round((pr.RQuantity * p.UnPrice), 2) as GrossPrice, round((pr.RQuantity * p.UnPrice * 0.05), 2) as Commission
	FROM productRetailer pr, products p, retailers r
    	WHERE pr.idPRetailer = r.idRetailer AND pr.idPRproduct = p.idProduct 
    	GROUP BY r.Rname
    	HAVING COUNT(*)>1
    	ORDER BY Commission DESC;


-- Case Statement: Classificação dos Estoques de Fornecedores
-- Abaixo de 10 = Estoque Baixo
-- Igual a 10 = Estoque no Limite
-- Acima de 10 = Estoque Alto
SELECT s.Sname, s.ZipCode, p.Pname, ps.SQuantity
	CASE
    	WHEN ps.SQuantity < 10 THEN 'Estoque Baixo'
        WHEN ps.SQuantity = 10 THEN 'Estoque Limite'
    	ELSE 'Estoque Alto'
        END AS stockClassification
	FROM productSupplier ps INNER JOIN suppliers s
		ON ps.idPSupplier= s.idSupplier
    	INNER JOIN products p
    		ON ps.idPSproduct = p.idProduct
    ORDER BY ps.SQuantity DESC;



-- Join Statement 3 Tabelas: Classificação de Vendedores de 'PC Gamer' por comissão
SELECT r.Rname, r.ZipCode, p.Pname, pr.RQuantity, round((pr.RQuantity * p.UnPrice), 2) as GrossPrice, round((pr.RQuantity * p.UnPrice * 0.05), 2) as Commission
	FROM productRetailer pr INNER JOIN products p
    		ON pr.idPRproduct = p.idProduct
        	INNER JOIN retailers r
    			ON pr.idPRetailer = r.idRetailer 
    	WHERE p.Pname = 'PC Gamer'
    	ORDER BY Commission DESC;