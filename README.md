# Gaming Project Analysis 🎮

## Overview 📊

This project presents a comprehensive analysis of a synthetic gaming dataset, focusing on player demographics, behavior, monetization, engagement, and retention. The goal is to extract actionable insights that can inform game development, marketing strategies, and overall player experience improvements. The analysis is performed using SQL for data querying and transformation, and visualized through interactive dashboards by using PowerBI.

## Project Structure 📁
* **`DataSets/`**: Stores the raw CSV data files used in the project.
    * `Gaming_Sessions_Log2.csv`: Logs individual gaming sessions and purchase details.
    * `Synthetic_Gaming_Dataset.csv`: Contains player demographic and in-game activity data.
* **`Scripts/`**: Contains all SQL scripts used for database setup and data analysis.
    * `CreatingTables_GamingProjcet.sql`: SQL script for creating the database tables (`gaming` and `GamingSessionsLog`) and loading data from CSV files.
    * `Analysis_GamingProject.sql`: SQL script containing various queries for exploratory data analysis, demographic analysis, player behavior, in-game purchase analysis, engagement analysis, game difficulty insights, purchase rate per genre, session and activity status, session duration trends, valuable customers, and retention analysis.
* **`Dashboards/`**: Houses the visual dashboard images generated from the analysis.
    * `ExecutiveDashboard.jpg`: Provides a high-level overview of key metrics.
    * `Monetization&PurchaseDashboard.jpg`: Focuses on revenue and purchase-related metrics.
    * `Retention&Engagement.jpg`: Highlights player retention and engagement metrics.
    * `UserExperienceDashboard.jpg`: Provides insights into player experience and progression.

## Data Sources 💾

The analysis utilizes two primary datasets, located in the `DataSets/` directory:

1.  `Synthetic_Gaming_Dataset.csv`: Contains player demographic and in-game activity data.
    * **Features**: `PlayerID`, `Age`, `Gender`, `Location`, `GameGenre`, `PlayTimeHours`, `InGamePurchases`, `GameDifficulty`, `SessionsPerWeek`, `AvgSessionDurationMinutes`, `PlayerLevel`, `AchievementsUnlocked`, `EngagementLevel`.

2.  `Gaming_Sessions_Log2.csv`: Logs individual gaming sessions and purchase details.
    * **Features**: `PlayerID`, `SessionNumber`, `SessionDate`, `SessionDuration`, `MadePurchase`, `PurchaseAmount`.

## SQL Analysis (`Scripts/Analysis_GamingProject.sql`) 💻

The `Analysis_GamingProject.sql` script performs a wide range of analyses, including but not limited to:

### Exploratory Data Analysis (EDA) 🔍
* General overview of the `gaming` table.
* Number of players per location.
* Available game difficulties.
* Age range of players.
* Player distribution by age groups.
* Average age by location.
* Unique game genres.
* Average session duration per genre.
* Average age per game genre.
* Engagement level distribution.

### Demographic Analysis 👥
* Age group distribution by location.
* Gender distribution by location.
* Average age by gender and location.

### Player Behavior Analysis 🕹️
* Average playtime per genre.
* Average sessions per week by game difficulty.

### In-Game Purchase Behavior 💰
* Total in-game purchases by age group.
* In-game purchase comparison by player level.
* Total players by gender per genre.

### Engagement Analysis ❤️‍🔥
* Engagement distribution by gender and genre.
* Average metrics (PlayTime, Level, Achievements, Sessions) by engagement level.

### Game Difficulty Insights 🏆
* Player distribution by game difficulty and age group.
* Identification of the best performing player per game difficulty based on a calculated `PerformanceScore`.

### Purchase Rate per Genre 💲
* Calculation of total purchases, total players, and purchase rate for each game genre.

### Sessions and Activity Status 🕰️
* Identification of active players (played in the last 3 months) and non-active players (last session over 3 months ago).
* Counting players by activity status.
* Identifying "non-returners" (players with only one session, over a month ago).

### Session Duration Trend 📈
* Analysis of monthly playtime trends for each player, showing increases, decreases, or even play time compared to the previous month.

### Top 10 Valuable Customers 💎
* Identifies the top 10 players based on their total purchase amount, alongside their playtime, player level, and age.

### Purchases Comparison 🛒
* Total purchase amounts broken down by age group, game genre, and gender.

### Retention Analysis 🔄
* Calculation of days between the first and second session for players.
* Retention rate by age group (players returning within a week).
* Retention rate by game genre (players returning within a week).

## Dashboards 🖼️

The project includes four key dashboards, located in the `Dashboards/` directory, that provide visual insights into the analyzed data:

### 1. Executive Dashboard 👔
* Provides a high-level overview of key metrics.
  

### 2. Monetization & Purchase Dashboard 💸
* Focuses on revenue and purchase-related metrics.
### 3. Retention & Engagement Dashboard 🤝
* Highlights player retention and engagement metrics.

### 4. User Experience Dashboard ✨
* Provides insights into player experience and progression.

## Setup and Usage 🛠️

To set up and run this project:

1.  **Database**: Ensure you have a SQL Server instance running (e.g., via Docker).
2.  **Data Loading**: Place your `Synthetic_Gaming_Dataset.csv` and `Gaming_Sessions_Log2.csv` files in the specified Docker path (e.g., `/var/opt/mssql/data/`). Alternatively, adjust the `BULK INSERT` paths in `Scripts/CreatingTables_GamingProjcet.sql` if your files are located elsewhere.
3.  **Create Tables and Load Data**: Execute the `Scripts/CreatingTables_GamingProjcet.sql` script in your SQL Server environment to create the necessary tables and load the data.
4.  **Perform Analysis**: Execute the `Scripts/Analysis_GamingProject.sql` script to run all the analytical queries and generate insights.
5.  **Visualize**: Use a business intelligence tool (such as Power BI, Tableau, or similar) to connect to your SQL database and recreate or explore the provided dashboards using the SQL query results.

---
