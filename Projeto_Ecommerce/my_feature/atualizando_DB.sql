-- DROP database ecommerce;
-- CREATE database ecommerce;
-- USE ecommerce;

-- mudança no nome das tabelas para o português

-- distinção entre PF/PJ
CREATE TABLE Clientes(
    idCliente INT AUTO_INCREMENT,
    PrimeiroNome VARCHAR(20) NOT NULL,
    Sobrenome VARCHAR(30) NOT NULL,
    TipoPessoa ENUM('Fisica', 'Juridica') NOT NULL,
    CPF CHAR(11),
    CNPJ CHAR(14),
    RazaoSocial VARCHAR(100), -- Nome da empresa para PJ
    DataNascimento DATE, -- Obrigatório para PF
    CEP CHAR(8) NOT NULL,
    NumeroEndereco INT NOT NULL,
    Complemento VARCHAR(20),
    CONSTRAINT pk_clientes PRIMARY KEY(idCliente),
    CONSTRAINT uq_cpf UNIQUE(CPF),
    CONSTRAINT uq_cnpj UNIQUE(CNPJ),
    CONSTRAINT chk_tipo_pessoa CHECK (
        (TipoPessoa = 'Fisica' AND CPF IS NOT NULL AND CNPJ IS NULL AND DataNascimento IS NOT NULL) OR
        (TipoPessoa = 'Juridica' AND CNPJ IS NOT NULL AND CPF IS NULL AND RazaoSocial IS NOT NULL)
    )
);

CREATE TABLE Produtos(
    idProduto INT AUTO_INCREMENT,
    NomeProduto VARCHAR(50) NOT NULL,
    CustoUnitario FLOAT NOT NULL,
    PrecoUnitario FLOAT NOT NULL,
    ParaCriancas BOOLEAN DEFAULT FALSE,
    Categoria ENUM(
        'Casa e Decoracao',
        'Vestuario',
        'Eletronicos',
        'Livros',
        'Papelaria'
    ) DEFAULT 'Eletronicos',
    Avaliacao FLOAT DEFAULT 0.0,
    Dimensoes VARCHAR(20),
    CONSTRAINT pk_produtos PRIMARY KEY(idProduto)
);

-- formas de pagamento 
CREATE TABLE FormasPagamento(
    idFormaPagamento INT AUTO_INCREMENT,
    idCliente INT,
    TipoPagamento ENUM('Credito', 'Debito', 'Pix', 'Boleto') NOT NULL,
    Detalhes VARCHAR(255), 
    CONSTRAINT pk_formas_pagamento PRIMARY KEY (idFormaPagamento),
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

-- pedido com status de entrega e código de rastreio
CREATE TABLE Pedidos(
    idPedido INT AUTO_INCREMENT,
    idCliente INT,
    DescricaoPedido VARCHAR(255),
    Frete FLOAT DEFAULT 15.00,
    StatusPedido ENUM(
        'Em Processamento',
        'Pagamento Aprovado',
        'Cancelado',
        'Em Separacao',
        'Enviado',
        'Entregue'
    ) DEFAULT 'Em Processamento',
    CodigoRastreio VARCHAR(50),
    CONSTRAINT pk_pedidos PRIMARY KEY(idPedido),
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY(idCliente) REFERENCES Clientes(idCliente)
);

-- registro de pagamento de um pedido específico
CREATE TABLE PagamentosPedido(
    idPagamento INT AUTO_INCREMENT,
    idPedido INT,
    idFormaPagamento INT,
    StatusPagamento ENUM('Em Aprovacao', 'Confirmado', 'Estornado', 'Cancelado') DEFAULT 'Em Aprovacao',
    ValorTotal FLOAT,
    CONSTRAINT pk_pagamentos PRIMARY KEY (idPagamento),
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido),
    CONSTRAINT fk_pagamento_forma FOREIGN KEY(idFormaPagamento) REFERENCES FormasPagamento(idFormaPagamento)
);


CREATE TABLE Estoques(
    idEstoque INT AUTO_INCREMENT,
    Localizacao VARCHAR(50),
    CEP CHAR(8) NOT NULL,
    CONSTRAINT pk_estoque PRIMARY KEY(idEstoque)
);

-- relação produto estoque
CREATE TABLE ProdutoEstoque(
    idProduto INT,
    idEstoque INT,
    Quantidade INT DEFAULT 0,
    CONSTRAINT pk_produto_estoque PRIMARY KEY (idProduto, idEstoque),
    CONSTRAINT fk_pe_produto FOREIGN KEY (idProduto) REFERENCES Produtos(idProduto),
    CONSTRAINT fk_pe_estoque FOREIGN KEY (idEstoque) REFERENCES Estoques(idEstoque)
);

CREATE TABLE Fornecedores(
    idFornecedor INT AUTO_INCREMENT,
    RazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    CEP CHAR(8) NOT NULL,
    CONSTRAINT pk_fornecedor PRIMARY KEY(idFornecedor),
    CONSTRAINT uq_fornecedor_cnpj UNIQUE(CNPJ)
);

CREATE TABLE Vendedores(
    idVendedor INT AUTO_INCREMENT,
    RazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    CEP CHAR(8) NOT NULL,
    CONSTRAINT pk_vendedor PRIMARY KEY(idVendedor),
    CONSTRAINT uq_vendedor_cnpj UNIQUE(CNPJ)
);

-- relação produto pedido
CREATE TABLE ProdutoPedido(
    idPedido INT,
    idProduto INT,
    Quantidade INT,
    StatusProduto ENUM('Disponivel','Sem Estoque') DEFAULT 'Disponivel',
    CONSTRAINT pk_produto_pedido PRIMARY KEY(idPedido, idProduto),
    CONSTRAINT fk_pp_pedido FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido),
    CONSTRAINT fk_pp_produto FOREIGN KEY(idProduto) REFERENCES Produtos(idProduto)
);

-- relação produtos fornecedor
CREATE TABLE ProdutoFornecedor(
    idFornecedor INT,
    idProduto INT,
    QuantidadeFornecida INT,
    CONSTRAINT pk_produto_fornecedor PRIMARY KEY(idFornecedor, idProduto),
    CONSTRAINT fk_pf_fornecedor FOREIGN KEY(idFornecedor) REFERENCES Fornecedores(idFornecedor),
    CONSTRAINT fk_pf_produto FOREIGN KEY(idProduto) REFERENCES Produtos(idProduto)
);

-- relação produtos vendedor
CREATE TABLE ProdutoVendedor(
    idVendedor INT,
    idProduto INT,
    QuantidadeAnunciada INT,
    CONSTRAINT pk_produto_vendedor PRIMARY KEY(idVendedor, idProduto),
    CONSTRAINT fk_pv_vendedor FOREIGN KEY(idVendedor) REFERENCES Vendedores(idVendedor),
    CONSTRAINT fk_pv_produto FOREIGN KEY(idProduto) REFERENCES Produtos(idProduto)
);