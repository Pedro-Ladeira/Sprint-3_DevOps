-- V001__create_inicial_tables.sql (PostgreSQL)

CREATE TABLE IF NOT EXISTS usuario_sistema (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(100),
    senha VARCHAR(255),
    perfil VARCHAR(20) DEFAULT 'OPERADOR',
    ativo INTEGER DEFAULT 1
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_usuario_email ON usuario_sistema(email);

CREATE TABLE IF NOT EXISTS modelo (
    id_modelo SERIAL PRIMARY KEY,
    fabricante VARCHAR(50),
    nome_modelo VARCHAR(50),
    cilindrada INTEGER,
    tipo VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS patio (
    id_patio SERIAL PRIMARY KEY,
    nome_patio VARCHAR(50),
    localizacao_patio VARCHAR(50),
    area_total NUMERIC(10,2),
    capacidade_maxima INTEGER
);

CREATE TABLE IF NOT EXISTS sensor_iot (
    id_sensor_iot SERIAL PRIMARY KEY,
    tipo_sensor VARCHAR(20),
    data_transmissao DATE,
    bateria_percentual NUMERIC(5,2),
    id_moto INTEGER REFERENCES moto(id_moto)
);

CREATE TABLE IF NOT EXISTS moto (
    id_moto SERIAL PRIMARY KEY,
    placa VARCHAR(10),
    chassi VARCHAR(50),
    ano_fabricacao INTEGER,
    status VARCHAR(20),
    modelo_id_modelo INTEGER REFERENCES modelo(id_modelo),
    id_patio INTEGER REFERENCES patio(id_patio),
    id_sensor_iot INTEGER REFERENCES sensor_iot(id_sensor_iot),
    data_atualizacao DATE
);

CREATE TABLE IF NOT EXISTS historico_posicao (
    data_atualizacao DATE,
    posicao_x NUMERIC(10,2),
    posicao_y NUMERIC(10,2),
    acuracia_localizacao NUMERIC(5,2),
    origem_detectada VARCHAR(20),
    status_no_momento VARCHAR(20),
    id_moto INTEGER REFERENCES moto(id_moto),
    PRIMARY KEY (data_atualizacao, id_moto)
);

CREATE TABLE IF NOT EXISTS alerta_evento (
    id_alerta SERIAL PRIMARY KEY,
    tipo_alerta VARCHAR(50),
    data_geracao DATE,
    id_moto INTEGER REFERENCES moto(id_moto)
);
