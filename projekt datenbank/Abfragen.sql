-- Abfragen

-- Abfrage um Bibliothek richtig geordnet zu erhalten:
select * from bibliotheken where FK_Benutzer = 1 order by beschreibung, Ebene, Position;