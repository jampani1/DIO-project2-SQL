-- Inclusão da base de Clientes
INSERT INTO clients(Fname, Lname, FedId, BirthDate, ZipCode, AdressNumb, AdressComp) VALUES
	('Marcelina', 'Barros', '12365497899', '1985-04-04', '04532147', '123'),
	('Carlos', 'Jesus', '85749658246', '1979-08-19', '26874123', '90'),
	('Silvina', 'Albuquerque', '46695877215', '1977-11-17', '35715982', '77'),
	('Jose', 'Aparecido', '96553815978', '1990-10-04', '04887321', '44'),
	('Antonia', 'Gomes', '36915984211', '1992-07-26', '34887357', '52');


-- Inclusão da base de Produtos
INSERT INTO products(
    Pname,
    Uncost,
    Unprice,
    GroupKids,
    Category,
    Rating,
    Size
)
VALUES(
    'Sofa Dois Lugares',
    '1455.75',
    '2500.00',
    DEFAULT,
    'Casa e Decoracao',
    '4.3',
    '160x82x90cm'
),(
    'PC Gamer',
    '2700.00',
    '3.599.90',
    DEFAULT,
    DEFAULT,
    '4.5',
    '21x47x45cm'
),(
    '365 Historias Para Ler e Sonhar',
    '32.90',
    '41.90',
    TRUE,
    'Livros',
    '4.4',
    '20x1.6x27cm'
);


-- Inclusão da base de Pagamentos
INSERT INTO payments(idClient, PayMethods, PayStatus) VALUES
	('1', 'Boleto', DEFAULT), 
        ('3', DEFAULT, 'Confirmado'), 
        ('2', 'Credito', 'Cancelado'),
        ('5', 'Debito', 'Confirmado'),
        ('4', DEFAULT, 'Estornado');


-- Inclusão da base de Pedidos
INSERT INTO orders(idClient, OrDescription, Shipping, OrStatus) VALUES
	('5', 'Compra via Web sem fidelidade', 70, 'Enviado'), 
        ('1', 'Compra via App com fidelidade', DEFAULT, DEFAULT), 
        ('4', 'Compra via App com fidelidade', DEFAULT, 'Cancelado'),
        ('3', 'Compra via Web com fidelidade', DEFAULT, 'Aprovado'),
        ('2', 'Compra via Web sem fidelidade', 25, DEFAULT);


-- Inclusão da base de Estoque
INSERT INTO warehouses(idProduct, ZipCode, Location, QtProduct) VALUES
	('7', '04889000', 'SP', '13'), 
        ('8', '04889000', 'SP', '10'), 
        ('9', '04889000', 'SP', '25'),
        ('7', '22200200', 'RJ', '5'), 
        ('9', '22200200', 'RJ', '15'), 
        ('8', '39999099', 'MG', '7'),
        ('9', '39999099', 'MG', '3');


-- Inclusão da base de Fornecedores
INSERT INTO suppliers(Sname, RegisterEntity, FedId, ZipCode) VALUES
	('De Tudo um Pouco Distribuidora', '99898999999977', '', '04000000'), 
        ('Joaozinho Martins', '', '11108000011', '29990009'), 
        ('Cultura Pop Ltda', '77700777999988', '', '37770777');


-- Inclusão da base de Vendedores
INSERT INTO retailers(Rname, RegisterEntity, FedId, ZipCode) VALUES
	('Florentina de Jesus', '', '12332112332', '04100111'), 
        ('Zezinho Noronha', '', '95195175328', '20010000'), 
        ('Cultura Pop Ltda', '', '75335775391', '04333555'),
        ('Como se Vende S/A', '88888888999977', '', '31133133'), 
        ('Monte Tudo Me', '14774144777799', '', '21900909'), 
        ('Magia Digital', '89898977555511', '', '35550000');


-- Inclusão da base Relação Pedido x Produto
INSERT INTO productOrder(idPOrder, idPOproduct, OQuantity, POStatus) VALUES
	('1', '7', '1', DEFAULT), 
        ('1', '8', '2', 'Em Produção'), 
        ('2', '9', '5', 'Sem Estoque'),
        ('3', '8', '1', DEFAULT), 
        ('3', '9', '2', DEFAULT), 
        ('4', '7', '1', 'Sem Estoque');


-- Inclusão da base Relação Vendedor x Produto
INSERT INTO productRetailer(idPRetailer, idPRproduct, RQuantity) VALUES
	('1', '7', '2'), 
        ('1', '8', '5'), 
        ('1', '9', '10'),
        ('2', '8', '6'),
        ('2', '9', '7'), 
        ('3', '7', '5'), 
        ('3', '8', '5'),
        ('4', '7', '3'),
        ('4', '8', '3'), 
        ('4', '9', '15'),
        ('5', '8', '10'), 
        ('6', '7', '1'), 
        ('6', '8', '3'),
        ('6', '9', '25');


-- Inclusão da base Relação Fornecedor x Produto
INSERT INTO productSupplier(idPSupplier, idPSproduct, SQuantity) VALUES
	('1', '7', '50'), 
        ('1', '8', '100'), 
        ('1', '9', '2000'),
        ('2', '8', '155'),
        ('2', '9', '1050'), 
        ('3', '7', '70'), 
        ('3', '8', '500');