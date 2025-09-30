-- respondendo perguntas através de queries

-- quantos pedidos foram feitos por cada cliente?
SELECT count(pedidos.idPedido) FROM clientes JOIN pedidos ON clientes.idCliente = pedidos.idCliente GROUP BY clientes.idCliente;
-- refinando
SELECT concat(c.PrimeiroNome,' ',c.Sobrenome) as NomeCompleto, 
		COUNT(p.idPedido) AS TotalPedidos 
			FROM clientes as c 
				JOIN pedidos as p ON c.idCliente = p.idCliente 
					GROUP BY c.idCliente, c.PrimeiroNome, c.Sobrenome;
                    
-- algum vendedor também é fornecedor?
SELECT v.RazaoSocial FROM vendedores AS v JOIN fornecedores AS f ON v.CNPJ = f.CNPJ;

-- qual a relação entre produtos, fornecedores e estoque?
SELECT p.NomeProduto FROM produtos AS p 
	JOIN produtofornecedor AS pf ON p.idProduto = pf.idProduto
		JOIN fornecedores AS f ON f.idFornecedor = pf.idFornecedor
			JOIN produtoestoque AS pe ON pe.idProduto = p.idProduto
				JOIN estoques AS e ON e.idEstoque = pe.idEstoque;
-- refinando
SELECT
	p.NomeProduto, 
	f.RazaoSocial AS fornecedor,
    e.Localizacao AS Local_Estoque,
    pe.Quantidade AS Qtd_Estoque
FROM 
	produtos AS p
JOIN 
	produtofornecedor AS pf ON p.idProduto = pf.idProduto
JOIN 
	fornecedores AS f ON f.idFornecedor = pf.idFornecedor
JOIN 
	produtoestoque AS pe ON p.idProduto = pe.idProduto
JOIN
	estoques AS e ON e.idEstoque = pe.idEstoque
ORDER BY 
	p.NomeProduto, e.Localizacao;
    
-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
	f.RazaoSocial AS Fornecedor,
    p.NomeProduto AS Produto
FROM
	produtos AS p
JOIN 
	produtofornecedor AS pf ON pf.idProduto = p.idProduto
JOIN
	fornecedores AS f ON f.idFornecedor = pf.idFornecedor
ORDER BY 
	Fornecedor, Produto;
			
