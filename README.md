# COVID-19 Data Exploration (SQL + Tableau)

A mini data analysis project exploring global COVID-19 case, death, and vaccination data from **January 2020 to January 2021**. I used **SQL Server** to query the data for insights and **Tableau** to visualize the results in a dashboard.

## Project Goals

- Practice writing SQL queries to answer real questions from a large dataset (200K+ rows)
- Turn query results into clear, shareable visualizations
- Show how SQL and Tableau work together in a simple analytics workflow

## Tools Used

| Tool | Purpose |
|------|---------|
| SQL Server (2025 Developer Edition) | Querying and exploring the data |
| SQL Server Management Studio (SSMS) | Writing and running queries, importing data from Excel |
| Tableau | Building the dashboard |

## Repository Contents

| File | Description |
|------|-------------|
| `SQLQueryCovid.sql` | All SQL queries used for exploration, plus the views created for Tableau |
| `CovidDashboard.twbx` | Tableau packaged workbook containing the dashboard |

## Dataset

Two Excel tables were imported into SQL Server:

- **CovidDeaths**: cases, deaths, and population by country and date
- **CovidVaccinations**: vaccination data by country and date

Source: [Our World in Data](https://ourworldindata.org/covid-deaths) (COVID-19 dataset)

**Data preparation:** The data was used largely as-is. This project focused on querying and visualization rather than extensive cleaning. The main handling was filtering out aggregate rows (such as continent and income-group totals) with `WHERE continent IS NOT NULL`, and casting text columns to numeric types where needed.

## Questions Explored

The queries in `SQLQueryCovid.sql` answer the following:

1. **Total cases vs. total deaths (USA):** the percentage of confirmed cases that resulted in death over time
2. **Total cases vs. population (USA):** what percentage of the population was infected over time
3. **Infection rate by country:** which countries had the highest infection rate relative to population
4. **Death count by country:** which countries had the highest total death counts
5. **Death count by location group:** deaths broken out for the aggregate rows (continents, income groups)
6. **Death count by continent:** which continents had the highest death counts
7. **Global totals:** overall cases, deaths, and death percentage worldwide
8. **Global numbers by date:** how worldwide cases and deaths changed over time
9. **Population vs. vaccinations:** a rolling count of vaccinations per country, and the percentage of population vaccinated

## SQL Skills Demonstrated

- Filtering and sorting (`WHERE`, `ORDER BY`)
- Aggregate functions (`SUM`, `MAX`) with `GROUP BY`
- Joining tables (`JOIN` on location and date)
- Window functions (`SUM() OVER (PARTITION BY ... ORDER BY ...)`) for rolling totals
- CTEs (`WITH`) to build on intermediate results
- Data type conversion (`CAST`, `CONVERT`)
- Views (`CREATE VIEW`) to store query results for use in Tableau

## Dashboard

The Tableau dashboard is built from SQL views created in `SQLQueryCovid.sql`:

- `GlobalNumbers`
- `ContinentDeathCount`
- `TotalCasesvsPop`
- `CountriesInfectionRatetoPop`
- `CountriesDeathRateperPop`
- `PopvsVac`

![Dashboard Preview](images/dashboard.png)

*Add a screenshot of your dashboard at `images/dashboard.png`, and a link to the live version on Tableau Public if you publish it.*

## Key Findings

*Fill these in with your own results. A few prompts to get you started:*

- Which country had the highest infection rate relative to its population?
- Which continent had the highest death count?
- What was the global death percentage over the period?
- What did the death percentage in the USA look like over time?

Example format:
- **[Finding]:** [One sentence with the number and what it means]

## How to Run

1. Install SQL Server and SSMS, and create a database named `PortfolioProject`.
2. Import the CovidDeaths and CovidVaccinations data as tables in that database.
3. Open `SQLQueryCovid.sql` in SSMS and run the queries section by section.
4. Open `CovidDashboard.twbx` in Tableau to view the dashboard.

## Limitations

- The data covers only January 2020 to January 2021, so it doesn't reflect later waves or the full vaccine rollout.
- Death percentage is calculated as deaths divided by confirmed cases, so it depends on how much testing each country did and is not a true fatality rate.
- Minimal data cleaning was done, so reporting gaps and inconsistencies in the source data may affect results.

## Author

**nhouxiong**
