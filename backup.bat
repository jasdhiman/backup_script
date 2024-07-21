@ECHO OFF
SETLOCAL
:: Set up path for the backup on the ME.
:: This directory doesn't have to exist as it will be created.
:: Where should we copy to?
SET BACKUP_ROOT=\\me.mbgov.ca\users\User3\JDhiman
SET BACKUP_DIRECTORY=Backup
SET BACKUP_PATH=%BACKUP_ROOT%\%BACKUP_DIRECTORY%
:: Where should we copy from?
SET SOURCE_PATH=C:\Users\JDhiman
:: Needed for xcopy
:: Specify the same thing in backup.rcj if using robocopy
SET EXCLUDES=%SOURCE_PATH%\backup_exclude.txt
SET CURRENT_DATE=%DATE:~5,2%-%DATE:~8,2%-%DATE:~0,4%

:: Backup using robocopy
:: This will mirror the entire directory struture.
:: You need to modify SOURCE_PATH\backup.rcj to exclude files.
IF NOT EXIST backup.rcj (ECHO Please create backup.rcj. Nothing was done.
EXIT)
robocopy %SOURCE_PATH% %BACKUP_PATH% /JOB:backup
SET /p INPUT=Press any key

:: or using xcopy -- painfully slow
:: Some permissions issues... also, apparently xcopy was deprecated in 2008 or so.
:: The permission issues are due to trying to copy the symlinks to themselves, so that's fine honestly.
:: If there is no backup, it will backup everything, otherwise it will just backup files younger than last midnight.
:: You can exclude files by adding them to the file pointed to by EXCLUDES.
:: IF EXIST %BACKUP_PATH% (xcopy %SOURCE_PATH% %BACKUP_PATH% /f /E /H /c /i /EXCLUDE:%EXCLUDES% /d:%CURRENT_DATE%) ELSE (xcopy %SOURCE_PATH% %BACKUP_PATH% /f /E /H /c /i /EXCLUDE:%EXCLUDES%)

EXIT
