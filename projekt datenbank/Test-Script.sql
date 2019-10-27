-- ==================================================================================
-- Test-Script:
-- Dieses Skript beinhaltet Test zu allen Datenbank-Objekten, welche erstellt wurden
-- und zu den Use-Cases, welche zur Datenbank-Erstellung wichtig waren, sowie die 
-- erwarteten Ergebnisse dazu.

-- Wichtig zu beachten:
-- Die Reihen folge der Tests muss eingehalten werden, damit die Ergebnisse zu
-- erhalten, welche zu jedem Test angegeben sind
-- ==================================================================================

-- ==================================================================================
-- Test 1: 
-- Überprüfung, ob Daten in der Datenbank enthalten sind nach dem INIT-Skript

-- Tabelle Benutzer
-- Ergebnis: Es müssen drei Benutzer erfasst sein
SELECT * FROM Benutzer;
-- ==================================================================================