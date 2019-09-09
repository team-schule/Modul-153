-- Erstelle Datenbank fremdsprachen
create DATABASE fremdsprachen;

-- Erstelle Tabelle benutzer
create table benutzer
(
    BENUTZER_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    VORNAME varchar(50) NOT NULL,
    NACHNAME varchar(50) NOT NULL,
    EMAIL varchar(50) NOT NULL,
    BENUTZERNAME varchar(20) NOT NULL,
    PASSWORT varchar(50) NOT NULL,
    ERFASS_DATUM date,
    LETZTE_AKTIVITAET date
);

-- Erstelle Tabelle karteikarten
create table karteikarten
(
    KARTEN_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    VORDERSEITE varchar(100),
    RUECKSEITE varchar(100)
);

-- Erstelle Tabelle sprachen
create table sprachen
(
    SPRACH_ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SPRACH_BEZ varchar(20),
    FEMDSPRACHE boolean,
    MUTTERSPRACHE boolean NOT NULL,
    FK_BENUTZER int, 
    CONSTRAINT FK_BENUTZER_SPRACHE FOREIGN KEY (FK_BENUTZER)
    REFERENCES benutzer(BENUTZER_ID)
);

-- Erstelle Tabelle bibliotheken
create table bibliotheken
(
    EINTRAGS_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TITEL varchar(100) NOT NULL,
    EBENE int(2) NOT NULL,
    POSITION int(2) NOT NULL,
    FK_BENUTZER int NOT NULL,
    CONSTRAINT FK_BENUTZER_BIBLIOTHEK FOREIGN KEY (FK_BENUTZER)
    REFERENCES benutzer(BENUTZER_ID)
);

-- Erstelle Tabelle verbindungen
create table verbindungen
(
    VERBINDUNGS_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FK_KARTE int NOT NULL,
    FK_BIBLIOTHEK int NOT NULL,
    FK_SPRACHE int NOT NULL,
    CONSTRAINT FK_VERB_KARTE FOREIGN KEY (FK_KARTE)
    REFERENCES karteikarten(KARTEN_NR),
    CONSTRAINT FK_VERB_BIBLIOTHEK FOREIGN KEY (FK_BIBLIOTHEK)
    REFERENCES bibliotheken(EINTRAGS_NR),
    CONSTRAINT FK_VERB_SPRACHE FOREIGN KEY (FK_SPRACHE)
    REFERENCES sprachen(SPRACH_ID)
);

-- Erstelle Tabelle lernmodi
create table lernmodi
(
    LERNMODUS_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    THEMA varchar(50) NOT NULL,
    BESCHREIBUNG varchar(200),
    FK_BIBLIOTHEK int,
    CONSTRAINT FK_MODUS_BIBLIOTHEK FOREIGN KEY (FK_BIBLIOTHEK)
    REFERENCES bibliotheken(EINTRAGS_NR)
);

-- Erstelle Tabelle lueckentexte
create table lueckentexte
(
    AUFGABEN_NR int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    LUECKENTEXT text NOT NULL,
    LOESUNG varchar(200) NOT NULL,
    FK_SPRACHE int NOT NULL,
    FK_LERNMODUS int NOT NULL,
    CONSTRAINT FK_SPRACHE_LUE FOREIGN KEY (FK_SPRACHE)
    REFERENCES sprachen(SPRACH_ID),
    CONSTRAINT FK_MODUS_LUE FOREIGN KEY (FK_LERNMODUS)
    REFERENCES lernmodi(LERNMODUS_NR)
);

