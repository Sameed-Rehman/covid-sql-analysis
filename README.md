# 🦠 COVID-19 Data Exploration (SQL Project)

## 📌 Project Overview

This project focuses on exploring global COVID-19 data using SQL to uncover meaningful insights about infection rates, death ratios, and vaccination progress across countries and continents.

The goal is to demonstrate strong SQL skills including:

* Data aggregation
* Joins
* Common Table Expressions (CTEs)
* Window functions
* Analytical thinking

---

## 📊 Dataset Description

The project uses two primary datasets:

* **CovidDeaths**

  * Location, date, population
  * Total cases, new cases
  * Total deaths, new deaths

* **CovidVaccinations**

  * Location, date
  * New vaccinations
  * Total people vaccinated

---

## 🔍 Key Analysis Performed

### 1. Infection Rate Analysis

* Calculated percentage of population infected
* Compared infection spread across countries

### 2. Death Rate Analysis

* Evaluated death percentage relative to population
* Identified countries with highest fatality impact

### 3. Country-Level Insights

* Total cases and deaths per country
* Most affected and highest death ratio countries

### 4. Continent-Level Analysis

* Aggregated deaths by continent
* Compared regional impact

### 5. Global Metrics

* Total global cases and deaths
* Overall death percentage

### 6. Vaccination Analysis

* Percentage of population vaccinated per country
* Compared vaccination progress globally

### 7. Rolling Vaccination Trends

* Used window functions to track cumulative vaccinations over time
* Measured vaccination growth per country

---

## 🛠️ SQL Concepts Used

* **Joins** (Inner Join)
* **Aggregate Functions** (`SUM`, `MAX`, `MIN`)
* **Common Table Expressions (CTEs)**
* **Window Functions** (`SUM() OVER PARTITION BY`)
* **Data Type Casting**
* **Views for Reusability**

---

## 📈 Sample Insight

* Some countries show high infection rates but relatively lower death percentages
* Vaccination rollout varies significantly between regions
* Continental aggregation highlights uneven global impact

---

## 📁 Project Structure

```
📦 covid-sql-analysis
 ┣ 📜 covid_analysis.sql
 ┗ 📜 README.md
```

---

## 🚀 How to Use

1. Import datasets into your SQL environment (SQL Server recommended)
2. Run the queries step-by-step
3. Modify filters to explore specific countries or regions

---

## 💡 Future Improvements

* Integrate with Power BI or Tableau for visualization
* Add time-series trend analysis
* Optimize queries with indexing
* Build dashboard for real-time insights

---

## 👤 Author

**Iman Tanveer**
Aspiring Data Analyst | SQL Enthusiast

---

## ⭐ Final Note

This project highlights practical SQL skills applied to real-world data, focusing on extracting insights rather than just querying data.
