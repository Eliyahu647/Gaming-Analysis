

-- =============================================
-- EXPLORATORY DATA ANALYSIS (EDA)
-- =============================================

-- General overview
SELECT * FROM gaming;

-- Number of players per location
SELECT Location, COUNT(PlayerID) AS NumOfPlayers
FROM gaming 
GROUP BY Location
ORDER BY NumOfPlayers DESC;

-- Available game difficulties
SELECT DISTINCT(GameDifficulty) AS DifficultyLevels
FROM gaming;

-- Age range
SELECT MIN(Age) AS MinAge, MAX(Age) AS MaxAge
FROM gaming;

-- Player distribution by age groups
SELECT AgeGroups, COUNT(*) AS TotalPlayers
FROM (
    SELECT Age, 
        CASE 
            WHEN Age BETWEEN 10 AND 20 THEN '10-20'
            WHEN Age BETWEEN 21 AND 30 THEN '21-30'
            WHEN Age BETWEEN 31 AND 40 THEN '31-40'
            WHEN Age BETWEEN 41 AND 50 THEN '41-50' 
            ELSE 'Above 50'
        END AS AgeGroups
    FROM gaming
) t
GROUP BY AgeGroups
ORDER BY TotalPlayers DESC;

-- Average age by location
SELECT Location, AVG(Age) AS AvgAge
FROM gaming
GROUP BY Location;

-- Unique game genres
SELECT DISTINCT(GameGenre)
FROM gaming;

-- Average session duration per genre
SELECT GameGenre, AVG(AvgSessionDurationMinutes) AS AvgSessionDuration
FROM gaming
GROUP BY GameGenre;

-- Average age per game genre
SELECT GameGenre, AVG(Age) AS AvgAge
FROM gaming
GROUP BY GameGenre;

-- Engagement level distribution
SELECT EngagementLevel, COUNT(*) AS TotalEngagements
FROM gaming 
GROUP BY EngagementLevel
ORDER BY TotalEngagements DESC;

-- =============================================
-- DEMOGRAPHIC ANALYSIS
-- =============================================

-- Age group distribution by location
SELECT Location, AgeGroups, COUNT(AgeGroups) AS TotalPlayers
FROM gaming
GROUP BY Location, AgeGroups
ORDER BY Location, TotalPlayers DESC;

-- Gender distribution by location
SELECT Location, Gender, COUNT(Gender) AS TotalPlayers
FROM gaming
GROUP BY Location, Gender
ORDER BY Location, TotalPlayers DESC;

-- Average age by gender and location
SELECT Location, Gender, AVG(Age) AS AvgAge
FROM gaming
GROUP BY Location, Gender
ORDER BY Location, AvgAge DESC;

-- =============================================
-- PLAYER BEHAVIOR ANALYSIS
-- =============================================

-- Average playtime per genre
SELECT GameGenre, AVG(PlayTimeHours) AS AvgPlayTimeHours
FROM gaming
GROUP BY GameGenre
ORDER BY AvgPlayTimeHours DESC;

-- Average sessions per week by game difficulty
SELECT GameDifficulty, AVG(SessionsPerWeek) AS AvgSessionsPerWeek
FROM gaming
GROUP BY GameDifficulty
ORDER BY AvgSessionsPerWeek DESC;

-- =============================================
-- IN-GAME PURCHASE BEHAVIOR
-- =============================================

-- Total in-game purchases by age group
SELECT AgeGroups, SUM(InGamePurchases) AS TotalPurchases
FROM gaming
GROUP BY AgeGroups
ORDER BY TotalPurchases DESC;

-- In-game purchase comparison by player level
SELECT purchase_group, LevelGroup, COUNT(*) AS TotalPlayers,
       AVG(PlayTimeHours) AS AvgPlayTimeHours
FROM (
    SELECT CASE WHEN InGamePurchases = 1 THEN 'MadePurchase'
                ELSE 'NoPurchase' END AS purchase_group,
           PlayTimeHours, PlayerLevel, EngagementLevel,
           CASE 
               WHEN PlayerLevel <= 20 THEN 'Beginner'
               WHEN PlayerLevel <= 50 THEN 'Intermediate'
               WHEN PlayerLevel <= 80 THEN 'Advanced'
               ELSE 'TopPlayer'
           END AS LevelGroup
    FROM gaming
) purchase_table
GROUP BY purchase_group, LevelGroup
ORDER BY purchase_group, TotalPlayers DESC;

-- Total players by gender per genre
SELECT GameGenre, Gender, COUNT(*) AS TotalPlayers,
       RANK() OVER(PARTITION BY GameGenre ORDER BY COUNT(*) DESC) AS GenderRanking
FROM gaming
GROUP BY GameGenre, Gender;

-- =============================================
-- ENGAGEMENT ANALYSIS
-- =============================================

-- Engagement distribution by gender and genre
SELECT GameGenre, Gender, EngagementLevel, COUNT(*) AS TotalPlayers
FROM gaming
GROUP BY GameGenre, Gender, EngagementLevel
ORDER BY GameGenre, Gender, EngagementLevel;

-- Average metrics by engagement level
SELECT EngagementLevel,
       ROUND(AVG(PlayTimeHours), 2) AS AvgPlayTime,
       ROUND(AVG(PlayerLevel), 2) AS AvgLevel,
       ROUND(AVG(AchievementsUnlocked), 2) AS AvgAchievements,
       ROUND(AVG(SessionsPerWeek), 2) AS AvgSessions
FROM gaming
GROUP BY EngagementLevel
ORDER BY AvgPlayTime DESC;

-- =============================================
-- GAME DIFFICULTY INSIGHTS
-- =============================================

-- Player distribution by game difficulty and age group
SELECT GameDifficulty, AgeGroups, COUNT(*) AS TotalPlayers
FROM gaming 
GROUP BY GameDifficulty, AgeGroups
ORDER BY GameDifficulty, AgeGroups;

-- Best performing player per game difficulty
WITH player_ranking AS (
    SELECT *, 
           (0.5 * PlayerLevel + 0.5 * AchievementsUnlocked + PlayTimeHours) AS PerformanceScore,
           RANK() OVER(PARTITION BY GameDifficulty 
                       ORDER BY (0.7 * PlayerLevel + 0.3 * AchievementsUnlocked + PlayTimeHours) DESC) AS PerformanceRanking,
           LAG((0.5 * PlayerLevel + 0.5 * AchievementsUnlocked + PlayTimeHours))
           OVER(PARTITION BY GameDifficulty 
                ORDER BY (0.5 * PlayerLevel + 0.5 * AchievementsUnlocked + PlayTimeHours)) AS Second_Place_Player
    FROM gaming
)
SELECT GameDifficulty, PlayerID, PlayerLevel, PlayTimeHours, PerformanceScore, Second_Place_Player,
       ROUND(PerformanceScore - Second_Place_Player, 2) AS PerformanceGap
FROM player_ranking 
WHERE PerformanceRanking = 1
ORDER BY GameDifficulty;

-- =============================================
-- PURCHASE RATE PER GENRE
-- =============================================

SELECT GameGenre, 
       SUM(InGamePurchases) AS TotalPurchases, 
       COUNT(*) AS TotalPlayers,
       CONCAT(ROUND(SUM(InGamePurchases) * 100.0 / COUNT(*), 2), '%') AS PurchaseRate
FROM gaming
GROUP BY GameGenre
ORDER BY TotalPurchases DESC;

-- =============================================
-- SESSIONS AND ACTIVITY STATUS
-- =============================================

-- View all sessions
SELECT * FROM GamingSessionsLog;

-- Active players (played in the last 3 months)
SELECT PlayerID, MAX(SessionDate) AS LastSession
FROM GamingSessionsLog
GROUP BY PlayerID
HAVING DATEDIFF(MONTH, MAX(SessionDate), GETDATE()) < 3;

-- Non-active players (last session over 3 months ago)
SELECT PlayerID, MAX(SessionDate) AS LastSession
FROM GamingSessionsLog
GROUP BY PlayerID
HAVING DATEDIFF(MONTH, MAX(SessionDate), GETDATE()) > 3;

-- Count by activity status
WITH Active_Players AS (
    SELECT DISTINCT(PlayerID), MAX(SessionDate) AS LastSessionDate,
           CASE WHEN DATEDIFF(MONTH, MAX(SessionDate), GETDATE()) < 3 THEN 'ACTIVE'
                ELSE 'Non Active' END AS ActivityStatus
    FROM GamingSessionsLog
    GROUP BY PlayerID
)
SELECT ActivityStatus, COUNT(*) AS TotalPlayers
FROM Active_Players
GROUP BY ActivityStatus;

-- Non returners (players with only one session, over a month ago)
SELECT PlayerID, SessionDate AS FirstSession,
       DATEDIFF(MONTH, SessionDate, GETDATE()) AS MonthsSinceSession
FROM GamingSessionsLog
WHERE PlayerID IN (
    SELECT PlayerID
    FROM GamingSessionsLog
    GROUP BY PlayerID
    HAVING COUNT(*) = 1
) 
AND DATEDIFF(MONTH, SessionDate, GETDATE()) >= 1;

-- =============================================
-- SESSION DURATION TREND
-- =============================================

SELECT *,
       (MonthPlayTime - LastMonthPlayTime) AS PlayTimeDiff,
       CASE 
           WHEN MonthPlayTime > LastMonthPlayTime THEN 'Increase'
           WHEN MonthPlayTime < LastMonthPlayTime THEN 'Decrease'
           WHEN LastMonthPlayTime IS NULL THEN NULL
           ELSE 'Even' END AS PlayTimeTrend
FROM (
    SELECT PlayerID,
           MONTH(SessionDate) AS [2025Months],
           SUM(SessionDuration) AS MonthPlayTime,
           LAG(SUM(SessionDuration)) OVER (PARTITION BY PlayerID ORDER BY MONTH(SessionDate)) AS LastMonthPlayTime
    FROM GamingSessionsLog
    GROUP BY PlayerID, MONTH(SessionDate)
) t
ORDER BY PlayerID, [2025Months];

-- =============================================
-- TOP 10 VALUABLE CUSTOMERS
-- =============================================

SELECT TOP 10 gs.PlayerID, g.PlayTimeHours, g.PlayerLevel, g.Age,
       ROUND(SUM(gs.PurchaseAmount), 2) AS TotalValue
FROM GamingSessionsLog gs
JOIN gaming g ON gs.PlayerID = g.PlayerID
GROUP BY gs.PlayerID, g.PlayTimeHours, g.PlayerLevel, g.Age
ORDER BY TotalValue DESC;

-- =============================================
-- PURCHASES COMPARISON
-- =============================================

-- By age group
SELECT AgeGroups, ROUND(SUM(PurchaseAmount), 2) AS TotalAmount
FROM gaming g
JOIN GamingSessionsLog gs ON g.PlayerID = gs.PlayerID
GROUP BY AgeGroups
ORDER BY TotalAmount DESC;

-- By game genre
SELECT GameGenre, ROUND(SUM(PurchaseAmount), 2) AS TotalAmount
FROM gaming g
JOIN GamingSessionsLog gs ON g.PlayerID = gs.PlayerID
GROUP BY GameGenre
ORDER BY TotalAmount DESC;

-- By gender
SELECT Gender, ROUND(SUM(PurchaseAmount), 2) AS TotalAmount
FROM gaming g
JOIN GamingSessionsLog gs ON g.PlayerID = gs.PlayerID
GROUP BY Gender
ORDER BY TotalAmount DESC;

-- =============================================
-- RETENTION ANALYSIS
-- =============================================

-- Retention: Days between first and second session
SELECT PlayerID, SessionDateDiff AS DaysBetweenFirstAndSecondSession
FROM (
    SELECT PlayerID, SessionNumber, SessionDate,
           DATEDIFF(DAY, LAG(SessionDate) OVER (PARTITION BY PlayerID ORDER BY SessionDate), SessionDate) AS SessionDateDiff
    FROM GamingSessionsLog
    WHERE SessionNumber IN (1, 2)
) T
WHERE SessionDateDiff <= 7 
ORDER BY PlayerID;

-- Retention rate by age group
SELECT AgeGroups, COUNT(*) AS ReturningPlayersWithinAWeek,
       CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gaming gg WHERE gg.AgeGroups = T.AgeGroups), 2), '%') AS ReturnRatePercentOfGroup,
       CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gaming), 2), '%') AS ReturnRatePercentOfTotal
FROM (
    SELECT g.PlayerID, SessionNumber, SessionDate, AgeGroups,
           DATEDIFF(DAY, LAG(SessionDate) OVER (PARTITION BY g.PlayerID ORDER BY SessionDate), SessionDate) AS SessionDateDiff
    FROM GamingSessionsLog gs
    JOIN gaming g ON gs.PlayerID = g.PlayerID
    WHERE SessionNumber IN (1, 2)
) T
WHERE SessionDateDiff <= 7 
GROUP BY AgeGroups
ORDER BY ReturningPlayersWithinAWeek DESC;

-- Retention rate by game genre
SELECT GameGenre, COUNT(*) AS ReturningPlayersWithinAWeek
FROM (
    SELECT g.PlayerID, SessionNumber, SessionDate, GameGenre,
           DATEDIFF(DAY, LAG(SessionDate) OVER (PARTITION BY g.PlayerID ORDER BY SessionDate), SessionDate) AS SessionDateDiff
    FROM GamingSessionsLog gs
    JOIN gaming g ON gs.PlayerID = g.PlayerID
    WHERE SessionNumber IN (1, 2)
) T
WHERE SessionDateDiff <= 7 
GROUP BY GameGenre
ORDER BY ReturningPlayersWithinAWeek DESC;
