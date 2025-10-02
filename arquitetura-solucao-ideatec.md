# 🏗️ Arquitetura da Solução IdeaTec - DevOps & Cloud Computing

## 📊 Diagrama de Arquitetura

```mermaid
graph TB
    subgraph "👤 Cliente/Usuário"
        U1[🌐 Browser Web]
        U2[📱 Mobile App]
        U3[🔧 Postman/API Client]
    end
    
    subgraph "☁️ Microsoft Azure Cloud"
        subgraph "🔄 CI/CD Pipeline"
            GH[📦 GitHub Repository<br/>Sprint-3_DevOps]
            DEP[🚀 Azure Deployment<br/>Git Local Push]
        end
        
        subgraph "🌐 Aplicação Web"
            WA[⚡ Azure Web App<br/>Java Spring Boot API<br/>Runtime: Java 17<br/>Plan: B1 Linux]
        end
        
        subgraph "💾 Dados"
            DB[🐘 PostgreSQL Flexible Server<br/>postgres-flex-ideatec<br/>Database: db_ideatec<br/>SSL: Required]
        end
        
        subgraph "📊 Monitoramento"
            AI[📈 Application Insights<br/>appinsights-ideatec<br/>Logs & Metrics]
        end
        
        subgraph "🔒 Segurança"
            FW[🛡️ Firewall Rules<br/>IP Whitelist<br/>SSL/TLS]
        end
        
        subgraph "🏢 Resource Group"
            RG[📁 rg-ideatec<br/>Brazil South]
        end
    end
    
    %% Fluxos principais
    U1 -->|HTTPS Requests| WA
    U2 -->|REST API Calls| WA
    U3 -->|API Testing| WA
    
    GH -->|Git Push| DEP
    DEP -->|Deploy| WA
    
    WA -->|JDBC SSL Connection| DB
    WA -->|Telemetry| AI
    
    FW -->|Protege| DB
    FW -->|Protege| WA
    
    %% Estilos
    classDef azure fill:#0078d4,stroke:#005a9e,stroke-width:2px,color:#fff
    classDef client fill:#28a745,stroke:#1e7e34,stroke-width:2px,color:#fff
    classDef security fill:#dc3545,stroke:#c82333,stroke-width:2px,color:#fff
    classDef data fill:#6f42c1,stroke:#59359a,stroke-width:2px,color:#fff
    
    class WA,AI,DEP,RG azure
    class U1,U2,U3,GH client
    class FW security
    class DB data
```

## 🔄 Fluxo Detalhado de Operações

### 1. 📥 Fluxo de Requisição (Request Flow)
```mermaid
sequenceDiagram
    participant U as 👤 Usuário
    participant W as ⚡ Web App
    participant D as 🐘 PostgreSQL
    participant A as 📈 App Insights
    
    U->>+W: HTTP Request (GET/POST/PUT/DELETE)
    W->>+A: Log Request
    W->>+D: SQL Query (JDBC SSL)
    D-->>-W: Result Set
    W->>+A: Log Response
    W-->>-U: JSON Response
```

### 2. 🚀 Fluxo de Deploy (Deployment Flow)
```mermaid
sequenceDiagram
    participant D as 👨‍💻 Developer
    participant G as 📦 GitHub
    participant A as ☁️ Azure Git
    participant W as ⚡ Web App
    
    D->>+G: Git Push (main branch)
    D->>+A: Git Push (azure remote)
    A->>+W: Auto Deploy
    W->>W: Build & Start Application
    W-->>-D: Deployment Status
```

## 🏗️ Componentes da Arquitetura

### 🎯 **Camada de Apresentação**
- **Browser Web**: Interface principal para usuários finais
- **Mobile Apps**: Aplicações móveis consumindo a API
- **API Clients**: Ferramentas de teste e integração (Postman, Insomnia)

### ⚡ **Camada de Aplicação**
- **Azure Web App**: Hospedagem da aplicação Spring Boot
  - Runtime: Java 17
  - Framework: Spring Boot 3.x
  - Arquitetura: RESTful API
  - SSL/TLS: Habilitado
  - Escalabilidade: Plan B1 (Burstable)

### 💾 **Camada de Dados**
- **PostgreSQL Flexible Server**: Banco de dados principal
  - Versão: PostgreSQL 13
  - Tier: Burstable (Standard_B1ms)
  - Storage: 32GB
  - SSL: Obrigatório
  - Backup: Automático

### 📊 **Camada de Monitoramento**
- **Application Insights**: Telemetria e observabilidade
  - Logs de aplicação
  - Métricas de performance
  - Rastreamento distribuído
  - Alertas personalizados

### 🔒 **Camada de Segurança**
- **Firewall Rules**: Controle de acesso por IP
- **SSL/TLS**: Criptografia em trânsito
- **Environment Variables**: Secrets management
- **RBAC**: Controle de acesso baseado em roles

## 🔧 Tecnologias Utilizadas

| Categoria | Tecnologia | Versão | Propósito |
|-----------|------------|---------|-----------|
| **Backend** | Java | 17 LTS | Linguagem principal |
| **Framework** | Spring Boot | 3.x | Framework web |
| **Database** | PostgreSQL | 13 | Banco de dados |
| **Cloud** | Microsoft Azure | Latest | Plataforma cloud |
| **Monitoring** | Application Insights | Latest | Observabilidade |
| **Build** | Maven | 3.x | Gerenciamento de dependências |
| **VCS** | Git | Latest | Controle de versão |

## 📈 Métricas e KPIs

### 🎯 **Performance**
- Response Time: < 200ms (média)
- Throughput: 1000+ req/min
- Availability: 99.9% uptime
- Error Rate: < 1%

### 🔍 **Monitoramento**
- CPU Usage: < 70%
- Memory Usage: < 80%
- Database Connections: Monitorado
- SSL Certificate: Válido

### 🚀 **DevOps**
- Deploy Time: < 5 minutos
- Rollback Time: < 2 minutos
- Code Coverage: > 80%
- Security Scans: Automático

## 🛠️ Comandos de Gestão

### 📦 **Deploy**
```bash
# Configurar remote Azure
git remote add azure https://user@webapp-ideatec.scm.azurewebsites.net/webapp-ideatec.git

# Deploy para produção
git push azure main
```

### 🔍 **Monitoramento**
```bash
# Verificar logs da aplicação
az webapp log tail --name webapp-ideatec --resource-group rg-ideatec

# Status dos recursos
az resource list --resource-group rg-ideatec --output table
```

### 💾 **Banco de Dados**
```bash
# Conectar ao banco
psql "host=postgres-flex-ideatec.postgres.database.azure.com port=5432 dbname=db_ideatec user=admin_ideatec sslmode=require"

# Backup
pg_dump -h postgres-flex-ideatec.postgres.database.azure.com -U admin_ideatec -d db_ideatec > backup.sql
```

## 🎯 Benefícios da Arquitetura

### ☁️ **Cloud-Native**
- ✅ Escalabilidade automática
- ✅ Alta disponibilidade
- ✅ Disaster recovery
- ✅ Pay-as-you-use

### 🔄 **DevOps**
- ✅ CI/CD automatizado
- ✅ Infrastructure as Code
- ✅ Monitoring contínuo
- ✅ Deploy rápido e seguro

### 🔒 **Segurança**
- ✅ SSL/TLS end-to-end
- ✅ Firewall configurado
- ✅ Secrets management
- ✅ Compliance Azure

### 📊 **Observabilidade**
- ✅ Logs centralizados
- ✅ Métricas em tempo real
- ✅ Alertas proativos
- ✅ Performance insights

---

> 🎓 **Projeto desenvolvido para:** FIAP - Faculdade de Informática e Administração Paulista  
> 📚 **Disciplina:** DevOps Tools e Cloud Computing  
> 👨‍💻 **Desenvolvido por:** Pedro Ladeira  
> 📅 **Data:** Outubro 2025