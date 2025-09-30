
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE partService;
TRUNCATE TABLE mechanicService;
TRUNCATE TABLE serviceRequests;
TRUNCATE TABLE autoParts;
TRUNCATE TABLE mechanics;
TRUNCATE TABLE vehicles;
TRUNCATE TABLE clients;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO clients(Fname, Lname, FedId) VALUES
	('Marcelina', 'Barros', '12365497899'),
	('Carlos', 'Jesus', '85749658246'),
	('Silvina', 'Albuquerque', '46695877215'),
	('Jose', 'Aparecido', '96553815978'),
	('Antonia', 'Gomes', '36915984211'),
    ('Ricardo', 'Mendes', '98765432100'),
    ('Beatriz', 'Costa', '12312312312');

INSERT INTO vehicles(idClient, CarModel, CarBrand, CarColor, LicensePlate) VALUES
	(1, 'Fiesta', 'Ford', 'Vermelho', 'ABC12D4'),
	(1, 'Kicks', 'Nissan', 'Vermelho', 'EFG43Z1'),
	(1, 'T-Cross', 'VW', 'Chumbo', 'AAA12D3'),
 (2, 'TAOS', 'VW', 'Chumbo', 'UFR56A6'),
  (2, 'Kicks', 'Nissan', 'Azul', 'KLB74R8'),
 (3, 'Palio', 'Fiat', 'Preto', 'RGB54B0'),
 (4, 'T-Cross', 'VW', 'Branco', 'CMY55K5'),
 (4, 'Onix', 'GM', 'Prata', 'CLE35G7'),
 (5, 'Onix', 'GM', 'Preto', 'RAF4EL2'),
    (6, 'Corolla', 'Toyota', 'Prata', 'XYZ1234'),
    (7, 'HB20', 'Hyundai', 'Branco', 'QWE5678');

INSERT INTO mechanics(Mresponsable, MFedId, HourCost) VALUES
	('Florentina de Jesus','12332112332', 75.80),
    ('Zezinho Noronha','95195175328', 69.50),
    ('Lucianinho Mello','75335775391', 69.00),
    ('Giovana FLores', '82888999977', 70.00),
    ('Roberto Carlos', '10203040506', 85.00);

INSERT INTO autoParts(Pname, Pcost, Pstatus) VALUES
	('Motor','2350.90', 'Solicitado'),
    ('Amortecedor','199.90', 'Fora de Estoque'),
    ('Filtro de Ar','79.80', 'Disponível'),
    ('Fluído de Freio 1L', '35.50', 'Disponível'),
    ('Óleo de Motor 1L', '49.90', 'Disponível'),
    ('Fluído de Cambio 1L', '69.60', 'Disponível'),
    ('Vela de Ignição', '25.00', 'Disponível'),
    ('Bateria 60Ah', '350.00', 'Disponível'),
    ('Pneu Aro 15', '450.00', 'Fora de Estoque'),
    ('Pastilha de Freio', '120.00', 'Disponível');

INSERT INTO serviceRequests(idVehicle, RequestType, Description, Status, RequestDate) VALUES
	(3, 'Revisão','Cliente reclamou de pastilhas de freio', 'Aprovado', '2024-07-10'),
    (4, 'Reparo','Troca de Amortecedor Dianteiro', 'Em andamento', '2024-07-11'),
    (8, 'Reparo','Verificar motor', 'Finalizado', '2024-07-05'),
    (7, 'Revisão', 'Incluir troca de filtro de Ar', 'Finalizado', '2024-07-08'),
    (1, 'Revisão', 'Trocar Fluídos de Freio e Câmbio', 'Em andamento', '2024-07-12'),
    (6, 'Reparo', 'Trocar Bateria', 'Cancelado', '2024-07-09'),
    (10, 'Revisão', 'Revisão completa de 30.000km', 'Finalizado', '2024-06-20'),
    (11, 'Reparo', 'Carro não liga, verificar bateria', 'Aprovado', '2024-07-13'),
    (2, 'Reparo', 'Trocar os 4 pneus', 'Aprovado', '2024-07-14'),
    (5, 'Reparo', 'Falha no motor, trocar velas de ignição', 'Finalizado', '2024-07-01');

INSERT INTO mechanicService(idRequest, idMechanic, WorkHours) VALUES
	(1, 1, 3.75),
    (2, 3, 6.5),
    (3, 1, 4.0),
    (4, 2, 1.9),
    (5, 4, 2.0),
    (6, 3, 0.5),
    (7, 5, 8.0),
    (8, 4, 1.5),
    (9, 2, 2.5),
    (10, 5, 2.0);

INSERT INTO partService(idRequest, idPart, Pquantity) VALUES
	(1, 4, 2), -- Fluído de Freio para Revisão do Veículo 3
    (2, 2, 1), -- Amortecedor para Reparo do Veículo 4
    (3, 1, 1), -- Motor para Reparo do Veículo 8
    (4, 3, 1), -- Filtro de Ar para Revisão do Veículo 7
    (5, 4, 2), -- Fluído de Freio para Revisão do Veículo 1
    (5, 6, 3), -- Fluído de Cambio para Revisão do Veículo 1
    (7, 5, 4), -- Óleo de Motor para Revisão do Veículo 10
    (7, 3, 1), -- Filtro de Ar para Revisão do Veículo 10
    (8, 8, 1), -- Bateria para Reparo do Veículo 11
    (9, 9, 4), -- Pneus para Reparo do Veículo 2
    (10, 7, 4); -- Velas de Ignição para Reparo do Veículo 5
