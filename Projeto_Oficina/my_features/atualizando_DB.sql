-- VERSÃO REFINADA

-- DROP DATABASE IF EXISTS repairShop; -- Use esta linha se precisar apagar e recomeçar
CREATE DATABASE IF NOT EXISTS repairShop;
USE repairShop;

CREATE TABLE clients(
    idClient INT AUTO_INCREMENT,
    Fname VARCHAR(10) NOT NULL,
    Lname VARCHAR(20) NOT NULL,
    FedId CHAR(11) NOT NULL COMMENT 'Restrição: 1 CPF por pessoa',
    CONSTRAINT pk_Clients PRIMARY KEY(idClient),
    CONSTRAINT uq_Clients UNIQUE(FedId)
);

CREATE TABLE vehicles(
    idVehicle INT AUTO_INCREMENT,
    idClient INT,
    CarModel VARCHAR(15) NOT NULL,
    CarBrand VARCHAR(10),
    CarColor VARCHAR(10),
    LicensePlate CHAR(8) NOT NULL,
    CONSTRAINT pk_Vehicle PRIMARY KEY(idVehicle),
    CONSTRAINT uq_Plate UNIQUE(LicensePlate),
    CONSTRAINT fk_client FOREIGN KEY(idClient) REFERENCES clients(idClient)
);


CREATE TABLE mechanics(
    idMechanic INT AUTO_INCREMENT,
    Mresponsable VARCHAR(30) NOT NULL,
    MFedId CHAR(11) NOT NULL,
    -- MELHORIA 2: Trocado FLOAT por DECIMAL para precisão monetária
    HourCost DECIMAL(10, 2),
	CONSTRAINT pk_Mechanics PRIMARY KEY(idMechanic),
    CONSTRAINT uq_Mechanics UNIQUE(MFedId)
);

CREATE TABLE autoParts(
    -- Adicionado AUTO_INCREMENT para o ID
    idParts INT AUTO_INCREMENT,
    Pname VARCHAR(25) NOT NULL,
    -- Trocado FLOAT por DECIMAL para precisão monetária
    Pcost DECIMAL(10, 2),
    Pstatus ENUM('Disponível', 'Fora de Estoque', 'Solicitado') DEFAULT 'Disponível',
    CONSTRAINT pk_Parts PRIMARY KEY(idParts),
    CONSTRAINT uq_Parts UNIQUE(Pname)
);

CREATE TABLE serviceRequests(
    idRequest INT AUTO_INCREMENT,
    idVehicle INT,
    RequestType ENUM('Reparo', 'Revisão') DEFAULT 'Revisão',
    Description VARCHAR(255) NOT NULL,
    Status ENUM('Aprovado', 'Em andamento', 'Cancelado', 'Finalizado') DEFAULT 'Aprovado',
    -- Adicionada a data da solicitação para controle gerencial
    RequestDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_Requests PRIMARY KEY(idRequest),
    CONSTRAINT fk_vehicles FOREIGN KEY(idVehicle) REFERENCES vehicles(idVehicle)
);

CREATE TABLE mechanicService(
    idMService INT AUTO_INCREMENT,
    idRequest INT,
    idMechanic INT,
    workHours FLOAT,
    CONSTRAINT pk_MechanicService PRIMARY KEY(idMservice),
    CONSTRAINT fk_MechanicService FOREIGN KEY(idMechanic) REFERENCES mechanics(idMechanic),
    CONSTRAINT fk_RequestService FOREIGN KEY(idRequest) REFERENCES serviceRequests(idRequest)
);

CREATE TABLE partService(
    idPService INT AUTO_INCREMENT,
    idRequest INT,
    idPart INT,
    Pquantity INT,
    CONSTRAINT pk_PartService PRIMARY KEY(idPService),
    CONSTRAINT fk_PartService FOREIGN KEY(idPart) REFERENCES autoParts(idParts),
    CONSTRAINT fk_RequestPart FOREIGN KEY(idRequest) REFERENCES serviceRequests(idRequest)
);
