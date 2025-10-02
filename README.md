# 🚀 Projeto IdeaTec – Sprint 3 DevOps

Este projeto atende ao desafio da matéria Java DevOps FIAP, consistindo em backend Java Spring Boot com banco de dados PostgreSQL hospedado no Azure, totalmente integrado às melhores práticas de cloud e DevOps.

## 📁 Repositório oficial

Clonar o código-fonte diretamente via:

```
git clone https://github.com/Pedro-Ladeira/Sprint-3_DevOps.git
```

## 💻 1. Pré-requisitos

- Java 17 instalado (JDK)
- Maven instalado (`mvn -v`)
- Git instalado
- PostgreSQL Client (opcional, para debug manual)
- Conta ativa na Azure (para deploy e uso dos resources cloud)

## 🐘 2. Banco de Dados Azure PostgreSQL

O projeto acessa o banco do Azure:

- Servidor: **postgres-flex-ideatec.postgres.database.azure.com**
- Banco: **db_ideatec**
- Usuário: **admin_ideatec**
- Senha: **Ideatec558514**

> As tabelas já foram criadas e populadas via script SQL (veja [database.sql](database.sql) neste projeto, se quiser rodar manualmente).

## ⚙️ 3. Como Rodar Localmente

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

## 🌐 4. Como Deployar na Azure Web App

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

## 💡 5. Testando o CRUD (WEB/API)

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

## 📑 6. Estrutura do Projeto

```
Sprint-3_DevOps
  ├── src/main/java/...    # Código fonte Java (models, controllers, services, repos)
  ├── src/main/resources/application.properties
  ├── pom.xml              # Dependências Maven
  ├── scripts/             # Scripts Bash para automação Azure
  ├── database.sql         # Script SQL criação e população
```

## 🛠️ 7. Solução de Problemas

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

## 🤝 Colaboradores

- Pedro Ladeira – [github.com/Pedro-Ladeira](https://github.com/Pedro-Ladeira)
- Equipe DevOps 2025 FIAP

## 📚 Referências

- [Documentação Azure PostgreSQL Flexible Server](https://learn.microsoft.com/pt-br/azure/postgresql/flexible-server/)
- [Documentação Spring Boot + PostgreSQL](https://spring.io/projects/spring-boot)
- [API REST FIAP Padrão](https://portal.fiap.com.br/)

> _Dúvidas, críticas ou sugestões? Crie uma issue pelo GitHub ou envie seu feedback no Classroom._