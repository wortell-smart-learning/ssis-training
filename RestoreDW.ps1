cd c:\repos\ssis-training\backups

git checkout d45783~ ./AdventureWorksDW2016_empty.bak

(sqlcmd -S . -Q "ALTER DATABASE [AdventureworksDW2016_empty] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [AdventureworksDW2016_empty] FROM  DISK = N'C:\Repos\ssis-training\backups\AdventureWorksDW2016_empty.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [AdventureworksDW2016_empty] SET MULTI_USER")