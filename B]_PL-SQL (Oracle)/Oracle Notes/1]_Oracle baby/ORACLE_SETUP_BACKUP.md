# Remove Oracle database [Link](https://youtube.com/playlist?list=PLL_LQvNX4xKzN_nhJWT8pPzOwSjKFd_uD&si=_elkgkkl5OHOMHYL)
- remove the home pathe from the environment variable system path's 'C:\app\user\product\12.2.0\dbhome_1\bin'

### Deleting all the records from the registry
- win + r 'regedit' -> HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\ -> remove the home path && 
- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ -> DELETE FOLDER'S name start with 'Oracle'

### Delete oracle home users and groupes
- win + r 'lusrmgr.msc' -> Users -> remove the user 'Oracle_HomeUser' &&





# How to find out the SID and DB Home
- open registory editor win + r 'regedit' -> HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\ -> ORACLE_HOME_NAME