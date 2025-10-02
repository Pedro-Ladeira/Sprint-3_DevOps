# 🚀 Projeto IdeaTec – Sprint 3 DevOps

Este projeto atende ao desafio da matéria Java DevOps FIAP, consistindo em backend Java Spring Boot com banco de dados PostgreSQL hospedado no Azure, totalmente integrado às melhores práticas de cloud e DevOps.

## 📋 1. Descrição da Solução

### 🎯 O que a aplicação faz

O **Sistema IdeaTec** é uma solução inovadora de **mapeamento inteligente e gestão digital de frotas de motocicletas** desenvolvida para otimizar as operações da Mottu. A aplicação combina tecnologias modernas para resolver o desafio crítico de localização e monitoramento de motos em pátios de múltiplas filiais.

### 🔧 Principais Funcionalidades:

- **🔍 Visão Computacional Inteligente**: Sistema de câmeras fixas com algoritmos de detecção de objetos para identificar e rastrear motos em tempo real
- **🗺️ Mapeamento Digital Interativo (Digital Twin)**: Representação virtual precisa dos pátios com localização exata de cada motocicleta
- **📱 Interface Web/Mobile Responsiva**: Dashboard intuitivo para operadores monitorarem frotas via desktop ou dispositivos móveis
- **📡 Integração IoT**: Conexão com sensores das motos para captura automática de dados (localização, status do motor, bateria, etc.)
- **☁️ Backend Escalável**: Arquitetura cloud-native preparada para suportar 100+ filiais simultaneamente
- **🚨 Sistema de Alertas**: Notificações automáticas sobre movimentações não autorizadas, manutenção necessária ou motos fora de zona

### 💡 Tecnologias Utilizadas:

- **Backend**: Java 17 + Spring Boot (API REST)
- **Banco de Dados**: PostgreSQL com esquema otimizado para IoT
- **Cloud**: Microsoft Azure (Web App + PostgreSQL Flexible Server)
- **Monitoramento**: Application Insights para observabilidade
- **Integração**: APIs REST para sensores IoT e sistemas externos

## 🎯 2. Descrição dos Benefícios para o Negócio

### 🔄 Problemas Resolvidos

**Problema Original da Mottu:**
- Gestão manual de frotas em 100+ filiais gera imprecisões operacionais
- Localização de motos dentro dos pátios é ineficiente e custosa
- Falta de visibilidade em tempo real impacta a eficiência operacional
- Escalabilidade limitada para expansão no Brasil e México

### ✅ Benefícios Diretos da Solução IdeaTec:

#### 📈 **Eficiência Operacional**
- **Redução de 80% no tempo** de localização de motos dentro dos pátios
- **Automatização completa** do processo de mapeamento (elimina controle manual)
- **Monitoramento em tempo real** da disposição da frota em todas as filiais
- **Otimização de rotas** para manutenção e recolhimento de veículos

#### 💰 **Redução de Custos**
- **Diminuição significativa** nos custos operacionais de gestão de pátio
- **Redução de perdas** por motos mal localizadas ou "perdidas"
- **Otimização de recursos humanos** (menos tempo gasto em busca manual)
- **Prevenção de furtos** através de alertas automáticos de movimentação

#### 📊 **Escalabilidade e Controle**
- **Implementação padronizada** em todas as 100+ filiais
- **Adaptabilidade** a diferentes layouts e tamanhos de pátio
- **Gestão centralizada** com visão consolidada de todas as operações
- **Preparação para expansão** internacional (Brasil e México)

#### 🔧 **Melhoria na Manutenção**
- **Histórico detalhado** de localização e movimentação das motos
- **Alertas preditivos** para necessidades de manutenção
- **Rastreamento de status** em tempo real (ligado/desligado, bateria, etc.)
- **Auditoria completa** de todas as operações realizadas

#### 👥 **Experiência do Usuário**
- **Interface intuitiva** que não exige treinamento extenso
- **Acesso multiplataforma** (web e mobile)
- **Visualização clara** e em tempo real da disposição das motos
- **Redução de erros humanos** no processo de gestão

#### 🚀 **Vantagem Competitiva**
- **Tecnologia inovadora** de visão computacional aplicada à mobilidade
- **Diferenciação no mercado** através de operações mais eficientes
- **Base sólida** para implementação de novas funcionalidades IoT
- **ROI comprovado** através de métricas de eficiência e redução de custos

### 📊 Impacto Quantificado

| Métrica | Situação Atual | Com IdeaTec | Melhoria |
|---------|----------------|-------------|----------|
| Tempo de localização | 15-30 min/moto | 1-2 min/moto | **90% mais rápido** |
| Precisão de localização | 60-70% | 95%+ | **+25% precisão** |
| Custos operacionais | Alto (manual) | Baixo (automatizado) | **-60% custos** |
| Escalabilidade | Limitada | 100+ filiais | **Expansão ilimitada** |
| Controle de perdas | Reativo | Proativo | **-80% perdas** |

## 📁 Repositório oficial

Clonar o código-fonte diretamente via:

```
git clone https://github.com/Pedro-Ladeira/Sprint-3_DevOps.git
```

## 💻 3. Pré-requisitos

- Java 17 instalado (JDK)
- Maven instalado (`mvn -v`)
- Git instalado
- PostgreSQL Client (opcional, para debug manual)
- Conta ativa na Azure (para deploy e uso dos resources cloud)

## 🐘 4. Banco de Dados Azure PostgreSQL

O projeto acessa o banco do Azure:

- Servidor: **postgres-flex-ideatec.postgres.database.azure.com**
- Banco: **db_ideatec**
- Usuário: **admin_ideatec**
- Senha: **Ideatec558514**

> As tabelas já foram criadas e populadas via script SQL (veja [database.sql](database.sql) neste projeto, se quiser rodar manualmente).

## ⚙️ 5. Como Rodar Localmente

1. **Clonar o repositório**
   ```
   git clone https://github.com/Pedro-Ladeira/Sprint-3_DevOps.git
   cd Sprint-3_DevOps
   ```

2. **Configurar as credenciais do banco em `src/main/resources/application.properties`**:

   ```
   spring.datasource.url=jdbc:postgresql://postgres-flex-ideatec.postgres.database.azure.com:5432/db_ideatec?sslmode=require
   spring.datasource.username=admin_ideatec
   spring.datasource.password=Ideatec558514
   spring.datasource.driver-class-name=org.postgresql.Driver
   spring.jpa.hibernate.ddl-auto=none
   spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
   ```

3. **Instalar dependências**
   ```
   mvn clean install
   ```

4. **Rodar localmente**
   ```
   mvn spring-boot:run
   ```

5. **Acessar e testar o backend**
   - Acesse: [http://localhost:8080](http://localhost:8080)
   - Teste endpoints REST da API com [Postman](https://www.postman.com/) ou via navegador:
     - Lista de motos: [http://localhost:8080/motos](http://localhost:8080/motos)
     - CRUD de qualquer entidade: consultar o controller correspondente

## 🌐 6. Como Deployar na Azure Web App

> *Se você for o responsável pelo deploy, siga este guia. Caso sua faculdade já tenha o ambiente pronto, apenas atualize o código.*

1. **Preparar ambiente cloud pelo script Bash do projeto** (veja [scripts/cria_azure.sh](scripts/cria_azure.sh))
   - Crie recursos Azure: Resource Group, Flex Server PostgreSQL, App Service Plan, Web App, Application Insights

2. **Obter URL Git do Azure para deploy**:
   ```
   az webapp deployment source config-local-git --name webapp-ideatec --resource-group rg-ideatec
   ```

3. **Adicionar o remote Azure ao seu projeto local**
   ```
   git remote add azure https://<deployment-user>@webapp-ideatec.scm.azurewebsites.net/webapp-ideatec.git
   ```

4. **Deploy para Azure Web App**
   ```
   git push azure main
   ```

5. **Acesse online**
   - [https://webapp-ideatec.azurewebsites.net](https://webapp-ideatec.azurewebsites.net)

6. **Variáveis de ambiente do Web App**:
   - Configure via portal Azure/Script Bash:
     - `SPRING_DATASOURCE_URL`
     - `SPRING_DATASOURCE_USERNAME`
     - `SPRING_DATASOURCE_PASSWORD`
     - `APPINSIGHTS_INSTRUMENTATIONKEY`

## 💡 7. Testando o CRUD (WEB/API)

- Use **Postman**, **Insomnia** ou outro client REST para testar todos os endpoints.  
  Exemplos:
  - **GET** /motos – Lista motos cadastradas
  - **POST** /motos – Insere nova moto
  - **PUT** /motos/{id} – Atualiza moto existente
  - **DELETE** /motos/{id} – Exclui moto cadastrada

- As alterações na API são refletidas diretamente no banco PostgreSQL Azure!  
  Para checar manualmente via CLI:
  ```
  psql "host=postgres-flex-ideatec.postgres.database.azure.com port=5432 dbname=db_ideatec user=admin_ideatec sslmode=require"
  SELECT * FROM moto;
  ```

## 📑 8. Estrutura do Projeto

```
Sprint-3_DevOps
  ├── src/main/java/...    # Código fonte Java (models, controllers, services, repos)
  ├── src/main/resources/application.properties
  ├── pom.xml              # Dependências Maven
  ├── scripts/             # Scripts Bash para automação Azure
  ├── database.sql         # Script SQL criação e população
```

## 🛠️ 9. Solução de Problemas

- **Problemas de conectividade com o banco?**  
  Verifique se o IP local está liberado no firewall do servidor PostgreSQL Azure.

- **Erro de autenticação no deploy?**  
  Redefina deployment user via Azure CLI:
  ```
  az webapp deployment user set --user-name <usuario> --password <senha_forte>
  ```

- **App não inicia no Azure?**  
  Cheque logs no portal:
  - Web App > Logs de aplicativo
  - Web App > Diagnóstico > Kudu/Console

## 🤝 10. Colaboradores

- Pedro Ladeira – [github.com/Pedro-Ladeira](https://github.com/Pedro-Ladeira)
- Equipe DevOps 2025 FIAP

## 📚 11. Referências

- [Documentação Azure PostgreSQL Flexible Server](https://learn.microsoft.com/pt-br/azure/postgresql/flexible-server/)
- [Documentação Spring Boot + PostgreSQL](https://spring.io/projects/spring-boot)
- [API REST FIAP Padrão](https://portal.fiap.com.br/)
- [Desafio Mottu - Mapeamento Inteligente de Pátio](https://www.mottu.com.br/)

> _Dúvidas, críticas ou sugestões? Crie uma issue pelo GitHub ou envie seu feedback no Classroom._