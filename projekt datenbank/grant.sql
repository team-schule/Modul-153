-- aktuellen user abfragen
select current_user;

-- neuen user creiieren
create user 'dummy2'@'localhost' identified by 'dummy2';
grrant select on fremdsprachen.benutzer to 'dummy2';
flush privileges;

GRANT USAGE ON *.* TO 'dummy1'@'%' 
IDENTIFIED BY PASSWORD '*829733B795276530EC8B9B3ACE16F3F3B3DDBC17';

GRANT SELECT ON `fremdsprachen`.`benutzer` TO 'dummy2'@'localhost';
