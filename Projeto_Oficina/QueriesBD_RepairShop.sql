-- Recuperando Informações com queries SQL

-- Seleção da base completa de clientes
SELECT * FROM clients;


-- Seleção dos carros por Cliente
SELECT concat(c.Fname, ' ', c.Lname) as Client, CarModel, CarColor, CarBrand, LicensePlate
	FROM clients c, vehicles v
   	WHERE c.idClient = v.idClient;


-- Mapeamento de Carros com rodízio em SP de Terça-feira
SELECT concat(c.Fname, ' ', c.Lname) as Client, CarModel, CarColor, CarBrand, LicensePlate
	FROM clients c, vehicles v
   	WHERE c.idClient = v.idClient AND LicensePlate LIKE '%4' OR LicensePlate LIKE '%3';


-- Seleção do tipo de serviço de cada Pedido
SELECT idRequest, concat(Fname, ' ', Lname) as Client, RequestType, r.Status, CarModel, CarColor, LicensePlate
	FROM serviceRequests r, vehicles v, clients c
    	WHERE r.idVehicle = v.idVehicle AND c.idClient = v.idClient
    	ORDER BY idRequest;


-- Valor de Hora trabalhada por mecanico e serviço
SELECT Mresponsable, r.RequestType, round(workHours,2) as workHours, round((workHours * HourCost),2) as Labor
	FROM mechanicService ms INNER JOIN mechanics m
        ON ms.idMechanic = m.idMechanic
        INNER JOIN serviceRequests r
        	ON ms.idRequest = r.idRequest
    ORDER BY Labor DESC;

-- Classificação de Mecanicos por Valor recebido sobre os serviços
SELECT Mresponsable, round(workHours,2) as workHours, round((workHours * HourCost),2) as Labor
	FROM mechanicService ms, mechanics m
    	WHERE ms.idMechanic = m.idMechanic
    	ORDER BY Labor DESC;

-- Having Statement e Join Statement: Classificação de Mecanicos com 2+ serviços
SELECT Mresponsable, r.RequestType, round(workHours,2) as workHours, round((workHours * HourCost),2) as Labor
	FROM mechanicService ms INNER JOIN mechanics m
        ON ms.idMechanic = m.idMechanic
        INNER JOIN serviceRequests r
        	ON ms.idRequest = r.idRequest
    HAVING COUNT(*)>1
    ORDER BY Labor DESC;

-- Case Statement: Designação de atividades para os mecânicos baseado no Status do Serviço
-- Status Cancelado: Rever Proposta
-- Status Aprovado: Agendamento de serviço
-- Status Finalizado: Pós venda
-- Status Em andamento: resultado nulo 
SELECT concat(c.Fname, ' ', c.Lname) as Client, concat(v.CarModel, ' ', v.CarColor) as Car, v.LicensePlate, r.RequestType, r.Status
	CASE
    	WHEN r.Status = 'Cancelado' THEN 'Rever proposta de serviço'
        WHEN r.Status = 'Aprovado' THEN 'Entrar em contato para agendamento'
        WHEN r.Status = 'Finalizado' THEN 'Realizar pós-venda'
        ELSE NULL
    END AS MechanicActivity
    FROM vehicles v INNER JOIN clients c
	   	ON v.idClient = c.idClient
        INNER JOIN serviceRequests r
        	ON v.idVehicle = r.idVehicle;