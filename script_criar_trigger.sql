DELIMITER $$
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
    WHERE NEW.fkComponente = idComponentes;

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

-- Crie o procedimento inserir_qtd_alerta
DELIMITER $$
CREATE PROCEDURE inserir_qtd_alerta()
BEGIN
DECLARE qtdAlertaAlerta INT;
DECLARE qtdAlertaUrgente INT;
DECLARE qtdAlertaCritico INT;
    
SELECT COUNT(idAlerta) FROM Alerta
WHERE tipo_alerta = "alerta" 
AND dtHora <= date_sub(now(), INTERVAL 1 MINUTE)
INTO qtdAlertaAlerta;
    
SELECT COUNT(idAlerta) FROM Alerta
WHERE tipo_alerta = "urgente" 
AND dtHora <= date_sub(now(), INTERVAL 1 MINUTE)
INTO qtdAlertaUrgente;
    
SELECT COUNT(idAlerta) FROM Alerta
WHERE tipo_alerta = "critico" 
AND dtHora <= date_sub(now(), INTERVAL 1 MINUTE)
INTO qtdAlertaCritico;
    
IF qtdAlertaAlerta > 15 THEN
INSERT INTO quantidadeAlerta (tipo_alerta, dtHora)
VALUES ("alerta", now());
END IF;
    
IF qtdAlertaUrgente > 15 THEN
INSERT INTO quantidadeAlerta (tipo_alerta, dtHora) 
VALUES ("urgente", now());
END IF;
    
IF qtdAlertaCritico > 15 THEN
INSERT INTO quantidadeAlerta (tipo_alerta, dtHora) 
VALUES ("critico", now());
END IF;
    
END;
 $$ DELIMITER ;