-- V003__create_audit_table.sql (PostgreSQL)

CREATE SEQUENCE IF NOT EXISTS seq_versao_sistema START 1;

CREATE TABLE IF NOT EXISTS sistema_config (
    chave VARCHAR(100) PRIMARY KEY,
    valor VARCHAR(500) NOT NULL,
    descricao VARCHAR(255),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO sistema_config (chave, valor, descricao) VALUES
('VERSAO_SISTEMA', '1.0.0', 'Versão atual do sistema')
ON CONFLICT (chave) DO NOTHING;

INSERT INTO sistema_config (chave, valor, descricao) VALUES
('DIAS_MANTER_HISTORICO', '90', 'Dias para manter histórico de posições')
ON CONFLICT (chave) DO NOTHING;

INSERT INTO sistema_config (chave, valor, descricao) VALUES
('DIAS_MANTER_ALERTAS', '30', 'Dias para manter alertas')
ON CONFLICT (chave) DO NOTHING;

-- Trigger para atualizar data_atualizacao
CREATE OR REPLACE FUNCTION trg_sistema_config_update() RETURNS TRIGGER AS $$
BEGIN
    NEW.data_atualizacao := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sistema_config_update ON sistema_config;
CREATE TRIGGER trg_sistema_config_update
BEFORE UPDATE ON sistema_config
FOR EACH ROW EXECUTE FUNCTION trg_sistema_config_update();

-- Views auxiliares
CREATE OR REPLACE VIEW vw_motos_resumo AS
SELECT m.id_moto, m.placa, m.status,
       md.fabricante, md.nome_modelo,
       p.nome_patio, s.tipo_sensor, s.bateria_percentual
FROM moto m
LEFT JOIN modelo md ON m.modelo_id_modelo = md.id_modelo
LEFT JOIN patio p ON m.id_patio = p.id_patio
LEFT JOIN sensor_iot s ON m.id_sensor_iot = s.id_sensor_iot;

CREATE OR REPLACE VIEW vw_alertas_recentes AS
SELECT a.id_alerta, a.tipo_alerta, a.data_geracao, m.placa
FROM alerta_evento a
JOIN moto m ON a.id_moto = m.id_moto
WHERE a.data_geracao >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY a.data_geracao DESC;
