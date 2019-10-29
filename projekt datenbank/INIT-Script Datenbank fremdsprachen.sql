-- =====================================================================
-- Ersteller der Datenbank:     Angelina Hofer, Patrick Tomasi
-- E-Mail-Kontakt Ersteller:    angel-sahara@hotmail.com
-- Details zur Datenbank:
-- Server: 127.0.0.1 via TCP/IP
-- Server-Typ: MariaDB
-- Server-Verbindung: SSL wird nicht verwendet Dokumentation
-- Server-Version: 10.4.6-MariaDB - mariadb.org binary distribution
-- Protokoll-Version: 10
-- Benutzer: root@localhost
-- Server-Zeichensatz: cp1252 West European (latin1)
-- =====================================================================
-- INIT-Script
-- Die Reihenfolge der Erstellungen ist so gewählt, dass es 
-- keine Fehler gibt aufgrund der beiinhalteten Fremdschlüssel...
-- ... daher darf die Reihenfolge nicht verändert werden!

-- Dieses Script erstellt:
-- 
-- 1. Datenbank 'femdsprachen'
-- 2. Tabellen 
--      -> 'Benutzer'
--      -> 'Sprachen'
--      -> 'Lernmodus'
--      -> 'Kategorien'
--      -> 'Karteikarten'
--      -> 'Bibliotheken'
--      -> 'Bibliothek_to_Karte'
--      -> 'Uebungen'
--      -> 'Bibliothek_to_Lernmodus'
-- 3. Trigger 
--      -> AFTER_INSERT_BENUTZER
--      -> AFTER_INSERT_KARTEIKARTEN
--      -> AFTER_UPDATE_KARTEIKARTEN
--      -> AFTER_DELETE_KARTEIKARTEN
-- 4. Stored Procedure
--      ->
-- 5. Benutzer (User)
--      -> adminfremdsprachen@localhost
--      -> lernende@localhost
-- 6. Füllen der Datenbank mit Testdaten
-- 7. Views
--      -> V_KARTEN_PRO_SPRACHE
--      -> V_LT_FRANZOESISCH
--      -> V_LT_ITALIENISCH
--      -> V_LT_ENGLISCH
-- =====================================================================
-- 1. Erstellung der Datenbank 
-- ---------------------------------------------------------------------
-- Erstelle Datenbank fremdsprachen
create database if not exists fremdsprachen; 

-- =====================================================================
-- 2. Erstellung der Tabellen
-- ---------------------------------------------------------------------

-- use database
use fremdsprachen;

-- Erstelle Tabelle Benutzer
create table if not exists Benutzer
(
    Benutzer_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Anrede varchar(5) NOT NULL,
    Vorname varchar(30) NOT NULL,
    Nachname varchar(30) NOT NULL,
    -- Email darf nur einmal in der Tabelle vorkommen 
    -- (Benutzeridentifizierung) 
    -- -> so sind keine doppelten Einträge möglich eines Benutzers
    Email varchar(50) NOT NULL UNIQUE,
    Benutzername varchar(30) NOT NULL UNIQUE,
    Passwort varchar(400) NOT NULL,
    -- Beim Insert wird das aktuelle Datum gesetzt
    Erfasst_am DATE NOT NULL DEFAULT current_date(),
    -- Bei Insert und Update wird das aktuelle Datetime gesetzt
    Letzte_Aenderung TIMESTAMP,
    -- Bei Anrede soll nur Herr oder Frau möglich sein
    CONSTRAINT CHECK_ANREDE check (Anrede in ('Herr','Frau')),
    -- Email muss Format erfüllen: Mindestens -> 3Stellen + @ + 3Stellen + . + 2Stellen
    CONSTRAINT CHECK_EMAIL check (Email like '%___@___%.__%')
); 

-- Erstelle Tabelle Sprachen
create table if not exists Sprachen
(
    Sprachen_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Bezeichnung varchar(20) NOT NULL
);

-- Erstelle Tabelle Lernmodus
create table if not exists Lernmodus
(
    Lernmodus_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20) NOT NULL,
    Beschreibung varchar(200)
);

-- Erstelle Tabelle Kategorien
create table if not exists Kategorien
(
    Kategorie_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Kategorie varchar(20) NOT NULL
);

-- Erstelle Tabelle Karteikarten
create table if not exists Karteikarten
(
    Karten_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Vorderseite varchar(100),
    Rueckseite varchar(100),
    FK_Benutzer int,
    FK_Sprache int,
    -- Dem Benutzer zugehörige Karten sollen beim Löschen 
    -- eines Benutzers auch gelöscht werden
    CONSTRAINT FK_BENUTZER_KARTE FOREIGN KEY (FK_Benutzer)
    REFERENCES Benutzer(Benutzer_ID) on delete CASCADE,
    CONSTRAINT FK_SPRACHE_KARTE FOREIGN KEY (FK_Sprache)
    REFERENCES Sprachen(Sprachen_ID) 
);

-- Erstelle Tabelle Bibliotheken
create table if not exists Bibliotheken
(
    Eintrags_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20) NOT NULL,
    Ebene int(2) NOT NULL,
    Position int(2) NOT NULL,
    FK_Benutzer int NOT NULL,
    -- FK zur Erstellung des Menübaumes
    -- Es wird immer der Schlüssel der oberen Ebene angegeben (Ausser bei der obersten)
    FK_Bibliothek int,
    FK_Sprache int,
    -- Dem Benutzer zugehörige Bibliotheken sollen beim Löschen 
    -- eines Benutzers auch gelöscht werden
    CONSTRAINT FK_BENUTZER_BIBLIOTHEK FOREIGN KEY (FK_Benutzer)
    REFERENCES Benutzer(Benutzer_ID) on delete CASCADE,
    CONSTRAINT FK_BIBLIOTHEK_BIBLIOTHEK FOREIGN KEY (FK_Bibliothek)
    REFERENCES Bibliotheken(Eintrags_NR)on delete CASCADE,
    CONSTRAINT FK_BIBLIOTHEK_SPRACHE FOREIGN KEY (FK_Sprache)
    REFERENCES Sprachen(Sprachen_ID) 
);

-- Erstelle Tabelle Bibliothek_to_Karte
create table if not exists Bibliothek_to_Karte
(
    Verbindungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FK_Karte int NOT NULL,
    FK_Bibliothek int NOT NULL,
    CONSTRAINT FK_VERB_KARTE FOREIGN KEY (FK_Karte)
    REFERENCES Karteikarten(Karten_NR) on delete CASCADE,
    -- Dem Benutzer zugehörige Bibliotheken sollen beim Löschen 
    -- eines Benutzers auch gelöscht werden
    CONSTRAINT FK_VERB_BIBLIOTHEK FOREIGN KEY (FK_Bibliothek)
    REFERENCES Bibliotheken(Eintrags_NR) on delete CASCADE
);

-- Erstelle Tabelle Uebungen
create table if not exists Uebungen
(
    Uebungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20),
    Aufgabe varchar(100) NOT NULL,
    Loesung varchar(100) NOT NULL,
    FK_Sprache int NOT NULL,
    FK_Lernmodus int NOT NULL,
    FK_Kategorie int NOT NULL,
    CONSTRAINT FK_SPRACHE_LUE FOREIGN KEY (FK_Sprache)
    REFERENCES Sprachen(Sprachen_ID),
    CONSTRAINT FK_MODUS_UEBUNGEN FOREIGN KEY (FK_Lernmodus)
    REFERENCES Lernmodus(Lernmodus_ID),
    CONSTRAINT FK_UBUNGEN_KAT FOREIGN KEY (FK_Kategorie)
    REFERENCES Kategorien(Kategorie_ID)
);

-- Erstelle Tabelle Bibliothek_to_Lernmodus
create table if not exists Bibliothek_to_Lernmodus
(
  Verbindungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FK_Bibliothek int NOT NULL,
  FK_Lernmodus int NOT NULL,
  -- Dem Benutzer zugehörige Bibliotheken sollen beim Löschen 
  -- eines Benutzers auch gelöscht werden
  CONSTRAINT FK_LERNMODUS_BIBLIOTHEK FOREIGN KEY (FK_Bibliothek)
  REFERENCES Bibliotheken(Eintrags_NR) on delete CASCADE,
  CONSTRAINT FK_BIBLOTHEK_LERNMODUS FOREIGN KEY (FK_Lernmodus)
  REFERENCES Lernmodus(Lernmodus_ID)
);

-- =====================================================================
-- 3. Erstellung der Trigger AFTER_INSERT_BENUTZER
-- ---------------------------------------------------------------------
-- Trigger AFTER_INSERT_BENUTZER
-- Erstellt bei neuem Eintrag in der Tabelle benutzer 
-- einen Eintrag Bibliothek in der Tabelle bibliotheken,
-- welcher als Beispiel dient
DELIMITER  //
CREATE OR REPLACE TRIGGER `AFTER_INSERT_BENUTZER` AFTER INSERT ON `benutzer` 
FOR EACH ROW 
BEGIN
    INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
    VALUES ('Bibliothek',1,1,new.Benutzer_ID);
END  // 
DELIMITER  ;

-- ---------------------------------------------------------------------
-- Trigger AFTER_INSERT_KARTEIKARTEN
-- Nach dem Erstellen einer neuen Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `AFTER_INSERT_KARTEIKARTEN` 
AFTER INSERT ON Karteikarten
FOR EACH ROW 
BEGIN
    UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
    (SELECT FK_Benutzer FROM Karteikarten WHERE Karten_NR = new.Karten_NR);
END  // 
DELIMITER  ;

-- ---------------------------------------------------------------------
-- Trigger AFTER_INSERT_KARTEIKARTEN
-- Nach einer Änderrung an einer Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `AFTER_UPDATE_KARTEIKARTEN` 
AFTER UPDATE ON Karteikarten
FOR EACH ROW 
BEGIN
    UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
    (SELECT FK_Benutzer FROM Karteikarten WHERE Karten_NR = new.Karten_NR);
END  // 
DELIMITER  ;

-- ---------------------------------------------------------------------
-- Trigger AFTER_DELETE_KARTEIKARTEN
-- Nach einer Änderrung an einer Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `BEFORE_DELETE_KARTEIKARTEN` 
BEFORE DELETE ON Karteikarten
FOR EACH ROW 
BEGIN
    UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
    (SELECT FK_Benutzer FROM Karteikarten WHERE Karten_NR = old.Karten_NR);
END  // 
DELIMITER  ;


-- ---------------------------------------------------------------------
-- Trigger AFTER_INSERT_BIBLIOTHEKEN
-- Nach dem Erstellen einer neuen Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `AFTER_INSERT_BIBLIOTHEKEN` 
AFTER INSERT ON Bibliotheken
FOR EACH ROW 
BEGIN
    IF new.TITEL != 'Bibliothek' THEN
        UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
        (SELECT FK_Benutzer FROM Bibliotheken WHERE Eintrags_NR = new.Eintrags_NR);
    END IF;
END  // 
DELIMITER  ;

-- ---------------------------------------------------------------------
-- Trigger AFTER_UPDATE_BIBLIOTHEKEN
-- Nach einer Änderrung an einer Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `AFTER_UPDATE_BIBLIOTHEKEN` 
AFTER UPDATE ON Bibliotheken
FOR EACH ROW 
BEGIN
    UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
    (SELECT FK_Benutzer FROM Bibliotheken WHERE Eintrags_NR = new.Eintrags_NR);
END  // 
DELIMITER  ;


-- ---------------------------------------------------------------------
-- Trigger BEFORE_DELETE_BIBLIOTHEKEN
-- Nach einer Änderrung an einer Karteikarte soll in der Tabelle 'Benutzer' 
-- das Feld 'Letzte_Aenderung' aktuelisiert werden auf den aktuellen Timestamp
DELIMITER  //
CREATE OR REPLACE TRIGGER `BEFORE_DELETE_BIBLIOTHEKEN` 
BEFORE DELETE ON Bibliotheken
FOR EACH ROW 
BEGIN
    UPDATE Benutzer SET Letzte_Aenderung = CURRENT_TIMESTAMP() where Benutzer_ID IN
    (SELECT FK_Benutzer FROM Bibliotheken WHERE Eintrags_NR = old.Eintrags_NR);
END  // 
DELIMITER  ;
-- =====================================================================


-- =====================================================================
-- 4. Erstellung der Stored Procedure
-- ---------------------------------------------------------------------

-- =====================================================================
-- 5. Erstellung der Benutzer (User) 
-- ---------------------------------------------------------------------

-- Administrator für die Datenbank 'fremdsprachen'
-- Dieser User hat nur auf diese Datenbank Zugriff, hat dafür aber 
-- alle Rechte
CREATE USER adminfremdsprachen@localhost IDENTIFIED BY 'AdministratorFSP';
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON fremdsprachen . * TO adminfremdsprachen@localhost;
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- User, welcher beim normalen Login auf der Webseite benutzt wird
-- User 'lernende' erstellen mit passwort fremdsprachen
CREATE USER lernende@localhost IDENTIFIED BY 'fremdsprachen'; 
FLUSH PRIVILEGES;

-- Rechte für Tabelle benutzer
GRANT 
SELECT,
INSERT (Anrede, Vorname, Nachname, Email, Benutzername, Passwort), 
UPDATE (Anrede, Vorname, Nachname, Email, Benutzername, Passwort), 
DELETE 
ON fremdsprachen.benutzer 
TO lernende@localhost;
FLUSH PRIVILEGES;

-- Rechte für Tabelle karteikarten
GRANT 
SELECT, 
INSERT (Vorderseite, Rueckseite), 
UPDATE (Vorderseite, Rueckseite), 
DELETE
ON fremdsprachen.karteikarten 
TO lernende@localhost;
FLUSH PRIVILEGES;

-- Rechte für Tabelle bibliotheken
GRANT 
SELECT, 
INSERT (Titel, Ebene, Position), 
UPDATE (Titel, Ebene, Position), 
DELETE
ON fremdsprachen.bibliotheken 
TO lernende@localhost;
FLUSH PRIVILEGES;

-- =====================================================================
-- 6. Füllen der Datenbank mit Testdaten 
-- ---------------------------------------------------------------------

-- Insert Script
use fremdsprachen;

-- Insert für Tabelle Benutzer
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Angelina','Hofer','angel-sahara@hotmail.com','Angeli',SHA2('Angi1234Angi',256));
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Patrick','Tomasi','patrick.tomasi@gmx.ch','Paddy',SHA2('12345678',256));
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Matthias','Dueggelin','nex.nex@gmx.ch','NexNex',SHA2('159159Nix',256));


-- Insert für Tabelle Sprachen
-- Die Bezeichnungen für die Sprachen werden vom Benutzer selbst gewählt
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Französisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Englisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Italienisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Spanisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Griechisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Türkisch');

-- Insert für Tabelle Lernmodus
-- Mögliche Lernmodi stehen dem Benutzer nur zur Auswahl zur Verfügung
-- Er kann diese nicht ändern
INSERT INTO lernmodus(Titel, Beschreibung) 
VALUES ('Lückentexte','');
INSERT INTO lernmodus(Titel, Beschreibung) 
VALUES ('Grammatik','');
INSERT INTO lernmodus(Titel, Beschreibung) 
VALUES ('Schreiben','');

-- Insert für Tabelle Kategorien
INSERT INTO kategorien(Kategorie) 
VALUES ('Vokabeln');
INSERT INTO kategorien(Kategorie) 
VALUES ('Lückentexte');


-- Insert für Tabelle Karteikarten ------------------------------------------
-- Benutzer 1, Sprache Französisch 
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Halloo','Salue',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Bonjour',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Fleisch','la viande',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','manger',1,1);
-- und Italienisch
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Die Sonne','il sole',1,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Das Herz','il cuore',1,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Das Wetter','il tempo',1,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Die Nase','il naso',1,3);

-- Benutzer 2, Sprache Italienisch
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Ciao',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Bongiorno',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','mangiare',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Fleisch','la carne',2,3);

-- Benutzer 3, Sprache Englisch
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Hello',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Good Morning',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','eat',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Apfel','apple',3,2);


-- Insert für Tabelle Bibliotheken --------------------------------------------
-- Bibliothek Benutzer 1
-- Überschrift Bibliothek
-- INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
-- VALUES ('Bibliothek','Bibliothek',1,1,1); -- 1
-- Sprache Französisch
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Französisch',2,1,1,1,1); -- 2
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Essen',3,1,1,4,1); -- 3
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Begrüssung',3,2,1,4,1); -- 4
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Lückentexte',3,3,1,4,1); -- 5
-- und Italienisch
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Italienisch',2,2,1,1,3); -- 6
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Wetter',3,1,1,8,3); -- 7
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Körper',3,2,1,8,3); -- 8
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Grammatik',3,3,1,8,3); -- 9

-- Bibliothek Benutzer 2
-- Überschrift Bibliothek
-- INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
-- VALUES ('Bibliothek','Bibliothek',1,1,2); -- 10
-- Sprache Italienisch
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Italienisch',2,1,2,2,3); -- 11
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Essen',3,1,2,12,3); -- 12
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Begrüssung',3,2,2,12,3); -- 13
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Lückentexte',3,3,2,12,3); -- 14
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Schreiben',3,4,2,12,3); -- 15

-- Bibliothek Benutzer 3
-- Überschrift Bibliothek
-- INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
-- VALUES ('Bibliothek','Bibliothek',1,1,3); -- 16
-- Sprache Englisch
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Englisch',2,1,3,3,1); -- 17
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Essen',3,1,3,17,1); -- 18
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Begrüssung',3,2,3,17,1); -- 19
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Lückentexte',3,3,3,17,1); -- 20
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Grammatik',3,4,3,17,1); -- 21
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Schreiben',3,5,3,17,1); -- 22
-- Ende Insert Tabelle Bibliotheken --------------------------------------------


-- Insert für Tabelle Bibliothek_to_Karte
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (1,6);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (2,6);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (3,5);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (4,5);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (5,9);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (7,9);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (6,10);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (8,10);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (9,13);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (10,13);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (11,14);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (12,14);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (15,18);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (16,18);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (13,19);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (14,19);


-- Insert für Tabelle Uebungen
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... signor Ferrari. ... Stella. Am Abend: ...','Buongiorno,Ciao,Buonasera',3,1,2);
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... monsieur Ferrari. ... Stella. Am Abend: ...','Bonjour,Salue,bon soir',1,1,2);
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... Mister Ferrari. ... Stella. Am Abend: ...','Good Morning,hi,Good Evening',2,1,2);

-- Insert für Tabelle Bibliothek_to_Lernmodus
-- Bibliothek Benutzer 1, Französisch
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (5,1);
-- Bibliothek Benutzer 1, Italienisch
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (9,2);
-- Bibliothek Benutzer 2, Italienisch
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (14,1);
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (15,3);
-- Bibliothek Benutzer 3, Englisch
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (20,1);
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (21,2);
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES (22,3);


-- =====================================================================
-- 7. Erstellung der Views
-- ---------------------------------------------------------------------
-- View V_KARTEN_PRO_SPRACHE (Für Benutzer 1 und Sprache Französisch)
-- Zeigt dem Benutzer mit Benutzer_ID alle Karten an, welche er unter der 
-- Sprache Französisch gespeichert hat
CREATE VIEW if not exists V_KARTEN_PRO_SPRACHE AS
SELECT Vorderseite, Rueckseite FROM Karteikarten WHERE Karten_NR IN 
    (SELECT FK_Karte FROM Bibliothek_to_karte WHERE FK_Bibliothek IN 
        (SELECT Eintrags_NR FROM Bibliotheken WHERE FK_Benutzer = 1 AND FK_Sprache = 1));

-- ---------------------------------------------------------------------
-- View V_KARTEN_PRO_MENUE 
-- (Für Benutzer 1 und Sprache Französisch und Menüpunkt = 'Essen')
-- Zeigt dem Benutzer mit Benutzer_ID alle Karten an, welche er einem 
-- bestimmten Menue gespeichert hat
CREATE VIEW if not exists V_KARTEN_PRO_MENUE AS
SELECT Vorderseite, Rueckseite FROM Karteikarten WHERE Karten_NR in 
    (SELECT FK_Karte FROM Bibliothek_to_Karte where FK_Bibliothek in 
        (SELECT Eintrags_NR FROM Bibliotheken WHERE Titel = 'Essen' 
        and FK_Benutzer = 1 and FK_Sprache = 1));

-- ---------------------------------------------------------------------
-- View V_LT_FRANZOESISCH
-- Holt die Lückentexte zur Sprache Französisch
CREATE VIEW if not exists V_LT_FRANZOESISCH AS
SELECT Aufgabe, Loesung FROM Uebungen 
WHERE FK_Lernmodus IN 
    (SELECT Lernmodus_ID FROM Lernmodus WHERE Titel = 'Lückentexte')
AND FK_SPRACHE = 1;

-- ---------------------------------------------------------------------
-- View V_LT_ITALIENISCH
-- Holt die Lückentexte zur Sprache Italienisch
CREATE VIEW if not exists V_LT_ITALIENISCH AS
SELECT Aufgabe, Loesung FROM Uebungen 
WHERE FK_Lernmodus IN 
    (SELECT Lernmodus_ID FROM Lernmodus WHERE Titel = 'Lückentexte')
AND FK_SPRACHE = 3;

-- ---------------------------------------------------------------------
-- View V_LT_ENGLISCH
-- Holt die Lückentexte zur Sprache Englisch
CREATE VIEW if not exists V_LT_ENGLISCH AS
SELECT Aufgabe, Loesung FROM Uebungen 
WHERE FK_Lernmodus IN 
    (SELECT Lernmodus_ID FROM Lernmodus WHERE Titel = 'Lückentexte')
AND FK_SPRACHE = 2;

-- =====================================================================
