-- limpeza e preparação das tabelas para inserção dos dados
-- garante que as tabelas estejam vazias e o auto_increment seja reiniciado

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE ProdutoFornecedor;
TRUNCATE TABLE ProdutoVendedor;
TRUNCATE TABLE ProdutoPedido;
TRUNCATE TABLE ProdutoEstoque;
TRUNCATE TABLE PagamentosPedido;
TRUNCATE TABLE Pedidos;
TRUNCATE TABLE FormasPagamento;
TRUNCATE TABLE Produtos;
TRUNCATE TABLE Estoques;
TRUNCATE TABLE Vendedores;
TRUNCATE TABLE Fornecedores;
TRUNCATE TABLE Clientes;
SET FOREIGN_KEY_CHECKS = 1;

-- 'clients' -> 'Clientes'
-- 'Fname', 'Lname', 'FedId', etc. -> 'PrimeiroNome', 'Sobrenome', 'CPF' etc.
-- - Adicionada a coluna 'TipoPessoa' como 'Fisica', pois os dados são de pessoas físicas.
INSERT INTO Clientes(PrimeiroNome, Sobrenome, TipoPessoa, CPF, DataNascimento, CEP, NumeroEndereco, Complemento) VALUES
    ('Marcelina', 'Barros', 'Fisica', '12365497899', '1985-04-04', '04532147', 123, NULL),
    ('Carlos', 'Jesus', 'Fisica', '85749658246', '1979-08-19', '26874123', 90, NULL),
    ('Silvina', 'Albuquerque', 'Fisica', '46695877215', '1977-11-17', '35715982', 77, NULL),
    ('Jose', 'Aparecido', 'Fisica', '96553815978', '1990-10-04', '04887321', 44, NULL),
    ('Antonia', 'Gomes', 'Fisica', '36915984211', '1992-07-26', '34887357', 52, NULL);

-- 'products' -> 'Produtos'
-- 'Pname', 'Uncost', 'Unprice', 'GroupKids', 'Size' -> 'NomeProduto', 'CustoUnitario', 'PrecoUnitario', 'ParaCriancas', 'Dimensoes'.
INSERT INTO Produtos(NomeProduto, CustoUnitario, PrecoUnitario, ParaCriancas, Categoria, Avaliacao, Dimensoes) VALUES
    ('Sofa Dois Lugares', 1455.75, 2500.00, DEFAULT, 'Casa e Decoracao', 4.3, '160x82x90cm'),
    ('PC Gamer', 2700.00, 3599.90, DEFAULT, DEFAULT, 4.5, '21x47x45cm'),
    ('365 Historias Para Ler e Sonhar', 32.90, 41.90, TRUE, 'Livros', 4.4, '20x1.6x27cm');


-- 'orders' -> 'Pedidos'
-- 'idClient', 'OrDescription', 'Shipping', 'OrStatus' -> 'idCliente', 'DescricaoPedido', 'Frete', 'StatusPedido'.
INSERT INTO Pedidos(idCliente, DescricaoPedido, Frete, StatusPedido, CodigoRastreio) VALUES
    (5, 'Compra via Web sem fidelidade', 70, 'Enviado', 'BR123456789BR'),
    (1, 'Compra via App com fidelidade', DEFAULT, DEFAULT, NULL),
    (4, 'Compra via App com fidelidade', DEFAULT, 'Cancelado', NULL),
    (3, 'Compra via Web com fidelidade', DEFAULT, 'Pagamento Aprovado', NULL),
    (2, 'Compra via Web sem fidelidade', 25, DEFAULT, NULL);



-- tabela 'payments' foi dividida em 'FormasPagamento' (métodos salvos) e 'PagamentosPedido' (transação do pedido).
-- Para cada pagamento antigo, criei uma Forma de Pagamento para o cliente e depois um registro de Pagamento do Pedido associado.
-- assumi que o pagamento 1 pertence ao pedido 1 (pelo idCliente), pagamento 2 ao pedido 2, e assim por diante.
-- No mundo real, penso que a lógica seria mais complexa.
-- Primeiro, criamos as formas de pagamento para cada cliente
INSERT INTO FormasPagamento(idCliente, TipoPagamento, Detalhes) VALUES
    (1, 'Boleto', 'Boleto Bancário Padrão'),
    (3, 'Pix', 'Chave Aleatória'),
    (2, 'Credito', 'Cartão final 4321'),
    (5, 'Debito', 'Cartão final 8765'),
    (4, 'Pix', 'Chave E-mail');

-- Agora, vinculamos os pagamentos aos pedidos específicos
-- (Assumindo que os IDs dos pedidos são 1, 2, 3, 4, 5 nesta ordem de criação)
INSERT INTO PagamentosPedido(idPedido, idFormaPagamento, StatusPagamento, ValorTotal) VALUES
    (2, 1, 'Em Aprovacao', 41.90 + 15.00), -- Pedido do Cliente 1, usando FormaPagamento 1
    (4, 2, 'Confirmado', 3599.90 + 41.90 + 15.00), -- Pedido do Cliente 3, usando FormaPagamento 2
    (5, 3, 'Cancelado', 3599.90 + 25.00), -- Pedido do Cliente 2, usando FormaPagamento 3
    (1, 4, 'Confirmado', 2500.00 + 3599.90 + 70.00), -- Pedido do Cliente 5, usando FormaPagamento 4
    (3, 5, 'Estornado', 2500.00 + 15.00); -- Pedido do Cliente 4, usando FormaPagamento 5


-- 'warehouses' foi dividida em 'Estoques' (locais) e 'ProdutoEstoque' (relação produto x local).
-- Primeiro, criei os estoques únicos (SP, RJ, MG) para não haver duplicatas.
-- Depois, populei a 'ProdutoEstoque' com as quantidades.
-- IDs dos produtos foram assumidos como 1, 2, 3 (Sofa, PC, Livro).
INSERT INTO Estoques(Localizacao, CEP) VALUES
    ('SP', '04889000'),
    ('RJ', '22200200'),
    ('MG', '39999099');

-- Vinculando produtos e quantidades aos estoques
-- (Assumindo idEstoque: 1=SP, 2=RJ, 3=MG e idProduto: 1=Sofa, 2=PC, 3=Livro)
INSERT INTO ProdutoEstoque(idProduto, idEstoque, Quantidade) VALUES
    (1, 1, 13), -- Sofa em SP
    (2, 1, 10), -- PC em SP
    (3, 1, 25), -- Livro em SP
    (1, 2, 5),  -- Sofa em RJ
    (3, 2, 15), -- Livro em RJ
    (2, 3, 7),  -- PC em MG
    (3, 3, 3);  -- Livro em MG


-- 'suppliers' -> 'Fornecedores'
-- 'Sname', 'RegisterEntity' -> 'RazaoSocial', 'CNPJ'.
-- - Removido 'FedId' pois a nova tabela assume que fornecedores são sempre PJ (CNPJ).
INSERT INTO Fornecedores(RazaoSocial, CNPJ, CEP) VALUES
    ('De Tudo um Pouco Distribuidora', '99898999999977', '04000000'),
    ('Joaozinho Martins (CNPJ Fictício)', '11108000011100', '29990009'), 
    ('Cultura Pop Ltda', '77700777999988', '37770777');


-- 'retailers' -> 'Vendedores'
-- 'Rname', 'RegisterEntity' -> 'RazaoSocial', 'CNPJ'.
INSERT INTO Vendedores(RazaoSocial, CNPJ, CEP) VALUES
    ('Florentina de Jesus', '12332112332111', '04100111'), 
    ('Zezinho Noronha', '95195175328222', '20010000'),
    ('Cultura Pop Ltda Vendas', '75335775391333', '04333555'),
    ('Como se Vende S/A', '88888888999977', '31133133'),
    ('Monte Tudo Me', '14774144777799', '21900909'),
    ('Magia Digital', '89898977555511', '35550000');



-- 'productOrder' -> 'ProdutoPedido'
-- 'idPOrder', 'idPOproduct', 'OQuantity', 'POStatus' -> 'idPedido', 'idProduto', 'Quantidade', 'StatusProduto'.
INSERT INTO ProdutoPedido(idPedido, idProduto, Quantidade, StatusProduto) VALUES
    (1, 1, 1, DEFAULT),
    (1, 2, 2, 'Disponivel'), -- 'Em Produção' não existe mais no ENUM, ajustado para 'Disponivel'
    (2, 3, 5, 'Sem Estoque'),
    (3, 2, 1, DEFAULT),
    (3, 3, 2, DEFAULT),
    (4, 1, 1, 'Sem Estoque');


-- 'productRetailer' -> 'ProdutoVendedor'
-- 'idPRetailer', 'idPRproduct', 'RQuantity' -> 'idVendedor', 'idProduto', 'QuantidadeAnunciada'.
INSERT INTO ProdutoVendedor(idVendedor, idProduto, QuantidadeAnunciada) VALUES
    (1, 1, 2), (1, 2, 5), (1, 3, 10),
    (2, 2, 6), (2, 3, 7),
    (3, 1, 5), (3, 2, 5),
    (4, 1, 3), (4, 2, 3), (4, 3, 15),
    (5, 2, 10),
    (6, 1, 1), (6, 2, 3), (6, 3, 25);



-- 'productSupplier' -> 'ProdutoFornecedor'
-- 'idPSupplier', 'idPSproduct', 'SQuantity' -> 'idFornecedor', 'idProduto', 'QuantidadeFornecida'.
INSERT INTO ProdutoFornecedor(idFornecedor, idProduto, QuantidadeFornecida) VALUES
    (1, 1, 50), (1, 2, 100), (1, 3, 2000),
    (2, 2, 155), (2, 3, 1050),
    (3, 1, 70), (3, 2, 500);
