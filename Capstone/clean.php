<?php
	/*
	File: clean.php
	Short: Rebuilds the database.
	Long: Drops the existing database and rebuilds it.
	*/
	
	include_once 'debug.php';
	include_once 'error.php';
	
	// Gain access to the database
	include_once 'loginCapstone.php';
	
	// Drop the database
	$statement = "DROP DATABASE IF EXISTS Capstone;";
	// Recreate it
	$statement .= "CREATE DATABASE IF NOT EXISTS Capstone DEFAULT CHARACTER SET utf8;";
	// Enter the new database
	$statement .= "USE Capstone;";
	// Create all the tables
	$statement .= "
CREATE TABLE CustData ( 
rowid          int             NOT NULL AUTO_INCREMENT, 
custid         binary(16)      UNIQUE NOT NULL, 
fname          varchar(255)    NOT NULL, 
lname          varchar(255)    NOT NULL, 
address        varchar(255)    NOT NULL, 
address2       varchar(255), 
city           varchar(255)    NOT NULL, 
state          char(2)         NOT NULL, 
country        char(3)         NOT NULL DEFAULT 'USA', 
zip            char(5)         NOT NULL, 
phone          char(10)        NOT NULL, 
email          varchar(255), 
KEY (rowid), 
PRIMARY KEY (custid) 
); 
 
CREATE TABLE BikeData ( 
rowid          int           NOT NULL AUTO_INCREMENT, 
bikeid         binary(16)    UNIQUE NOT NULL, 
custid         binary(16)    NOT NULL, 
brand          varchar(255)  NOT NULL, 
model          varchar(255)  NOT NULL, 
color          varchar(255)  NOT NULL, 
KEY (rowid), 
PRIMARY KEY (bikeid), 
KEY (custid) 
); 
 
CREATE TABLE BikeNoteData ( 
bikeid         binary(16)      NOT NULL, 
notes          text, 
KEY (bikeid) 
); 
 
CREATE TABLE BikeIMGData ( 
bikeid         binary(16)      NOT NULL, 
image          blob, 
KEY (bikeid) 
); 
 
CREATE TABLE WorkOrderData ( 
rowid          int             NOT NULL AUTO_INCREMENT, 
workid         binary(16)      UNIQUE NOT NULL, 
custid         binary(16)      NOT NULL, 
bikeid         binary(16)      NOT NULL, 
open           enum('Y','N')   DEFAULT 'Y', 
tagid          tinyint         DEFAULT '0', 
createtime     timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP, 
KEY (rowid), 
PRIMARY KEY (workid), 
KEY (custid), 
KEY (bikeid) 
); 
 
CREATE TABLE WorkOrderNotes ( 
workid         binary(16)      NOT NULL, 
pre            text            DEFAULT '', 
post           text            DEFAULT '', 
KEY (workid) 
); 

CREATE TABLE WorkOrderXTune ( 
workid         binary(16)      NOT NULL, 
tune           int             NOT NULL, 
KEY (workid), 
KEY (tune) 
); 
 
CREATE TABLE TuneData ( 
tune           int             UNIQUE NOT NULL, 
name           varchar(255)    UNIQUE NOT NULL, 
cost           float           NOT NULL DEFAULT '0.00', 
time           float           NOT NULL DEFAULT '1.00', 
descrip        text            DEFAULT '', 
sku            varchar(3), 
PRIMARY KEY (tune) 
);
";

	// Insert some default rows
	$statement .= "USE Capstone;
INSERT INTO CustData (custid, fname, lname, address, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')),'Jill','White','4321 S Main St.','Spokane','WA','54321','5091179888','whitej@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Jack', 'Black', '1234 N Main St.', 'Spokane', 'WA', '12345', '5098889711', 'blackj@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Jerry','Tree','1234 W Jolt St','Rm 204','Spokane','WA','99206','5098876789','jerry@gpta.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Dummer','Sir','45678 S Herald St','PO box 12','Spokane','WA','76554','8907897897','hector@goat.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Johnny','Lang','1234 N Haulk St','Apt 344','Spokane','WA','99765','5098768989','lang@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'hector','zeroni','1234 goat st','po box 45','spokane','WA','99876','8096979799','zeroni@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Frank','Bonehead','4567 N Main St','PO BOX 3','Spokane','WA','99257','5098765678','FrankB@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Tom','Goat','1234 N Goat St','Apt 3','Spokane','WA','99878','5098889898','tomgoat@hotmail.com');

INSERT INTO CustData (custid, fname, lname, address, address2, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'John','Ragan','4567 N Hall St','Apt 45','Spokane','WA','99878','5099992222','raganj@hotmail.com');

INSERT INTO CustData (custid, fname, lname, address, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Cody','Valle','5212 N Wall St.','Spokane','WA','99204','5097203118','codyvalle90@gmail.com');

INSERT INTO CustData (custid, fname, lname, address, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Adam','Cross','Gonzaga Campus Somewhere','Spokane','WA','99523','306456123','across2@zagmail.gonzaga.edu');

INSERT INTO CustData (custid, fname, lname, address, city, state, zip, phone, email)
VALUES (UNHEX(REPLACE(UUID(),'-','')), 'Merrill','Lines','Somewhere in Spokane','Spokane','WA','99215','509789654','lines@zagmail');
";
	
	// Send the queries and test for success
	$result = $GLOBALS['con']->multi_query($statement);
	if ($GLOBALS['DEBUG'])
	{
		if ($result)
			print("Successfully dropped and recreated the database." . PHP_EOL);
		else
		{
			print("Error dropping and recreating the database." . PHP_EOL);
			$GLOBALS['ERROR']->reportErrorCode("CLEAN");
		}
	}
	
	if ($GLOBALS['con']) 
	{
		if ($GLOBALS['DEBUG']) print("Closing mysql connection." . PHP_EOL);
		$GLOBALS['con']->close();
		$GLOBALS['con'] = false;
	}
?>