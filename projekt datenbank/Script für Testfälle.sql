-- ===============================================================================================
-- Ein Benutzer soll nur einmal erfasst werden können!
-- Es soll bei der Registrierung eines neuen Benutzers geprüft werden, ob ein schon ein 
-- Benutzer mit dieser E-Mail-Adresse existiert oder ob der Benutzername schon vergeben ist

-- Benutzer mit dieser E-Mail-Adresse existiert bereits
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Angelina','Hofer','angel-sahara@hotmail.com','Angelina','Angi1234Angi');

-- Es existiert bereits ein Benutzer mit diesem Benutzernamen
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Angelina','Hofer','angelina.hofer@abf.ch','Angeli','Angi1234Angi');
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