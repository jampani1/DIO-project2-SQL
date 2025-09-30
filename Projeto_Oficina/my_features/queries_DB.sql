-- listar donos de veiculos de uma marca específica (VW)
SELECT
    CONCAT(c.Fname, ' ', c.Lname) AS NomeCompletoCliente,
    v.CarBrand AS Marca,
    v.CarModel AS Modelo,
    v.LicensePlate AS Placa
FROM
    clients AS c
INNER JOIN
    vehicles AS v ON c.idClient = v.idClient
WHERE
    v.CarBrand = 'VW'
ORDER BY
    v.CarModel;
    
-- calcular o faturamento de mão de obra por mecânico
SELECT
    m.Mresponsable AS Mecanico,
    COUNT(ms.idMService) AS QuantidadeServicos,
    SUM(ms.workHours) AS TotalHorasTrabalhadas,
    ROUND(SUM(ms.workHours * m.HourCost), 2) AS ValorTotalMaoDeObra
FROM
    mechanics AS m
INNER JOIN
    mechanicService AS ms ON m.idMechanic = ms.idMechanic
GROUP BY
    m.Mresponsable
ORDER BY
    ValorTotalMaoDeObra DESC;
    
-- calculo do custo total de cada ordem de serviço finalizada, somando peças e mão de obra
SELECT
    sr.idRequest AS OrdemDeServico,
    c.Fname AS Cliente,
    v.LicensePlate AS Placa,
    sr.RequestDate AS DataSolicitacao,
    -- Custo total da Mão de Obra
    ROUND(SUM(ms.workHours * m.HourCost), 2) AS CustoMaoDeObra,
    -- Custo total das Peças (IFNULL garante que se não houver peça, o custo é 0)
    ROUND(IFNULL(SUM(ps.Pquantity * ap.Pcost), 0), 2) AS CustoPecas,
    -- Custo GERAL (Atributo Derivado da soma dos outros)
    ROUND(SUM(ms.workHours * m.HourCost) + IFNULL(SUM(ps.Pquantity * ap.Pcost), 0), 2) AS CustoTotal
FROM
    serviceRequests AS sr
INNER JOIN mechanicService AS ms ON sr.idRequest = ms.idRequest
INNER JOIN mechanics AS m ON ms.idMechanic = m.idMechanic
INNER JOIN vehicles AS v ON sr.idVehicle = v.idVehicle
INNER JOIN clients AS c ON v.idClient = c.idClient
LEFT JOIN partService AS ps ON sr.idRequest = ps.idRequest
LEFT JOIN autoParts AS ap ON ps.idPart = ap.idParts
WHERE
    sr.Status = 'Finalizado'
GROUP BY
    sr.idRequest, c.Fname, v.LicensePlate, sr.RequestDate
ORDER BY
    CustoTotal DESC;
