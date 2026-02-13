# Projet Cloud Azure – Architecture Hub-Spoke avec Terraform

## Description

Ce projet illustre la conception et le déploiement automatisé d’une infrastructure cloud sur Microsoft Azure à l’aide de Terraform.
Il met en œuvre une architecture Hub-Spoke, des services PaaS (App Service, Azure SQL), un backend distant, une gestion sécurisée des secrets via Key Vault et une supervision centralisée avec Log Analytics, conformément aux bonnes pratiques DevOps.


---

## Architecture
```bash
Hub VNet  ←→  Spoke VNet
  │
  ├── App Service (Linux)
  ├── Azure SQL
  ├── Key Vault (RBAC)
  └── Log Analytics
``` 

---

## Structure du projet
NOM du Dossier: project-2-hub-spoke
```bash
project-2-hub-spoke/
├── backend.tf         #stokage du state dans Azure
├── main.tf            #lien entre les deux Modules
├── variables.tf
├── outputs.tf         #Resultats
├── versions.tf
├── README.md
├── .gitignore
├── .terraform.lock.hcl
├── env/
│   ├── dev.tfvars.example      # environnement dev
│   └── prod.tfvars.example
└── modules/
   ├── network/
   │   ├── main.tf
   │   ├── variables.tf
   │   └── outputs.tf
   ├── app/
   │   ├── main.tf
   │   ├── variables.tf
   │   └── outputs.tf
   ├── security/
   │   ├── main.tf
   │   ├── variables.tf
   │   └── outputs.tf
   └── monitoring/
       ├── main.tf
       ├── variables.tf
       └── outputs.tf
```

---


## Technologies utilisées

- Terraform (≥ 1.6)
- Azure CLI
- Azure App Service (Linux)
- Azure SQL Database
- Azure Key Vault (RBAC)
- Azure Log Analytics

---


## Backend distant (State Terraform)

Le fichier d’état Terraform est stocké dans Azure Storage via le backend azurerm.
Cela permet un travail collaboratif sécurisé et un verrouillage automatique du state.

---

## Déploiement

### Connexion à Azure

```bash
az login
```

### Initialisation

```bash
   terraform init
```
### validation
```bash  
terraform validate
```
### Planification

```bash 
terraform plan -var-file="env/dev.tfvars"
 ```

### Déploiement

```bash 
terraform apply -var-file="env/dev.tfvars" 
```
### Affichage des résultats

```bash
terraform output
```
## Tests
### Accès à l’application web :

```bash
   https://app-hubspoke-dev-9b98d5.azurewebsites.net
```
---

## Résultat final
 ### Outputs obtenus après déploiement

-  Application Web (App Service)
  
```bashapp-hubspoke-dev-9b98d5.azurewebsites.net```

- Base de données Azure SQL 

```sql-hubspoke-dev-9b98d5.database.windows.net```

- Azure Key Vault**

```kv-hubspoke-dev-9b98d5 ``` 

### 

## **Dépannage (Troubleshooting)**


| Problème             | Solution                                      |
| -------------------- | --------------------------------------------- |
| Erreur 403 Key Vault | Attribuer le rôle "Key Vault Secrets Officer" |
| Problème de quota VM | Utiliser des services PaaS                    |
| Blocs dupliqués      | Nettoyer les fichiers Terraform               |
| Metrics obsolètes    | Utiliser enabled\_metric                      |
| Outputs vides        | Compléter outputs.tf                          |


## Compétences démontrées

* Infrastructure as Code (Terraform)
* Architecture réseau Hub-Spoke
* Déploiement PaaS
* Sécurité RBAC
* Gestion du state distant
* Supervision et logs
* Dépannage technique

---

## Captures d’écran
 ### Terraform Apply

[Terraform Apply](screenshots/terraform-apply.png)

### Resource Groups Azure

[Resource Groups](screenshots/resource-groups.png)





---

### App Service

[App Service](screenshots/app-service.png)

### Azure Key Vault

[Key Vault](screenshots/keyvault.png)

### Log Analytics

[Log Analytics](screenshots/log-analytics.png)
