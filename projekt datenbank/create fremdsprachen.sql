-- Erstelle Datenbank fremdsprachen
create DATABASE fremdsprachen;

-- use database
use fremdsprachen;

-- Erstelle Tabelle benutzer
create table Benutzer
(
    Benutzer_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Vorname varchar(30) NOT NULL,
    Nachname varchar(30) NOT NULL,
    Email varchar(50) NOT NULL,
    Benutzername varchar(30) NOT NULL,
    Passwort varchar(50) NOT NULL,
    Erfasst_am date,
    Letzte_Aktivitaet date
);

-- Erstelle Tabelle karteikarten
create table Karteikarten
(
    Karten_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Vorderseite varchar(100),
    Rueckseite varchar(100),
    FK_Benutzer int,
    FK_Sprache int,
    CONSTRAINT FK_BENUTZER_KARTE FOREIGN KEY (FK_Benutzer)
    REFERENCES Benutzer(Benutzer_ID),
    CONSTRAINT FK_SPRACHE_KARTE FOREIGN KEY (FK_Sprache)
    REFERENCES Sprachen(Sprachen_ID)
);

-- Erstelle Tabelle sprachen
create table Sprachen
(
    Sprachen_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Bezeichnung varchar(20) NOT NULL
);

-- Erstelle Tabelle bibliotheken
create table Bibliotheken
(
    Eintrags_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20) NOT NULL,
    Beschreibung varchar(50),
    Ebene int(2) NOT NULL,
    Position int(2) NOT NULL,
    FK_Benutzer int NOT NULL,
    FK_Lernmodus int NOT NULL,
    CONSTRAINT FK_BENUTZER_BIBLIOTHEK FOREIGN KEY (FK_Benutzer)
    REFERENCES Benutzer(Benutzer_ID),
    CONSTRAINT FK_BIBLIOTHEK_LERNMODUS_ FOREIGN KEY (FK_Lernmodus)
    REFERENCES Lernmodus(Lernmodus_ID)
);

-- Erstelle Tabelle verbindungen
create table Bibliothek_to_Karte
(
    Verbindungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FK_Karte int NOT NULL,
    FK_Bibliothek int NOT NULL,
    CONSTRAINT FK_VERB_KARTE FOREIGN KEY (FK_Karte)
    REFERENCES Karteikarten(Karten_NR),
    CONSTRAINT FK_VERB_BIBLIOTHEK FOREIGN KEY (FK_Bibliothek)
    REFERENCES Bibliotheken(Eintrags_NR)
);

-- Erstelle Tabelle lernmodi
create table Lernmodus
(
    Lernmodus_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20) NOT NULL,
    Beschreibung varchar(200)
);

-- Erstelle Tabelle lueckentexte
create table Uebungen
(
    Uebungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titel varchar(20),
    Aufgabe varchar(100) NOT NULL,
    Loesung varchar(100),
    FK_Sprache int NOT NULL,
    FK_Lernmodus int NOT NULL,
    FK_Kategorie int NOT NULL,
    CONSTRAINT FK_SPRACHE_LUE FOREIGN KEY (FK_Sprache)
    REFERENCES Sprachen(Sprachen_ID),
    CONSTRAINT FK_MODUS_LUE FOREIGN KEY (FK_Lernmodus)
    REFERENCES Lernmodus(Lernmodus_ID),
    CONSTRAINT FK_MODUS_LUE FOREIGN KEY (FK_Kategorie)
    REFERENCES Kategorien(Kategorie_ID)
);

-- Erstelle Tabelle Kategorien
create table Kategorien
(
    Kategorie_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Kategorie varchar(20) NOT NULL
);

-- Erstelle Tabelle Bibliothek_to_Lernmodus
create table Bibliothek_to_Lernmodus
(
    Verbindungs_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FK_Bibliothek int NOT NULL,
    FK_Lernmodus int NOT NULL,
    CONSTRAINT FK_LERNMODUS_BIBLIOTHEK FOREIGN KEY (FK_Bibliothek)
    REFERENCES Bibliotheken(Eintrags_NR),
    CONSTRAINT FK_BIBLOTHEK_LERNMODUS FOREIGN KEY (FK_Lernmodus)
    REFERENCES Lernmodus(Lernmodus_ID)
);

