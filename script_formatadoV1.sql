
DROP DATABASE IF EXISTS medconnect;
CREATE DATABASE IF NOT EXISTS medconnect;
USE medconnect;

CREATE TABLE IF NOT EXISTS Hospital (
    idHospital INT PRIMARY KEY AUTO_INCREMENT,
    nomeFantasia VARCHAR(45) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    razaoSocial VARCHAR(45) NOT NULL,
    sigla VARCHAR(45) NOT NULL,
    responsavelLegal VARCHAR(45) NOT NULL,
    fkHospitalSede INT,
    CONSTRAINT fkHospitalSede FOREIGN KEY (fkHospitalSede) REFERENCES Hospital (idHospital)
);


INSERT INTO Hospital (nomeFantasia, CNPJ, razaoSocial, sigla, responsavelLegal, fkHospitalSede) 
VALUES 
    ('Hospital ABC', '12345678901234', 'ABC Ltda', 'HABC', 'João da Silva', NULL),
    ('Hospital Einstein', '12325678901234', 'Einstein Ltda', 'HEIN', 'Maria Silva', NULL);


CREATE TABLE IF NOT EXISTS EscalonamentoFuncionario (
    idEscalonamento INT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(45) NOT NULL,
    prioridade INT NOT NULL
);


INSERT INTO EscalonamentoFuncionario (cargo, prioridade) 
VALUES 
    ('Atendente', 1),
    ('Engenheiro De Noc', 2),
    ('Admin', 3);


CREATE TABLE IF NOT EXISTS Funcionarios (
    idFuncionarios INT AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkHospital INT,
    fkEscalonamento INT,
    PRIMARY KEY (idFuncionarios, fkHospital),
    CONSTRAINT fkHospital FOREIGN KEY (fkHospital) REFERENCES Hospital (idHospital),
    CONSTRAINT fkEscalonamento FOREIGN KEY (fkEscalonamento) REFERENCES EscalonamentoFuncionario (idEscalonamento)
);


INSERT INTO Funcionarios (nome, email, CPF, telefone, senha, fkHospital, fkEscalonamento) 
VALUES 
    ('Kayky', 'kayky@abc.com', '12345678901', '987654321', '123456', 1, 1),
    ('Gabriel', 'gabriel@email.com', '12345678901', '987654321', '123456', 1, 2),
    ('Maria Souza', 'maria@example.com', '12345678901', '987654321', 'senha123', 1, 3);


CREATE TABLE IF NOT EXISTS statusRobo (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);


INSERT INTO statusRobo (nome) 
VALUES ('Ativo');


CREATE TABLE IF NOT EXISTS RoboCirurgiao (
    idRobo INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45) NOT NULL,
    fabricacao VARCHAR(45) NOT NULL,
    idProcess VARCHAR(45),
    fkStatus INT,
    fkHospital INT,
    CONSTRAINT fkStatus FOREIGN KEY (fkStatus) REFERENCES statusRobo (idStatus),
    CONSTRAINT fkHospitalRobo FOREIGN KEY (fkHospital) REFERENCES Hospital (idHospital)
);


INSERT INTO RoboCirurgiao (modelo, fabricacao, fkStatus, fkHospital, idProcess) 
VALUES ('Modelo A', '2023-09-12', 1, 1, 'B2532B6');


CREATE TABLE IF NOT EXISTS associado (
    idAssociado INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(45),
    fkEscalonamentoFuncionario INT,
    fkHospital INT,
    CONSTRAINT fkEscalonamentoFunc FOREIGN KEY (fkEscalonamentoFuncionario) REFERENCES EscalonamentoFuncionario (idEscalonamento),
    CONSTRAINT fkHospitalAssociado FOREIGN KEY (fkHospital) REFERENCES Hospital (idHospital)
);


INSERT INTO associado VALUES (null, 'erick@email.com', 1, 1);


CREATE TABLE IF NOT EXISTS SalaCirurgiao (
    idSala INT AUTO_INCREMENT,
    numero VARCHAR(5) NOT NULL,
    fkHospitalSala INT,
    fkRoboSala INT,
    PRIMARY KEY (idSala, fkHospitalSala, fkRoboSala),
    CONSTRAINT fkHospitalSala FOREIGN KEY (fkHospitalSala) REFERENCES Hospital (idHospital),
    CONSTRAINT fkRoboSala FOREIGN KEY (fkRoboSala) REFERENCES RoboCirurgiao (idRobo)
);


INSERT INTO SalaCirurgiao (numero, fkHospitalSala, fkRoboSala) 
VALUES ('101', 1, 1);


CREATE TABLE IF NOT EXISTS categoriaCirurgia (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    niveisPericuloridade VARCHAR(45) NOT NULL
);


INSERT INTO categoriaCirurgia (niveisPericuloridade) 
VALUES ('Alto');


CREATE TABLE IF NOT EXISTS cirurgia (
    idCirurgia INT NOT NULL,
    fkRoboCirurgia INT,
    dataHorario DATETIME NOT NULL,
    fkCategoria INT,
    CONSTRAINT fkRoboCirurgia FOREIGN KEY (fkRoboCirurgia) REFERENCES RoboCirurgiao (idRobo),
    CONSTRAINT fkCategoria FOREIGN KEY (fkCategoria) REFERENCES categoriaCirurgia (idCategoria)
);

INSERT INTO cirurgia (idCirurgia, fkRoboCirurgia, dataHorario, fkCategoria) 
VALUES (1, 1, '2023-09-15 14:00:00', 1);


CREATE TABLE IF NOT EXISTS Metrica (
    idMetrica INT PRIMARY KEY AUTO_INCREMENT,
    alerta DOUBLE,
    urgente DOUBLE,
    critico DOUBLE,
    qtdAlerta INT,
    qtdUrgente INT,
    qtdCritico INT,
    tipo_dado VARCHAR(50)
);


INSERT INTO Metrica (alerta, urgente, critico, tipo_dado) VALUES
    (0.60, 0.70, 0.80, 'Porcentagem de Uso'),
    (0.901, 0.93, 0.95, 'Porcentagem de Uso'),
    (0.70, 0.80, 0.90, 'Porcentagem de Uso');


CREATE TABLE IF NOT EXISTS categoriaComponente (
    idCategoriaComponente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);


INSERT INTO categoriaComponente (idCategoriaComponente, nome) VALUES
    (1, 'CPU'),
    (2, 'Memória RAM'),
    (3, 'Disco'),
    (4, 'Rede');


CREATE TABLE IF NOT EXISTS componentes (
    idComponentes INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    unidade VARCHAR(10),
    descricaoAdd VARCHAR(45),
    fkCategoriaComponente INT,
    fkMetrica INT,
    CONSTRAINT fkCategoriaComponente FOREIGN KEY (fkCategoriaComponente) REFERENCES categoriaComponente (idCategoriaComponente),
    CONSTRAINT frkMetrica FOREIGN KEY (fkMetrica) REFERENCES Metrica (idMetrica)
);

INSERT INTO componentes (nome, unidade, fkCategoriaComponente, fkMetrica) 
VALUES ('Porcentagem da CPU', "%", 1, 1),
("Velocidade da CPU", "GHz", 1, null),
("Tempo no sistema da CPU", "s", 1, null),
("Processos da CPU", null, 1, null);

INSERT INTO componentes (nome, unidade, fkCategoriaComponente, fkMetrica) 
VALUES ('Porcentagem da Memoria', '%', 2, 2),
('Total da Memoria', 'GB', 2, null),
('Uso da Memoria', 'GB', 2, null),
('Porcentagem da Memoria Swap', '%',2,null),
('Uso da Memoria Swap', 'GB', 2, null);

INSERT INTO componentes (nome, unidade, fkCategoriaComponente, fkMetrica) 
VALUES ('Porcentagem do Disco', '%', 3, 3),
('Total do Disco', 'GB', 3, null),
('Uso do Disco', 'GB', 3, null),
('Tempo de Leitura do Disco', 's', 3, null),
('Tempo de Escrita do Disco', 's', 3, null);

INSERT INTO componentes (nome, descricaoAdd, fkCategoriaComponente) 
VALUES ('Status da Rede', 'Conexao da Rede', 4),
("Latencia de Rede", 'Latencia em MS', 4),
('Bytes enviados','Bytes enviados da Rede', 4),
('Bytes recebidos','Bytes recebidos da Rede', 4);



INSERT INTO componentes (nome, unidade, fkCategoriaComponente, fkMetrica) 
VALUES 
('Total do Disco', 'GB', 3, null),
('Uso do Disco', 'GB', 3, null),
('Tempo de Leitura do Disco', 's', 3, null),
('Tempo de Escrita do Disco', 's', 3, null);


INSERT INTO componentes (nome, descricaoAdd, fkCategoriaComponente) 
VALUES ('Status da Rede', 'Conexao da Rede', 4),
("Latencia de Rede", 'Latencia em MS', 4),
('Bytes enviados','Bytes enviados da Rede', 4),
('Bytes recebidos','Bytes recebidos da Rede', 4);



CREATE TABLE dispositivos_usb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    dataHora DATETIME,
    id_produto VARCHAR(10),
    fornecedor VARCHAR(255),
    conectado BOOLEAN,
    fkRoboUsb int , 
constraint fkRoboUsb foreign key (fkRoboUsb) references  RoboCirurgiao(idRobo)
);


CREATE TABLE IF NOT EXISTS Registros (
    idRegistro INT AUTO_INCREMENT,
    fkRoboRegistro INT,
    HorarioDado DATETIME NOT NULL,
    dado DOUBLE NOT NULL,
    fkComponente INT,
    PRIMARY KEY (idRegistro, fkRoboRegistro),
    CONSTRAINT fkRoboRegistro FOREIGN KEY (fkRoboRegistro) REFERENCES RoboCirurgiao (idRobo),
    CONSTRAINT fkComponente FOREIGN KEY (fkComponente) REFERENCES componentes (idComponentes)
);


CREATE TABLE IF NOT EXISTS Alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo_alerta VARCHAR(15),
    fkRegistro INT,
    fkRobo INT,
    dtHora DATETIME,
    nome_componente VARCHAR(45),
    dado DOUBLE
);


CREATE TABLE IF NOT EXISTS quantidadeAlerta (
    idQuantidadeAlerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo_alerta VARCHAR(10),
    dtHora DATETIME
);

DELIMITER $$

-- Criação do Trigger
CREATE TRIGGER criarAlerta
AFTER INSERT ON Registros
FOR EACH ROW
BEGIN
    DECLARE id_metrica INT;
    DECLARE v_alerta DOUBLE;
    DECLARE v_urgente DOUBLE;
    DECLARE v_critico DOUBLE;
    DECLARE v_componente VARCHAR(45);

    SELECT fkMetrica, nome INTO id_metrica, v_componente
    FROM componentes
    WHERE NEW.fkComponenteRegistro = idComponentes;

    SELECT critico, urgente, alerta INTO v_critico, v_urgente, v_alerta
    FROM Metrica
    WHERE idMetrica = id_metrica;

    IF NEW.dado >= v_critico THEN
        INSERT INTO Alerta (tipo_alerta, fkRegistro, fkRobo, dtHora, nome_componente, dado)
        VALUES ('critico', NEW.idRegistro, NEW.fkRoboRegistro, NOW(), v_componente, NEW.dado);
    ELSEIF NEW.dado >= v_urgente THEN
        INSERT INTO Alerta (tipo_alerta, fkRegistro, fkRobo, dtHora, nome_componente, dado)
        VALUES ('urgente', NEW.idRegistro, NEW.fkRoboRegistro, NOW(), v_componente, NEW.dado);
    ELSEIF NEW.dado >= v_alerta THEN
        INSERT INTO Alerta (tipo_alerta, fkRegistro, fkRobo, dtHora, nome_componente, dado)
        VALUES ('alerta', NEW.idRegistro, NEW.fkRoboRegistro, NOW(), v_componente, NEW.dado);
    END IF;
END;
$$ DELIMITER ;

-- Criação do Procedimento
DELIMITER $$
CREATE PROCEDURE inserir_qtd_alerta()
BEGIN
    DECLARE qtdAlertaAlerta INT;
    DECLARE qtdAlertaUrgente INT;
    DECLARE qtdAlertaCritico INT;
    
    SELECT COUNT(idAlerta) INTO qtdAlertaAlerta
    FROM Alerta
    WHERE tipo_alerta = 'alerta' AND dtHora <= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

    SELECT COUNT(idAlerta) INTO qtdAlertaUrgente
    FROM Alerta
    WHERE tipo_alerta = 'urgente' AND dtHora <= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

    SELECT COUNT(idAlerta) INTO qtdAlertaCritico
    FROM Alerta
    WHERE tipo_alerta = 'critico' AND dtHora <= DATE_SUB(NOW(), INTERVAL 1 MINUTE);
    
    IF qtdAlertaAlerta > 15 THEN
        INSERT INTO quantidadeAlerta (tipo_alerta, dtHora) VALUES ('alerta', NOW());
    END IF;
    
    IF qtdAlertaUrgente > 15 THEN
        INSERT INTO quantidadeAlerta (tipo_alerta, dtHora) VALUES ('urgente', NOW());
    END IF;
    
    IF qtdAlertaCritico > 15 THEN
        INSERT INTO quantidadeAlerta (tipo_alerta, dtHora) VALUES ('critico', NOW());
    END IF;
    
END;
$$ DELIMITER ;


