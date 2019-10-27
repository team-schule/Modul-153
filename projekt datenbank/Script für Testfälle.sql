-- ===============================================================================================
-- Ein Benutzer soll nur einmal erfasst werden können!
-- Die Identifizierung läuft über die E-Mail-Adresse, so kann ein Benutzer mehrmals registriert 
-- sein über eine andere E-Mail-Adresse

-- Dieser Benutzer existiert bereits genauso und darf kein zweites Mal erstellt werden
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Angelina','Hofer','angel-sahara@hotmail.com','Angeli','Angi1234Angi');
-- ================================================================================================




-- ===============================================================================================
-- Prüfung Trigger ONINSERTBENUTZER
-- Neuen Benutzer erstellen, um Funktion des Triggers ONINSERTBENUTZER zu prüfen
-- Für den neuen Benutzer soll in der Tabelle bibliotheken einen Eintrag erstellt werden,
-- Mit dem Titel 'Bibliothek' dieser soll gleich nach dem Einloggen dann angezeigt werden
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Marianne','Hürlimann','m.hmann@hotmail.com','Sybille','SuperMami12');

-- Mit der folgenden Abfrage kann geprüft werden, ob der Eintrag 'Bibliothek' vorhanden ist und 
-- ob auch nur dieser Eintrag vorhanden ist!
select * from bibliotheken where FK_BENUTZER = 4;
-- ===============================================================================================

-- ===============================================================================================
-- Anzeige der Rechte der Benutzer
-- Da das Testen der Rechte nur durch die Anmeldung über ein GUI (Webseite) oder durch Anmeldung
-- als entsprechender User auf der Datenbank, haben wir zur Veranschaulichung der Rechte
-- als erste Prüfung hier eine Abfrage dafür bereit gemacht. Wirklich testen kann man diese jedoch 
-- nur, wenn man als dieser User auf der Datenbank eingeloggt ist.
--------------------------------------------------------------------------------------------------
-- Abfrage für den Benutzer lernende@localhost mit passwort 'fremdsprachen'
SHOW GRANTS FOR lernende@localhost;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Abfrage für den Benutzer adminfremdsprachen@localhost mit passwort 'AdministratorFSP'
SHOW GRANTS FOR adminfremdsprachen@localhost;
-- ===============================================================================================