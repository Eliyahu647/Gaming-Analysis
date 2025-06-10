# Gaming Project Analysis

## Overview

This project presents a comprehensive analysis of a gaming dataset, focusing on player demographics, behavior, monetization, engagement, and retention. The goal is to extract actionable insights that can inform game development, marketing strategies, and overall player experience improvements. The analysis is performed using SQL for data querying and transformation, and visualized through interactive dashboards.

## Project Structure

The project repository is organized as follows:

* `CreatingTables_GamingProjcet.sql`: SQL script for creating the database tables (`gaming` and `GamingSessionsLog`) and loading data from CSV files. It also includes an `ALTER TABLE` statement to add an `AgeGroups` column.
* `Analysis_GamingProject.sql`: SQL script containing various queries for exploratory data analysis, demographic analysis, player behavior, in-game purchase analysis, engagement analysis, game difficulty insights, purchase rate per genre, session and activity status, session duration trends, valuable customers, and retention analysis.
* `Dashboards/`: Directory containing the visual dashboards (e.g., `Executive Dashboard.jpg`, `Monetization & Purchase.jpg`, `Retention & Engagement.jpg`, `User Experience.jpg`).

## Data Sources

The analysis utilizes two primary datasets:

1.  `Synthetic_Gaming_Dataset.csv`: Contains player demographic and in-game activity data.
    * **Features**: `PlayerID`, `Age`, `Gender`, `Location`, `GameGenre`, `PlayTimeHours`, `InGamePurchases`, `GameDifficulty`, `SessionsPerWeek`, `AvgSessionDurationMinutes`, `PlayerLevel`, `AchievementsUnlocked`, `EngagementLevel`.
    * **Target Variable**: `EngagementLevel` (categorized as 'High', 'Medium', or 'Low').

2.  `Gaming_Sessions_Log2.csv`: Logs individual gaming sessions and purchase details.
    * **Features**: `PlayerID`, `SessionNumber`, `SessionDate`, `SessionDuration`, `MadePurchase`, `PurchaseAmount`.

## SQL Analysis (`Analysis_GamingProject.sql`)

The `Analysis_GamingProject.sql` script performs a wide range of analyses, including but not limited to:

### Exploratory Data Analysis (EDA)
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

### Demographic Analysis
* Age group distribution by location.
* Gender distribution by location.
* Average age by gender and location.

### Player Behavior Analysis
* Average playtime per genre.
* Average sessions per week by game difficulty.

### In-Game Purchase Behavior
* Total in-game purchases by age group.
* In-game purchase comparison by player level.
* Total players by gender per genre.

### Engagement Analysis
* Engagement distribution by gender and genre.
* Average metrics (PlayTime, Level, Achievements, Sessions) by engagement level.

### Game Difficulty Insights
* Player distribution by game difficulty and age group.
* Identification of the best performing player per game difficulty based on a calculated `PerformanceScore`.

### Purchase Rate per Genre
* Calculation of total purchases, total players, and purchase rate for each game genre.

### Sessions and Activity Status
* Identification of active players (played in the last 3 months) and non-active players (last session over 3 months ago).
* Counting players by activity status.
* Identifying "non-returners" (players with only one session, over a month ago).

### Session Duration Trend
* Analysis of monthly playtime trends for each player, showing increases, decreases, or even play time compared to the previous month.

### Top 10 Valuable Customers
* Identifies the top 10 players based on their total purchase amount, alongside their playtime, player level, and age.

### Purchases Comparison
* Total purchase amounts broken down by age group, game genre, and gender.

### Retention Analysis
* Calculation of days between the first and second session for players.
* Retention rate by age group (players returning within a week).
* Retention rate by game genre (players returning within a week).

## Dashboards

The project includes four key dashboards that provide visual insights into the analyzed data:

### 1. Executive Dashboard (`צילום מסך 2025-06-10 121017.jpg`)
* Provides a high-level overview of key metrics such as Total Purchase Value (1.1M), 1-week Retentions (34K), High Engagement players (42K), Active Players (1702), and Non-Returners (2388).
* Visualizes Engagement Level distribution, Gender distribution, Game Genre popularity, Age Group distribution, Location-based player distribution, and Total Purchase Amount trends over time.

### 2. Monetization & Purchase Dashboard (`צילום מסך 2025-06-10 121153.jpg`)
* Focuses on revenue and purchase-related metrics, displaying ARPPPU (36.8), ARPU (21.2), Paying Users Count (9484), and Purchase Conversion (0.6).
* Shows Purchase Amount by Month, In-Game Purchases by Month, Purchase Amount by Age Groups and Gender, and Average Player Level by Player Level Group and In-Game Purchases.

### 3. Retention & Engagement Dashboard (`צילום מסך 2025-06-10 121141.jpg`)
* Highlights player retention and engagement metrics, presenting Retentions (1 Day: 4902, 1 Week: 33.7K, 1 Month: 47.6K) and Non-Returners (2388).
* Visualizes the Number of Players per Session Date (growth trend), Engagement Level by average metrics (sessions, achievements, player level, playtime), and percentage of 1-week retentions by Age Groups, Gender, and Player Level Group.

### 4. User Experience Dashboard (`צילום מסך 2025-06-10 121028.jpg`)
* Provides insights into player experience and progression, showing Average Player Level (52.0), Average Achievements (30.7), Average Play Time (123.8), and Average Num Sessions (10.2).
* Visualizes Total Players by Player Level Group, Average Player Level by Age Groups, Average Achievements by Game Genre, Average Player Level by Game Difficulty, Average Playtime by Age Groups and Gender, and Average Number of Sessions by Month.

## Setup and Usage

To set up and run this project:

1.  **Database**: Ensure you have a SQL Server instance running (e.g., via Docker).
2.  **Data Loading**: Place your `Synthetic_Gaming_Dataset.csv` and `Gaming_Sessions_Log2.csv` files in the specified Docker path (e.g., `/var/opt/mssql/data/`).
3.  **Create Tables and Load Data**: Execute the `CreatingTables_GamingProjcet.sql` script in your SQL Server environment to create the necessary tables and load the data.
4.  **Perform Analysis**: Execute the `Analysis_GamingProject.sql` script to run all the analytical queries and generate insights.
5.  **Visualize**: Use a business intelligence tool (such as Power BI, Tableau, or similar) to connect to your SQL database and recreate or explore the provided dashboards using the SQL query results.

---
