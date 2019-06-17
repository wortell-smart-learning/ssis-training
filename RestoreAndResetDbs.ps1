cd "C:\Repos\ssis-training"
git checkout -- .
git pull

(sqlcmd -S . -Q "ALTER DATABASE [AdventureworksDW2016_empty] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [AdventureworksDW2016_empty] FROM  DISK = N'C:\Repos\ssis-training\backups\AdventureWorksDW2016_empty.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [AdventureworksDW2016_empty] SET MULTI_USER")
(sqlcmd -S . -Q "ALTER DATABASE [Adventureworks2016] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE [Adventureworks2016] FROM  DISK = N'C:\Repos\ssis-training\backups\AdventureWorks2016.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5;
ALTER DATABASE [Adventureworks2016] SET MULTI_USER;")
