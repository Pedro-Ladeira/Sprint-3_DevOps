-- V004__create_functions_procedures.sql (PostgreSQL)

-- Função de distância (PostgreSQL)
CREATE OR REPLACE FUNCTION calcular_distancia(
    x1 NUMERIC, y1 NUMERIC, x2 NUMERIC, y2 NUMERIC
) RETURNS NUMERIC AS $$
BEGIN
    RETURN ROUND(SQRT(POWER(x2 - x1, 2) + POWER(y2 - y1, 2)), 2);
END;
$$ LANGUAGE plpgsql;

-- Procedimento de limpeza de dados antigos (PostgreSQL)
CREATE OR REPLACE PROCEDURE limpar_dados_antigos()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM historico_posicao
    WHERE data_atualizacao < CURRENT_DATE - INTERVAL '90 days';

    DELETE FROM alerta_evento
    WHERE data_geracao < CURRENT_DATE - INTERVAL '30 days';
END;
$$;

-- Agendamento automático de limpeza (usando pg_cron ou manual)
-- Exemplo de chamada manual:
-- CALL limpar_dados_antigos();

-- Para agendamento automático, utilize a extensão pg_cron no PostgreSQL (não incluso por padrão no Azure Flexible Server)
-- Exemplo (se pg_cron estiver disponível):
-- SELECT cron.schedule('0 2 * * 0', $$CALL limpar_dados_antigos();$$);
