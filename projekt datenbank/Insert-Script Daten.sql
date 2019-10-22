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
-- INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
-- VALUES ('Bibliothek','Bibliothek',1,1,1); -- 1
-- Sprache Französisch
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Französisch',2,1,1,1,2); -- 2
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Essen',3,1,1,4,2); -- 3
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Begrüssung',3,2,1,4,2); -- 4
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer, FK_Bibliothek, FK_Sprache) 
VALUES ('Lückentexte',3,3,1,4,2); -- 5
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

