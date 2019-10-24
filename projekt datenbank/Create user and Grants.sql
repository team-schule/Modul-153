-- User 'lernende' erstellen mit passwort fremdsprachen
CREATE USER lernende@localhost IDENTIFIED BY 'fremdsprachen'; 

-- Rechte für Tabelle benutzer
GRANT 
SELECT (Anrede, Vorname, Nachname, Email, Benutzername, Passwort),
INSERT (Anrede, Vorname, Nachname, Email, Benutzername, Passwort), 
UPDATE (Anrede, Vorname, Nachname, Email, Benutzername, Passwort), 
DELETE 
ON fremdsprachen.benutzer 
TO lernende@localhost;


-- Rechte für Tabelle karteikarten
GRANT 
SELECT (Vorderseite, Rueckseite), 
INSERT (Vorderseite, Rueckseite), 
UPDATE (Vorderseite, Rueckseite), 
DELETE
ON fremdsprachen.karteikarten 
TO lernende@localhost;


-- Rechte für Tabelle bibliotheken
GRANT 
SELECT (Titel, Ebene, Position), 
INSERT (Titel, Ebene, Position), 
UPDATE (Titel, Ebene, Position), 
DELETE
ON fremdsprachen.bibliotheken 
TO lernende@localhost;




