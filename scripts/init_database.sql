/*
=============================================================
Create Databases
=============================================================
Script Purpose:
    This script creates new databases named 'bronze', 'silver', and 'gold' after checking if they already exist. 
    If the databases exist, they are dropped and recreated. 
	
WARNING:
    Running this script will drop the entire 'bronze', 'silver', and 'gold' databases if they exist. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


-- Drop Databases if they already exist
DROP database if exists bronze;
DROP database if exists silver;
DROP database if exists gold;


-- Create new databases
CREATE database bronze;
CREATE database silver;
CREATE database gold;
