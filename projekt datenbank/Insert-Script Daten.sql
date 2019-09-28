-- Insert Script

-- Insert für Tabelle Benutzer
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Angelina','Hofer','angel-sahara@hotmail.com','Angeli','Angi1234Angi');
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Patrick','Tomasi','patrick.tomasi@gmx.ch','Päddy','5678PDXYZ');
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Matthias','Düggelin','nex.nex@gmx.ch','NexNex','159159Nix');


-- Insert für Tabelle Sprachen
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Französisch');
INSERT INTO sprachen(Bezeichnung) 
VALUES ('Englisch');
INSERT INTO sprachen(sBezeichnung) 
VALUES ('Italienisch');


-- Insert für Tabelle Lernmodus
INSERT INTO lernmodus(Titel, Beschreibung) 
VALUES ('Vokabeltraining','');
INSERT INTO lernmodus(Titel, Beschreibung) 
VALUES ('Lückentexte','');


-- Insert für Tabelle Kategorien
INSERT INTO kategorien(Kategorie) 
VALUES ('Vokabeln');
INSERT INTO kategorien(Kategorie) 
VALUES ('Lückentexte');


-- Insert für Tabelle Karteikarten
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Salue',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Ciao',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Hello',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Bonjour',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Bongiorno',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Tag','Good Morning',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','manger',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','eat',3,2);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('essen','mangiare',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Fleisch','la carne',2,3);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Fleisch','la viande',1,1);
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Apfel','apple',3,2);

-- Insert für Tabelle Bibliotheken
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Französisch',2,1,1,1);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Essen',3,2,1,1);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Begrüssung',3,2,1,1);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Lückentexte',3,2,1,2);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Italienisch',2,1,2,1);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('',,,,);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('',,,,);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Englisch',2,,,);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('',,,,);
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('',,,,);

-- Insert für Tabelle Bibliothek_to_Karte
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES ('','');

-- Insert für Tabelle Uebungen
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('','','','','','');

-- Insert für Tabelle Bibliothek_to_Lernmodus
INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
VALUES ('','');

