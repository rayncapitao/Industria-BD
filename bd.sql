CREATE DATABASE industria;

CREATE TABLE regiao (
	RegiaoID INT IDENTITY(1,1) PRIMARY KEY,
	regiaoNome VARCHAR(200) NOT NULL	
);

CREATE TABLE ponto (
	PontoID INT IDENTITY(1,1) PRIMARY KEY,
	pontoNome VARCHAR(200) NOT NULL,
	RegiaoID INT NOT NULL,
	FOREIGN KEY (RegiaoID) REFERENCES regiao(RegiaoID)
);

CREATE TABLE cliente (
	ClienteID INT IDENTITY(1,1) PRIMARY KEY,
	nomeCliente VARCHAR(200) NOT NULL
);

CREATE TABLE produto (
	ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
	nomeProduto VARCHAR(200) NOT NULL,
	ativoProduto VARCHAR(200) NOT NULL,
	estoqueProduto INT NOT NULL
);

CREATE TABLE pedido (
	PedidoID INT IDENTITY(1,1) PRIMARY KEY,
	ProdutoID INT NOT NULL,
	ClienteID INT NOT NULL,
	FOREIGN KEY (ProdutoID) REFERENCES produto(ProdutoID),
	FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

CREATE TABLE veiculo (
	VeiculoID INT IDENTITY(1,1) PRIMARY KEY,
	placaVeiculo VARCHAR(200) NOT NULL,
	modeloVeiculo VARCHAR(200) NOT NULL,
	corVeiculo VARCHAR(200) NOT NULL
);

CREATE TABLE vendedor (
	VendedorID INT IDENTITY(1,1) PRIMARY KEY,
	nomeVendedor VARCHAR(200) NOT NULL,
	telefoneVendedor VARCHAR(200) NOT NULL,
	VeiculoID INT NOT NULL,
	RegiaoID INT NOT NULL,
	PedidoID INT NOT NULL,
	FOREIGN KEY (VeiculoID) REFERENCES veiculo(VeiculoID),
	FOREIGN KEY (RegiaoID) REFERENCES regiao(RegiaoID),
	FOREIGN KEY (PedidoID) REFERENCES pedido(PedidoID)
);

CREATE TABLE nota (
	NotaID INT IDENTITY(1,1) PRIMARY KEY,
	ClienteID INT NOT NULL,
	VendedorID INT NOT NULL,
	PedidoID INT NOT NULL,
	valorNota VARCHAR(200) NOT NULL,
	FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID),
	FOREIGN KEY (VendedorID) REFERENCES vendedor(VendedorID),
	FOREIGN KEY (PedidoID) REFERENCES pedido(PedidoID)
);

/* Insert */

USE industria;

INSERT INTO regiao(regiaoNome)
VALUES ('Itaquera'), ('Artur Alvim'), ('Patriarca'), ('Guilhermina'), ('Vila Matilde');
INSERT INTO ponto(pontoNome, RegiaoID) 
VALUES ('Ponto 1', '1'), ('Ponto 2', '2'), ('Ponto 3', '3'), ('Ponto 4', '4'), ('Ponto 5', '5');
INSERT INTO cliente(nomeCliente)
VALUES ('Ryan'), ('Pedro'), ('Rogerio'), ('Luis'), ('Samuel');
INSERT INTO produto(nomeProduto, ativoProduto, estoqueProduto)
VALUES ('io-io', 'sim', '7'), ('corda', 'sim', '19'), ('bola', 'nao', '23'), ('pipa', 'nao', '8'), ('gude', 'sim', '201');
INSERT INTO pedido(ProdutoID, ClienteID)
VALUES ('1', '1'), ('2', '2'), ('3', '3'), ('4', '4'), ('5', '5');
INSERT INTO veiculo(placaVeiculo, modeloVeiculo, corVeiculo)
VALUES ('PEG-0923', 'fusca', 'azul'), ('HKS-1786', 'corsa', 'amarelo'), ('IUA-5621', 'c4', 'vermelho'), ('NOA-0652', 'uno', 'prata'), ('JAS-7791', 'hb20', 'preto');
INSERT INTO vendedor(nomeVendedor, telefoneVendedor, VeiculoID, RegiaoID, PedidoID)
VALUES ('Navarra', '98293-3474', '1', '1', '1'), ('Paula', '98643-2385', '2', '2', '2'), ('Tanno', '97541-1371', '3', '3', '3'), ('Guilherme', '95541-1769', '4', '4', '4'), ('Carlos', '95181-6765', '5', '5', '5');
INSERT INTO nota(ClienteID, VendedorID, PedidoID, valorNota)
VALUES ('1', '1', '1', '26'), ('2', '2', '2', '15'), ('3', '3', '3', '32'), ('4', '4', '4', '11'), ('5', '5', '5', '22');

/* Select */

SELECT * FROM regiao ORDER BY regiaoNome ASC;
SELECT * FROM vendedor ORDER BY nomeVendedor ASC;
SELECT * FROM cliente ORDER BY nomeCliente ASC;

SELECT nota.NotaID, cliente.ClienteID, nota.valorNota, cliente.nomeCliente FROM nota LEFT JOIN cliente ON ( nota.NotaID = cliente.ClienteID ) WHERE valorNota >= 20
SELECT pedido.PedidoID, pedido.PedidoID, nomeProduto, ativoProduto, estoqueProduto FROM pedido INNER JOIN produto ON ( pedido.PedidoID = produto.ProdutoID ) WHERE produto.ativoProduto = 'sim'
SELECT regiao.RegiaoID, ponto.PontoID, regiaoNome, pontoNome FROM regiao INNER JOIN ponto ON ( regiao.RegiaoID = ponto.PontoID ) WHERE pontoNome = 'Ponto 5'

SELECT nomeVendedor FROM vendedor WHERE EXISTS (SELECT corVeiculo FROM veiculo WHERE corVeiculo = 'amarelo')
SELECT nomeCliente FROM cliente WHERE EXISTS (SELECT valorNota FROM nota WHERE valorNota >= 20)
SELECT regiaoNome FROM regiao WHERE EXISTS (SELECT pontoNome FROM ponto WHERE pontoNome = 'Ponto 5')
