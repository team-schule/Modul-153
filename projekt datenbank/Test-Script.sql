-- ================================================================================================
-- Test-Script:
-- Dieses Skript beinhaltet Test zu allen Datenbank-Objekten, welche erstellt wurden
-- und zu den Use-Cases, welche zur Datenbank-Erstellung wichtig waren, sowie die 
-- erwarteten Ergebnisse dazu.

-- Wichtig zu beachten:
-- Die Reihen folge der Tests muss eingehalten werden, damit die Ergebnisse zu
-- erhalten, welche zu jedem Test angegeben sind
-- ================================================================================================

-- ================================================================================================
-- Hier ein Delete-Statement für die ganze Datenbank und die Benutzer, falls benötigt
DROP DATABASE IF EXISTS fremdsprachen;
DROP USER adminfremdsprachen@localhost;
DROP USER lernende@localhost;

-- ================================================================================================

-- ================================================================================================
-- Prüfung des UNIQUE-Feldes 'Benutzername': 
-- Use-Case: Ein Benutzer gibt einen Benutzernamen ein, welcher schon vergeben ist
-- ----------------------------------------------------------------------------------
-- Angabe einer ungültigen E-Mail beim Registrieren
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Angelo','Schmid','Angi.schmid@schmidIT.ch','Angeli',SHA2('AngiiSCHMID777',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Ausgabe der Fehlermeldung 
-- -> Duplicate entry 'Angeli' for key 'Benutzername' und Datensatz wird nicht erstellt  
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Use-Case: Der Benutzer wählt einen Benutzernamen, welcher noch nicht existiert
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Angelo','Schmid','Angi.schmid@schmidIT.ch','Angelo',SHA2('AngiiSCHMID777',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Der Benutzer wird erstellt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage um Eintrag des Benutzers zu prüfen
SELECT * FROM Benutzer WHERE Benutzername = 'Angelo';
-- ================================================================================================

-- ================================================================================================
-- Prüfung des UNIQUE-Feldes 'Email': 
-- Use-Case: Der Benutzer kann sich über E-Mail oder Benutzernamen identifizieren,
-- daher darf auch die E-Mail-Adresse nur einmal in der Tabelle vorkommen
-- ----------------------------------------------------------------------------------
-- Angabe einer ungültigen E-Mail beim Registrieren
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Angelo','Schmid','Angi.schmid@schmidIT.ch','AngeloSupermann',SHA2('AngiSuperman',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Ausgabe der Fehlermeldung 
-- -> Duplicate entry 'Angi.schmid@schmidIT.ch' for key 'Email' 
--    und Datensatz wird nicht erstellt  
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Use-Case: Der Benutzer wählt einen Benutzernamen, welcher noch nicht existiert
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Angelo','Schmid','angelo.schmid@itservice.ch','AngeloSupermann',SHA2('AngiSuperman',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Der Benutzer wird erstellt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage um Eintrag des Benutzers zu prüfen
SELECT * FROM Benutzer WHERE Email = 'angelo.schmid@itservice.ch';
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Constraint 'CHECK_ANREDE': 
-- Use-Case: Von der Datenbank her ist es gegeben, dass man in der Spalte Anrede nur zwischen 
-- den Einträgen 'Mann' oder 'HERR' und 'Frau' oder 'FRAU' wählen kann
-- Das Feld darf nicht leer sein und nicht etwas anderes enthalten 
-- ----------------------------------------------------------------------------------
-- Angabe einer leeren Anrede beim Registrieren
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('','Giorgio','Sorio','giorgio.sorio@abf.ch','Sorio',SHA2('ABFGoirgioSorio',256));
-- Angabe einer falschen Anrede
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Familie','Giorgio','Sorio','giorgio.sorio@abf.ch','Sorio',SHA2('ABFGoirgioSorio',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis in beiden Fällen:
-- Ausgabe der Fehlermeldung 
-- -> Constraint 'CHECK_ANREDE' failed for fremdsprachen.benutzer 
--    und Datensatz wird nicht erstellt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Use-Case: Die E-Mail Adresse wird korrigiert und stimmt nun mit den Anforderungen 
-- in der Datenbank überein
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Herr','Giorgio','Sorio','giorgio.sorio@abf.ch','Sorio',SHA2('ABFGoirgioSorio',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Der Benutzer wird erstellt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage um Eintrag des Benutzers zu prüfen
SELECT * FROM Benutzer WHERE Benutzername = 'Sorio';
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Constraint 'CHECK_EMAIL': 
-- Use-Case: Der Benutzer gibt eine E-Mail-Adresse an, welche nicht dem folgenden
-- Format entspricht 
-- minimum 3 Stellen + @ + minimum 3 Stellen + . + minimum 2 Stellen
-- ----------------------------------------------------------------------------------
-- Angabe einer ungültigen E-Mail beim Registrieren
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Samantha','Hofer','sam@sh.ch','Sam',SHA2('SamOnEarth',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Ausgabe der Fehlermeldung 
-- -> Constraint 'CHECK_EMAIL' failed for fremdsprachen.benutzer 
--    und Datensatz wird nicht erstellt  
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Use-Case: Die E-Mail Adresse wird korrigiert und stimmt nun mit den Anforderungen 
-- in der Datenbank überein
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Samantha','Hofer','samhofer@sami.ch','Sam',SHA2('SamOnEarth',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Der Benutzer wird erstellt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage um Eintrag des Benutzers zu prüfen
SELECT * FROM Benutzer WHERE Benutzername = 'Sam';
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Triggers AFTER_INSERT_BENUTZER: 
-- Use-Case: Nach der Registrierung eines neuen Benutzers soll automatisch eine 
-- neue Bibliothek eröffnet werden, welche dem neuen Benutzer zugeordnet ist.
-- ----------------------------------------------------------------------------------
-- Folgenden Benutzer erstellen
INSERT INTO benutzer(Anrede, Vorname, Nachname, Email, Benutzername, Passwort) 
VALUES ('Frau','Laura','Albisser','laura.Albisser@abf.ch','LauraKatze',SHA2('LALA555ALAL',256));
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwarteter Eintrag in der Bibliothek:
-- Titel = 'Bibliothek', Ebene = 1, Position = 1, FK_Benutzer = 5, FK_Bibliothek is null,
-- FK_Sprache is null
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage zur Überprüfung (Zur Identifikation Benutzername genommen, da der Benutzer
-- über diesen eiindeutig identifizierbar ist):
SELECT * FROM Bibliotheken 
WHERE FK_Benutzer in (
    SELECT Benutzer_ID FROM Benutzer 
    WHERE Benutzername = 'LauraKatze');
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Triggers AFTER_INSERT_KARTEIKARTEN: 
-- Use-Case: Nach der Erfassung einer neuen Karteikarte soll das Feld 'Letzte_Aenderung' 
-- in der Tabelle 'Benutzer' auf den aktuellen Timestamp gesetzt werden
-- ----------------------------------------------------------------------------------
-- Folgenden Benutzer erstellen
INSERT INTO karteikarten(Vorderseite, Rueckseite, FK_Benutzer, FK_Sprache)
VALUES ('Guten Appetit','Bon Appetit',1,1);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartete Ergebnisse:
-- Karte muss vorhanden sein
-- Erwarteter Eintrag im Feld 'Letzte_Aenderung' des Benutzers:
-- Es muss das Datum und die Zeit der Änderung drin stehen
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage zur Überprüfung, ob Karte vorhanden 
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Abfrage zur Überprüfung Feld Letzte_Aenderung
SELECT Letzte_Aenderung FROM Benutzer where Benutzer_ID = 1;
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Triggers AFTER_INSERT_KARTEIKARTEN: 
-- Use-Case: Nach der Erfassung einer neuen Karteikarte soll das Feld 'Letzte_Aenderung' 
-- in der Tabelle 'Benutzer' auf den aktuellen Timestamp gesetzt werden
-- ----------------------------------------------------------------------------------
-- Karte welche angepsst werden soll heraussuchen
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Halloo' and FK_BENUTZER = 1 and FK_Sprache = 1;
-- Karte anpassen (updaten)
UPDATE karteikarten SET Vorderseite = 'Hallo' where Vorderseite = 'Halloo' and FK_BENUTZER = 1 and FK_Sprache = 1;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwarteter Eintrag im Feld 'Letzte_Aenderung' des Benutzers:
-- Es muss das Datum und die Zeit der Änderung drin stehen
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Überprüfung, ob Karte angepasst
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Hallo' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Abfrage zur Überprüfung Feld Letzte_Aenderung
SELECT Letzte_Aenderung FROM Benutzer where Benutzer_ID = 1;
-- ================================================================================================

-- ================================================================================================
-- Prüfung des Triggers AFTER_INSERT_KARTEIKARTEN: 
-- Use-Case: Nach der Erfassung einer neuen Karteikarte soll das Feld 'Letzte_Aenderung' 
-- in der Tabelle 'Benutzer' auf den aktuellen Timestamp gesetzt werden
-- ----------------------------------------------------------------------------------
-- Karte welche angepsst werden soll heraussuchen
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Karte anpassen (updaten)
DELETE FROM karteikarten WHERE Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartete Ergebnisse:
-- Karte darf nicht mehr vorhanden sein
-- Erwarteter Eintrag im Feld 'Letzte_Aenderung' des Benutzers:
-- Es muss das Datum und die Zeit der Änderung drin stehen
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage zur Überprüfung, ob Karte gelöscht (die Abfrage liefert eine leere Zeile zurück):
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Abfrage zur Überprüfung Feld Letzte_Aenderung
SELECT Letzte_Aenderung FROM Benutzer where Benutzer_ID = 1;
-- ================================================================================================



-- ================================================================================================
-- Prüfung des Triggers AFTER_UPDATE_BIBLIOTHEKEN: 
-- Use-Case: Nach der Erfassung einer neuen Karteikarte soll das Feld 'Letzte_Aenderung' 
-- in der Tabelle 'Benutzer' auf den aktuellen Timestamp gesetzt werden
-- ----------------------------------------------------------------------------------
-- Karte welche angepsst werden soll heraussuchen
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Karte anpassen (updaten)
DELETE FROM karteikarten WHERE Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartete Ergebnisse:
-- Karte darf nicht mehr vorhanden sein
-- Erwarteter Eintrag im Feld 'Letzte_Aenderung' des Benutzers:
-- Es muss das Datum und die Zeit der Änderung drin stehen
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfrage zur Überprüfung, ob Karte gelöscht (die Abfrage liefert eine leere Zeile zurück):
SELECT KARTEN_NR, VORDERSEITE, RUECKSEITE FROM Karteikarten 
where Vorderseite = 'Guten Appetit' and FK_BENUTZER = 1 and FK_Sprache = 1;

-- Abfrage zur Überprüfung Feld Letzte_Aenderung
SELECT Letzte_Aenderung FROM Benutzer where Benutzer_ID = 1;
-- ================================================================================================

-- ================================================================================================
-- Prüfung der View V_KARTEN_PRO_SPRACHE: 
-- Use-Case: Der Benutzer (Benutzer_ID = 1) möchte alle Französisch-Karten üben, welche in seiner 
-- Bibliothek gespeichert sind
-- Dafür wurde eine View erstellt
-- ------------------------------------------------------------------------------------------------
-- Entsprechende Abfrage
SELECT * FROM V_KARTEN_PRO_SPRACHE;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Erwartetes Ergebnis:
-- Es werden 4 Karten angezeigt alle zur Sprache Französisch
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- ================================================================================================

-- ================================================================================================
-- Prüfung der View V_KARTEN_PRO_MENUE: 
-- Use-Case: Der Benutzer (Benutzer_ID = 1) möchte alle Französisch-Karten üben, welche in seiner 
-- Bibliothek gespeichert sind
-- Dafür wurde eine View erstellt
-- ------------------------------------------------------------------------------------------------
-- Entsprechende Abfrage
SELECT * FROM V_KARTEN_PRO_MENUE;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Es werden 2 Karten angezeigt, beide der Sprache Französisch und 
-- beide haben mit dem Thema Essen zu tun
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- ================================================================================================


-- ================================================================================================
-- Prüfung der Views V_LT_ENGLISCH / V_LT_FRANZOESISCH / V_LT_ITALIENISCH: 
-- Use-Case: Die Lückentexte werden jeweils pro Sprache benötigt, daher gibt es für die bei uns 
-- besetzten Sprachen jeweils eine View um die Lückentexte zu holen
-- ------------------------------------------------------------------------------------------------
-- Abfrage für die Aufgaben der englischen Lückentexte
SELECT * FROM V_LT_ENGLISCH;
-- Abfrage für die Aufgaben der französischen Lückentexte
SELECT * FROM V_LT_FRANZOESISCH;
-- Abfrage für die Aufgaben der italienischen Lückentexte
SELECT * FROM V_LT_ITALIENISCH;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis (Bei allen 3 Views 1 Datensatz eingetragen):
-- Anzeige der Aufgabe und der Lösung ... Die Lösung ist in der jeweiligen Sprache geschrieben
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- ================================================================================================


-- ================================================================================================
-- Prüfung on delete CASCADE beim Fall Benutzer löschen: 
-- Use-Case: Ein Benutzer löscht seinen Account... 
-- -> Seine Bibliothek und alle seine Karten sollen automatisch gelöscht werden
-- ------------------------------------------------------------------------------------------------
-- Prüfen der vorhandenen Daten
SELECT * FROM Benutzer WHERE Benutzer_ID = 3;
SELECT * FROM Bibliotheken WHERE FK_Benutzer = 3;
SELECT * FROM Karteikarten WHERE FK_Benutzer = 3;
-- ------------------------------------------------------------------------------------------------
-- Delete-Statement für Benutzer mit Benutzer_ID = 3 (Matthias Düggelin)
DELETE FROM Benutzer WHERE Benutzer_ID = 3;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Alle Einträge sind gelöscht
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfragen zur Überprüfung
SELECT * FROM Benutzer WHERE Benutzer_ID = 3;
SELECT * FROM Bibliotheken WHERE FK_Benutzer = 3;
SELECT * FROM Karteikarten WHERE FK_Benutzer = 3;
-- ================================================================================================

-- ================================================================================================
-- Prüfung on delete CASCADE beim Fall Löschen eines Bibliothek-Eintrages: 
-- Use-Case: Ein Benutzer löscht einen Eintrag in der Bibliothek... 
-- -> Der Eintrag in der Bibliothek und alle  Karten darin sollen automatisch gelöscht werden
-- ------------------------------------------------------------------------------------------------
-- Prüfen der vorhandenen Daten
SELECT * FROM Bibliotheken WHERE Titel = 'Essen' and FK_Benutzer = 2 and FK_Sprache = 3;
SELECT * FROM Karteikarten WHERE Karten_NR in 
    (SELECT FK_Karte FROM Bibliothek_to_Karte where FK_Bibliothek in 
        (SELECT Eintrags_NR FROM Bibliotheken WHERE Titel = 'Essen' and FK_Benutzer = 2 and FK_Sprache = 3));
-- ------------------------------------------------------------------------------------------------
-- Delete-Statement für Menü-Punkt 'Essen' (Benutzer_ID = 2 und Sprache = Italienisch)
DELETE FROM Bibliotheken WHERE Titel = 'Essen' and FK_Benutzer = 2 and FK_Sprache = 3;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Erwartetes Ergebnis:
-- Eintrag ESSEN unter dem Menu ITALIENISCH ist gelöscht, sowie alle Karten dazu
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Abfragen zur Überprüfung
SELECT * FROM Bibliotheken WHERE FK_Benutzer = 2;
SELECT * FROM Bibliotheken WHERE Titel = 'Essen' and FK_Benutzer = 2 and FK_Sprache = 3;
SELECT * FROM Karteikarten WHERE Karten_NR in 
    (SELECT FK_Karte FROM Bibliothek_to_Karte where FK_Bibliothek in 
        (SELECT Eintrags_NR FROM Bibliotheken WHERE Titel = 'Essen' and FK_Benutzer = 2 and FK_Sprache = 3));
-- ================================================================================================


-- ================================================================================================
-- Prüfung der Grants beim Einloggen auf der Datenbank als lernende@localhost
-- Man muss dafür auf der Datenbank eine Verbindung erstellen mit den Daten
-- Benutzername = lernende , Passwort = fremdsprachen
-- ================================================================================================
-- Use-Case: Nach dem Einloggen dürfen nur folgende Tabellen der Datenbank ersichtlich sein,
-- da er nur auf diese Zugriff hat:
--      -> Benutzer
--      -> Bibliotheken
--      -> Karteikarten
-- ------------------------------------------------------------------------------------------------
-- Use-Case: Der Benutzer darf auf den oben beschriebenen Tabellen SELECTs ausführen
-- Um die Anzeige auf der Webseite aller Felder zu ermöglichen beinhaltet das SELECT-RECHT 
-- auch alle Spalten der Tabellen
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- Benötigte Abfragen für die Selects
SELECT * FROM Benutzer;
SELECT * FROM Bibliotheken;
SELECT * FROM Karteikarten;
-- Erwartetes Ergebnis bei allen Tabellen werden alle Spalten angezeigt 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -