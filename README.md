# SQL Data Warehouse Project

This project demonstrates the design and implementation of a **data warehouse** using **MySQL**. It follows industry best practices in **data engineering** and the **Medallion Architecture**.

---

## 🏗️ Data Architecture

The data warehouse is structured in three layers:

1. **Bronze Layer** – Stores raw data ingested from CSV files.  
2. **Silver Layer** – Cleans and transforms the data into standardized formats.  
3. **Gold Layer** – Contains business-ready data modeled into a **Star Schema**.  

---

## 📖 Project Overview

- Designed and implemented a **data warehouse in MySQL**.  
- Built **ETL pipelines** using SQL scripts to process data through Bronze → Silver → Gold layers.  
- Modeled **fact and dimension tables** to support analytical queries.  

---

## 🛠️ Tools & Technologies

- **MySQL** – Database for warehouse implementation  
- **CSV Files** – Data sources (ERP & CRM datasets)  
- **Git/GitHub** – Version control and project management  

---

## 📂 Repository Structure
```
sql-data-warehouse-project/
│
├── datasets/ # Raw ERP and CRM datasets (CSV)
├── docs/ # Project documentation file
├── scripts/ # SQL scripts for ETL and transformations
│ ├── bronze/ # Load raw data
│ ├── silver/ # Clean & transform
│ ├── gold/ # Create star schema tables
├── tests/ # Test scripts for validation
└── README.md # Project overview
```

---

## 🎯 Key Learning Outcomes

- Built a **modern data warehouse** in MySQL.  
- Applied the **Medallion Architecture** for structured data processing.  
- Designed and implemented a **Star Schema**.  
- Gained hands-on experience in **ETL pipelines** and **data modeling**. 
