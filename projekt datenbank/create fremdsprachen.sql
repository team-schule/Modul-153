-- Erstelle Datenbank fremdsprachen
create database if not exists fremdsprachen; 

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
    Benutzername varchar(30) NOT NULL,
    Passwort varchar(50) NOT NULL,
    -- Beim Insert wird das aktuelle Datum gesetzt
    Erfasst_am DATE NOT NULL DEFAULT current_date(),
    -- Bei Insert und Update wird das aktuelle Datetime gesetzt
    Letzte_Aktivitaet TIMESTAMP,
    -- Bei Anrede soll nur Herr oder Frau möglich sein
    CONSTRAINT CHECK_ANREDE check (Anrede in ('Herr','Frau')),
    -- Passwort muss eine Länge zwischen 8 und 12 Zeichen haben
    CONSTRAINT CHECK_PW check (CHAR_LENGTH (Passwort) >= 8 and CHAR_LENGTH (Passwort) <= 12),
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
    REFERENCES Bibliotheken(Eintrags_NR) on delete CASCADE,
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
    REFERENCES Karteikarten(Karten_NR),
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

-- ==================================================================================================
-- Erstellung der Trigger

-- Trigger AFTER_INSERT_BENUTZER
-- Erstellt bei neuem Eintrag in der Tabelle benutzer 
-- einen Eintrag Bibliothek in der Tabelle bibliotheken
DELIMITER |
CREATE OR REPLACE TRIGGER `AFTER_INSERT_BENUTZER` AFTER INSERT ON `benutzer` 
FOR EACH ROW 
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
VALUES ('Bibliothek',1,1,new.Benutzer_ID);
UPDATE benutzer SET Passwort = sha1(new.Passwort) where Benutzer_ID = new.Benutzer_ID;
| DELIMITER;

-- ==================================================================================================

-- Trigger AFTER_INSERT_BIBLIOTHEK
-- Soll bei einem neuen Eintrag in der Bibliothek die Felder


-- ==================================================================================================
-- Folgender Gedanke zum Ablauf einer Neu-Erfassung eines Eintrages in der Bibliothek:
-- 1. Sprache auswählen (Vorgegeben, es sind nur Sprachen Möglich, welche in der Bibliothek gespeichert sind)
-- 2. Auswahl "neu" oder "bestehendem Eintrag hinzufügen"
-- 3. 