-- Trigger AFTER_INSERT_BENUTZER
-- Erstellt bei neuem Eintrag in der Tabelle benutzer 
-- einen Eintrag Bibliothek in der Tabelle bibliotheken
CREATE TRIGGER `AFTER_INSERT_BENUTZER` AFTER INSERT ON `benutzer` 
FOR EACH ROW 
INSERT INTO bibliotheken(Titel, Ebene, Position, FK_Benutzer) 
VALUES ('Bibliothek',1,1,new.Benutzer_ID);

