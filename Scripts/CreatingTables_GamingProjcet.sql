/*
Features:
PlayerID: Unique identifier for each player.
Age: Age of the player.
Gender: Gender of the player.
Location: Geographic location of the player.
GameGenre: Genre of the game the player is engaged in.
PlayTimeHours: Average hours spent playing per session.
InGamePurchases: Indicates whether the player makes in-game purchases (0 = No, 1 = Yes).
GameDifficulty: Difficulty level of the game.
SessionsPerWeek: Number of gaming sessions per week.
AvgSessionDurationMinutes: Average duration of each gaming session in minutes.
PlayerLevel: Current level of the player in the game.
AchievementsUnlocked: Number of achievements unlocked by the player.
EngagementLevel: Categorized engagement level reflecting player retention ('High', 'Medium', 'Low').
Target Variable:
EngagementLevel: Indicates the level of player engagement categorized as 'High', 'Medium', or 'Low'.
*/

-- =============================================
-- DATABASE STRUCTURE AND DATA LOADING
-- =============================================

CREATE DATABASE Gaming;

DROP TABLE IF EXISTS gaming;
DROP TABLE IF EXISTS GamingSessionsLog;

CREATE TABLE gaming (
    PlayerID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(20),
    Location VARCHAR(50),
    GameGenre VARCHAR(50),
    PlayTimeHours FLOAT,
    InGamePurchases INT,
    GameDifficulty VARCHAR(50),
    SessionsPerWeek FLOAT,
    AvgSessionDurationMinutes FLOAT,
    PlayerLevel FLOAT,
    AchievementsUnlocked FLOAT,
    EngagementLevel VARCHAR(20)
);

CREATE TABLE GamingSessionsLog (
    PlayerID INT,
    SessionNumber INT,
    SessionDate DATE,
    SessionDuration INT,
    MadePurchase INT,
    PurchaseAmount FLOAT,
    CONSTRAINT pk_PlayerSession PRIMARY KEY (PlayerID, SessionNumber)
);

-- Data loading after uploading CSV files to Docker
BULK INSERT gaming
FROM '/var/opt/mssql/data/Synthetic_Gaming_Dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    KEEPNULLS,
    TABLOCK
);

BULK INSERT GamingSessionsLog
FROM '/var/opt/mssql/data/Gaming_Sessions_Log2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    KEEPNULLS,
    TABLOCK
);

-- Add Age Group column
ALTER TABLE gaming
ADD AgeGroups VARCHAR(20);

UPDATE gaming
SET AgeGroups = 
  CASE 
    WHEN Age BETWEEN 10 AND 20 THEN '10-20'
    WHEN Age BETWEEN 21 AND 30 THEN '21-30'
    WHEN Age BETWEEN 31 AND 40 THEN '31-40'
    WHEN Age BETWEEN 41 AND 50 THEN '41-50' 
    ELSE 'Above 50'
  END;
