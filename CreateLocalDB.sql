RESTORE FILELISTONLY  
FROM DISK = 'C:\AdventureWorksDW2016.bak'  
GO  

RESTORE DATABASE AdventureWorksDW2016  
FROM DISK = 'c:\AdventureWorksDW2016.bak'  
WITH MOVE 'AdventureWorksDW2016_Data' TO 'c:\data\AdventureWorksDW2016.mdf',  
MOVE 'AdventureWorksDW2016_log' TO 'c:\data\AdventureWorksDW2016.ldf'  
GO
