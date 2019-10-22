-- User l'lernende' erstellen mit passwort fremdsprachen
CREATE USER 'lernende'@'localhost' IDENTIFIED BY 'fremdsprachen';

-- Rechte an User 'lernende' erteilen für Datenbank 'fremdsprachen'
GRANT INSERT ON fremdsprachen.benutzer TO 'lernende'@'localhost';
FLUSH PRIVILEGES;

-- Rechte für Tabelle benutzer
GRANT SELECT, INSERT, UPDATE, DELETE 
(`Anrede`, `Vorname`, `Nachname`, `Email`, `Benutzername`, `Passwort`) 
ON `fremdsprachen`.`benutzer` 
TO 'lernende'@'localhost';

-- Rechte für Tabelle karteikarten
