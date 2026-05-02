# Dashboard de Performance Logística

Este projeto apresenta uma análise de desempenho logístico baseada em dados simulados de entregas, com foco em métricas críticas utilizadas por grandes empresas de e-commerce.

---

## Objetivo

O objetivo deste projeto é analisar a eficiência da operação logística através de indicadores como:

* Total de pedidos
* Percentual de entregas no prazo
* Tempo médio de entrega
* Performance por transportadora
* Performance por região

---

## Dashboard

![Dashboard](images/dashboard.png)

**Acesse o dashboard interativo:**
https://datastudio.google.com/s/spDj3qV7Pvo

---

## Principais Insights

* Transportadoras apresentam variações relevantes no cumprimento de SLA
* A operação internacional possui o pior desempenho em entregas no prazo
* Algumas regiões apresentam maior incidência de atrasos
* A maior parte dos atrasos é leve, mas existem casos críticos que impactam a operação
* O volume de pedidos pode influenciar diretamente o desempenho logístico

---

## Tecnologias utilizadas

* Google BigQuery
* Looker Studio
* SQL

---

## Modelagem dos Dados

Os dados foram estruturados a partir das seguintes tabelas:

* `pedidos` → informações dos pedidos e datas de entrega
* `transportadoras` → dados das transportadoras
* `vw_performance_entregas` → visão consolidada para análise

---

## Métricas e Cálculos

As principais métricas utilizadas foram:

* **SLA (% no prazo)**
* **Lead Time** → diferença entre data de entrega e data de criação
* **Dias de atraso** → diferença entre entrega real e prometida
* **Meta SLA por transportadora**

---

## Abordagem

As análises foram realizadas utilizando SQL no BigQuery para transformação e cálculo das métricas, e posteriormente visualizadas no Looker Studio para construção do dashboard interativo.

---

## Contexto de Negócio

Este projeto simula um cenário real de e-commerce, onde o cumprimento do SLA de entrega é um dos principais indicadores de:

* Satisfação do cliente
* Eficiência operacional
* Qualidade das transportadoras

---

## Aprendizados

* Construção de dashboards analíticos
* Modelagem de métricas logísticas
* Uso de SQL para análise de dados
* Visualização de dados orientada à tomada de decisão

---

## Autor

Projeto desenvolvido por Gabriel Campanha como parte do portfólio para área de dados / engenharia de software.
