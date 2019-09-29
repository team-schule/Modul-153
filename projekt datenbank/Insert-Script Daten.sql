-- Insert Script
use fremdsprachen;

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
INSERT INTO sprachen(Bezeichnung) 
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


-- Insert für Tabelle Karteikarten ------------------------------------------
-- Benutzer 1, Sprache Französisch 
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Salue',1,1);
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
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Bibliothek','Bibliothek',1,1,1,1);
-- Sprache Französisch
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Französisch','Französisch',2,1,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Essen','Französisch',3,2,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Begrüssung','Französisch',3,2,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Lückentexte','Französisch',3,2,1,2);
-- und Italienisch
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Italienisch','Italienisch',2,2,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Wetter','Italienisch',3,1,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Körper','Italienisch',3,2,1,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Lückentexte','Italienisch',3,3,1,2);

-- Bibliothek Benutzer 2
-- Überschrift Bibliothek
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Bibliothek','Bibliothek',1,1,2,1);
-- Sprache Italienisch
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Italienisch','Italienisch',2,2,2,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Essen','Italienisch',3,1,2,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Begrüssung','Italienisch',3,2,2,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Lückentexte','Italienisch',3,3,2,2);

-- Bibliothek Benutzer 3
-- Überschrift Bibliothek
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Bibliothek','Bibliothek',1,1,3,1);
-- Sprache Englisch
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Englisch','Englisch',2,2,3,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Essen','Englisch',3,1,3,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Begrüssung','Englisch',3,2,3,1);
INSERT INTO bibliotheken(Titel, Beschreibung, Ebene, Position, FK_Benutzer, FK_Lernmodus) 
VALUES ('Lückentexte','Englisch',3,3,3,2);

-- Insert für Tabelle Bibliothek_to_Karte
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (1,4);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (2,4);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (3,3);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (4,3);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (5,7);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (7,7);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (6,8);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (8,8);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (9,13);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (10,13);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (11,12);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (12,12);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (15,17);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (16,17);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (13,18);
INSERT INTO bibliothek_to_karte(FK_Karte, FK_Bibliothek) 
VALUES (14,18);


-- Insert für Tabelle Uebungen
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... signor Ferrari. ... Stella. Am Abend: ...','Buongiorno,Ciao,Buonasera',3,2,2);
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... monsieur Ferrari. ... Stella. Am Abend: ...','Bonjour,Salue,bon soir',1,2,2);
INSERT INTO uebungen(Titel, Aufgabe, Loesung, FK_Sprache, FK_Lernmodus, FK_Kategorie) 
VALUES ('Begrüssung','Setze die richtige Begrüssung am richtigen Ort ein: ... Mister Ferrari. ... Stella. Am Abend: ...','Good Morning,hi,Good Evening',2,2,2);

-- Insert für Tabelle Bibliothek_to_Lernmodus
-- INSERT INTO bibliothek_to_lernmodus(FK_Bibliothek, FK_Lernmodus) 
-- VALUES (,);

