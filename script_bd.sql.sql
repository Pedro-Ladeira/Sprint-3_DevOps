-- DROP TABLES (PostgreSQL)
DROP TABLE IF EXISTS historico_posicao CASCADE;
DROP TABLE IF EXISTS alerta_evento CASCADE;
DROP TABLE IF EXISTS sensor_iot CASCADE;
DROP TABLE IF EXISTS moto CASCADE;
DROP TABLE IF EXISTS usuario_sistema CASCADE;
DROP TABLE IF EXISTS modelo CASCADE;
DROP TABLE IF EXISTS patio CASCADE;
DROP TABLE IF EXISTS auditoria_moto CASCADE;

-- CRIAÇÃO DAS TABELAS
CREATE TABLE usuario_sistema (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(100),
    senha VARCHAR(255)
);

CREATE TABLE modelo (
    id_modelo SERIAL PRIMARY KEY,
    fabricante VARCHAR(50),
    nome_modelo VARCHAR(50),
    cilindrada INTEGER,
    tipo VARCHAR(30)
);

CREATE TABLE patio (
    id_patio SERIAL PRIMARY KEY,
    nome_patio VARCHAR(50),
    localizacao_patio VARCHAR(50),
    area_total NUMERIC(10,2),
    capacidade_maxima INTEGER
);

CREATE TABLE moto (
    id_moto SERIAL PRIMARY KEY,
    placa VARCHAR(10),
    chassi VARCHAR(50),
    ano_fabricacao INTEGER,
    status VARCHAR(20),
    modelo_id_modelo INTEGER REFERENCES modelo(id_modelo),
    id_patio INTEGER REFERENCES patio(id_patio),
    id_sensor_iot INTEGER,
    data_atualizacao DATE
);

CREATE TABLE sensor_iot (
    id_sensor_iot SERIAL PRIMARY KEY,
    tipo_sensor VARCHAR(20),
    data_transmissao DATE,
    bateria_percentual NUMERIC(5,2),
    id_moto INTEGER REFERENCES moto(id_moto)
);

ALTER TABLE moto ADD CONSTRAINT fk_sensor_iot FOREIGN KEY (id_sensor_iot) REFERENCES sensor_iot(id_sensor_iot);

CREATE TABLE historico_posicao (
    data_atualizacao TIMESTAMP,
    posicao_x NUMERIC(10,2),
    posicao_y NUMERIC(10,2),
    acuracia_localizacao NUMERIC(5,2),
    origem_detectada VARCHAR(20),
    status_no_momento VARCHAR(20),
    id_moto INTEGER REFERENCES moto(id_moto),
    PRIMARY KEY (data_atualizacao, id_moto)
);

CREATE TABLE alerta_evento (
    id_alerta SERIAL PRIMARY KEY,
    tipo_alerta VARCHAR(50),
    data_geracao TIMESTAMP,
    id_moto INTEGER REFERENCES moto(id_moto)
);

CREATE TABLE auditoria_moto (
    id_auditoria SERIAL PRIMARY KEY,
    usuario_banco VARCHAR(50),
    tipo_operacao VARCHAR(10),
    data_operacao TIMESTAMP,
    valor_anterior TEXT,
    valor_novo TEXT
);

-- TRIGGER DE AUDITORIA (PostgreSQL)
CREATE OR REPLACE FUNCTION trg_auditoria_moto() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO auditoria_moto (usuario_banco, tipo_operacao, data_operacao, valor_anterior, valor_novo)
        VALUES (current_user, 'INSERT', CURRENT_TIMESTAMP, NULL,
            json_build_object(
                'id_moto', NEW.id_moto,
                'placa', NEW.placa,
                'chassi', NEW.chassi,
                'ano_fabricacao', NEW.ano_fabricacao,
                'status', NEW.status
            )::text
        );
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO auditoria_moto (usuario_banco, tipo_operacao, data_operacao, valor_anterior, valor_novo)
        VALUES (current_user, 'UPDATE', CURRENT_TIMESTAMP,
            json_build_object(
                'id_moto', OLD.id_moto,
                'placa', OLD.placa,
                'chassi', OLD.chassi,
                'ano_fabricacao', OLD.ano_fabricacao,
                'status', OLD.status
            )::text,
            json_build_object(
                'id_moto', NEW.id_moto,
                'placa', NEW.placa,
                'chassi', NEW.chassi,
                'ano_fabricacao', NEW.ano_fabricacao,
                'status', NEW.status
            )::text
        );
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO auditoria_moto (usuario_banco, tipo_operacao, data_operacao, valor_anterior, valor_novo)
        VALUES (current_user, 'DELETE', CURRENT_TIMESTAMP,
            json_build_object(
                'id_moto', OLD.id_moto,
                'placa', OLD.placa,
                'chassi', OLD.chassi,
                'ano_fabricacao', OLD.ano_fabricacao,
                'status', OLD.status
            )::text, NULL
        );
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_auditoria_moto ON moto;
CREATE TRIGGER trg_auditoria_moto
AFTER INSERT OR UPDATE OR DELETE ON moto
FOR EACH ROW EXECUTE FUNCTION trg_auditoria_moto();

-- INSERÇÃO DE DADOS
INSERT INTO usuario_sistema (nome, email, senha) VALUES
('João Silva', 'joao.silva@email.com', 'senha123'),
('Maria Souza', 'maria.souza@email.com', 'senha456'),
('Pedro Oliveira', 'pedro.oliveira@email.com', 'senha789'),
('Ana Santos', 'ana.santos@email.com', 'senha101'),
('Carlos Ferreira', 'carlos.ferreira@email.com', 'senha202');

INSERT INTO modelo (fabricante, nome_modelo, cilindrada, tipo) VALUES
('Honda', 'CG 160', 160, 'Street'),
('Yamaha', 'Fazer 250', 250, 'Street'),
('BMW', 'G 310 GS', 310, 'Adventure'),
('Kawasaki', 'Ninja 400', 400, 'Sport'),
('Harley-Davidson', 'Iron 883', 883, 'Cruiser');

INSERT INTO patio (nome_patio, localizacao_patio, area_total, capacidade_maxima) VALUES
('Pátio Central', 'Centro', 500.50, 50),
('Pátio Norte', 'Zona Norte', 350.75, 35),
('Pátio Sul', 'Zona Sul', 420.30, 40),
('Pátio Leste', 'Zona Leste', 380.25, 38),
('Pátio Oeste', 'Zona Oeste', 450.00, 45);

INSERT INTO sensor_iot (tipo_sensor, data_transmissao, bateria_percentual, id_moto) VALUES
('GPS', '2025-05-15', 85.5, NULL),
('GPS', '2025-05-16', 92.3, NULL),
('Movimento', '2025-05-17', 78.1, NULL),
('Temperatura', '2025-05-18', 65.8, NULL),
('GPS', '2025-05-19', 89.7, NULL);

INSERT INTO moto (placa, chassi, ano_fabricacao, status, modelo_id_modelo, id_patio, id_sensor_iot, data_atualizacao) VALUES
('ABC1234', 'CH001ABC', 2022, 'Disponível', 1, 1, 1, '2025-05-15'),
('DEF5678', 'CH002DEF', 2023, 'Em Uso', 2, 2, 2, '2025-05-16'),
('GHI9012', 'CH003GHI', 2021, 'Manutenção', 3, 3, 3, '2025-05-17'),
('JKL3456', 'CH004JKL', 2024, 'Disponível', 4, 4, 4, '2025-05-18'),
('MNO7890', 'CH005MNO', 2022, 'Em Uso', 5, 5, 5, '2025-05-19');

UPDATE sensor_iot SET id_moto = 1 WHERE id_sensor_iot = 1;
UPDATE sensor_iot SET id_moto = 2 WHERE id_sensor_iot = 2;
UPDATE sensor_iot SET id_moto = 3 WHERE id_sensor_iot = 3;
UPDATE sensor_iot SET id_moto = 4 WHERE id_sensor_iot = 4;
UPDATE sensor_iot SET id_moto = 5 WHERE id_sensor_iot = 5;

INSERT INTO historico_posicao VALUES ('2025-05-15 08:00:00', 100.25, 200.35, 3.5, 'GPS', 'Estacionada', 1);
INSERT INTO historico_posicao VALUES ('2025-05-16 09:15:00', 150.50, 250.75, 2.8, 'GPS', 'Em Movimento', 2);
INSERT INTO historico_posicao VALUES ('2025-05-17 10:30:00', 200.75, 300.90, 1.9, 'Triangulação', 'Estacionada', 3);
INSERT INTO historico_posicao VALUES ('2025-05-18 11:45:00', 250.30, 350.45, 4.2, 'GPS', 'Em Movimento', 4);
INSERT INTO historico_posicao VALUES ('2025-05-19 12:00:00', 300.60, 400.80, 2.5, 'Triangulação', 'Estacionada', 5);
INSERT INTO historico_posicao VALUES ('2025-05-15 14:30:00', 105.30, 205.40, 3.2, 'GPS', 'Em Movimento', 1);
INSERT INTO historico_posicao VALUES ('2025-05-16 15:45:00', 155.60, 255.80, 2.6, 'GPS', 'Estacionada', 2);

INSERT INTO alerta_evento (tipo_alerta, data_geracao, id_moto) VALUES
('Bateria Baixa', '2025-05-15 10:00:00', 1),
('Movimento Suspeito', '2025-05-16 11:30:00', 2),
('Sinal Perdido', '2025-05-17 13:45:00', 3),
('Manutenção Necessária', '2025-05-18 15:20:00', 4),
('Bateria Baixa', '2025-05-19 16:10:00', 5);

