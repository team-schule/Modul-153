-- Abfragen

-- Abfrage um Bibliothek richtig geordnet zu erhalten:
select * from bibliotheken where FK_Benutzer = 1 order by beschreibung, Ebene, Position;




-- Neu Karte erstellen

-- Abfrage für Sprachen DD (bereits vorhanden) bei Neu-Erfassung Karte;
SELECT * FROM `bibliotheken` WHERE FK_Benutzer = 1 and Ebene = 2;

-- Untermenues anhand PK von Sprach-Auswahl
SELECT * FROM `bibliotheken` WHERE FK_Bibliothek = 2;

-- Insert Karte
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Hallo','Salue',1,1);

-- Sprache_ID holen aus Tab Sprache... für Insert Karte
SELECT Sprachen_ID FROM Sprachen 
inner join bibliotheken on Titel.bibliotheken = Bezeichnung.Sprachen;