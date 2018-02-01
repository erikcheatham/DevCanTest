--Incorrect DB Schema (Wasted An Hour Figuring Out Schema)
--RESTORE FILELISTONLY  
--FROM DISK = 'C:\AdventureWorksDW2016.bak'  
--GO  

--RESTORE DATABASE AdventureWorksDW2016  
--FROM DISK = 'c:\AdventureWorksDW2016.bak'  
--WITH MOVE 'AdventureWorksDW2016_Data' TO 'c:\data\AdventureWorksDW2016.mdf',  
--MOVE 'AdventureWorksDW2016_log' TO 'c:\data\AdventureWorksDW2016.ldf'  
--GO


RESTORE FILELISTONLY  
FROM DISK = 'C:\AdventureWorks2016.bak'  
GO  

RESTORE DATABASE AdventureWorks2016  
FROM DISK = 'c:\AdventureWorks2016.bak'  
WITH MOVE 'AdventureWorks2016_Data' TO 'c:\data\AdventureWorks2016.mdf',  
MOVE 'AdventureWorks2016_log' TO 'c:\data\AdventureWorks2016.ldf'
GO