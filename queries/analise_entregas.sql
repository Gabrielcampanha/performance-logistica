-- =====================================================
-- PROJETO: ANÁLISE DE PERFORMANCE LOGÍSTICA
-- Fonte: BigQuery
-- Período: Abril 2024
-- =====================================================


-- =====================================================
-- BASE DE DADOS (JOIN DAS TABELAS)
-- =====================================================

WITH base AS (
  SELECT
    p.pedido_id,
    p.data_criacao,
    p.data_entrega_real,
    p.data_prometida_entrega,
    p.regiao_destino,
    t.nome AS transportadora,

    -- SLA
    p.no_prazo,

    -- Meta SLA por transportadora
    CASE 
      WHEN t.nome = 'Mercado Envios Full' THEN 0.94
      WHEN t.nome = 'Internacional' THEN 0.78
      WHEN t.nome = 'Mercado Envios' THEN 0.86
      WHEN t.nome = 'Mercado Envios Flex' THEN 0.86
    END AS meta_sla,

    -- Lead time (tempo total)
    DATE_DIFF(p.data_entrega_real, p.data_criacao, DAY) AS lead_time,

    -- Dias de atraso
    DATE_DIFF(p.data_entrega_real, p.data_prometida_entrega, DAY) AS dias_atraso

  FROM `projetomercadoenvios.logistica.pedidos` p
  LEFT JOIN `projetomercadoenvios.logistica.transportadoras` t
    ON p.transportadora_id = t.id
)


-- =====================================================
-- KPI GERAL
-- =====================================================

SELECT
  COUNT(pedido_id) AS total_pedidos,
  ROUND(AVG(no_prazo) * 100, 2) AS percentual_no_prazo,
  ROUND(AVG(lead_time), 2) AS tempo_medio_entrega
FROM base;


-- =====================================================
-- SLA POR TRANSPORTADORA
-- =====================================================

SELECT
  transportadora,
  COUNT(*) AS total_pedidos,
  ROUND(AVG(no_prazo) * 100, 2) AS sla_percentual,
  ROUND(AVG(meta_sla) * 100, 2) AS meta_sla,
  ROUND(AVG(lead_time), 2) AS tempo_medio_entrega
FROM base
GROUP BY transportadora
ORDER BY sla_percentual DESC;


-- =====================================================
-- SLA POR REGIÃO
-- =====================================================

SELECT
  regiao_destino,
  COUNT(*) AS total_pedidos,
  ROUND(AVG(no_prazo) * 100, 2) AS sla_percentual,
  ROUND(AVG(lead_time), 2) AS tempo_medio_entrega
FROM base
GROUP BY regiao_destino
ORDER BY sla_percentual DESC;


-- =====================================================
-- EVOLUÇÃO DO SLA NO TEMPO
-- =====================================================

SELECT
  DATE(data_criacao) AS data,
  ROUND(AVG(no_prazo) * 100, 2) AS sla_percentual,
  ROUND(AVG(meta_sla) * 100, 2) AS meta_sla
FROM base
GROUP BY data
ORDER BY data;


-- =====================================================
-- DISTRIBUIÇÃO DE ATRASO
-- =====================================================

SELECT
  dias_atraso,
  COUNT(*) AS quantidade
FROM base
GROUP BY dias_atraso
ORDER BY dias_atraso;


-- =====================================================
-- CLASSIFICAÇÃO DE ATRASO
-- =====================================================

SELECT
  CASE 
    WHEN dias_atraso <= 0 THEN 'No prazo'
    WHEN dias_atraso <= 2 THEN 'Atraso leve'
    WHEN dias_atraso <= 5 THEN 'Atraso moderado'
    ELSE 'Atraso crítico'
  END AS categoria_atraso,
  COUNT(*) AS total_pedidos
FROM base
GROUP BY categoria_atraso
ORDER BY total_pedidos DESC;


-- =====================================================
-- TOP PIORES ENTREGAS (MAIOR ATRASO)
-- =====================================================

SELECT
  pedido_id,
  transportadora,
  regiao_destino,
  dias_atraso,
  lead_time
FROM base
ORDER BY dias_atraso DESC
LIMIT 20;


-- =====================================================
-- HEATMAP (TRANSPORTADORA x REGIÃO)
-- =====================================================

SELECT
  transportadora,
  regiao_destino,
  ROUND(AVG(no_prazo) * 100, 2) AS sla_percentual
FROM base
GROUP BY transportadora, regiao_destino
ORDER BY transportadora, sla_percentual DESC;