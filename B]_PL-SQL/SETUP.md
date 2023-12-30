# 📐 Setting Up PL/SQL on Linux Ubuntu/WSL

## 0. Basic Requirements
- 🔁[`sudo apt update && sudo apt upgrade`] 
- update java[`sudo apt install openjdk-11-jdk`]
<!-- -  [`sudo apt install sqldeveloper`] if non WSL else download from [here](https://www.oracle.com/tools/downloads/sqldev-downloads.html) -optional(can use VSCode extension) -->

<details>
<summary>
  Oracle SQL Developer(Tool installation) -optional [can use VSCode extension + Oracle Express Edition(wsl)]
  
> #### PL/SQL Configuration
> - Oracle SQL Developer **comes with PL/SQL support** 😋. You can create and run PL/SQL scripts directly within the tool.

</summary>

### Install Oracle SQL Developer on **🐧 Ubuntu**

#### 1. Download Oracle SQL Developer
- Go to the [Oracle SQL Developer download page](https://www.oracle.com/tools/downloads/sqldev-downloads.html) and download the Linux RPM file.

#### 2. Extract the downloaded file to a folder of your choice. 

<!-- -- unzip sqldeveloper-*-no-jre.zip (for any version) -->
> - if you don't have unzip installed, install it using the following command:
>   ```bash
>   sudo apt-get install unzip
>   ```
- Once the download is complete, extract the archive to a location of your choice.
  ```bash
  -- unzip sqldeveloper-*-no-jre.zip (for any version)
  unzip sqldeveloper-20.4.1.407.0006-no-jre.zip 
  ```

#### 3. Install Required Packages
- Oracle SQL Developer requires some additional packages. Install them using the following commands:
  ```bash
    sudo apt-get install libc6-i386 lib32ncurses5 lib32z1 lib32stdc++6
  ``` 
#### 4. Run Oracle SQL Developer
- Navigate to the `sqldeveloper` folder and run the `sqldeveloper.sh` script.
  ```bash
  cd sqldeveloper
  ./sqldeveloper.sh
  ```
- The first time you run Oracle SQL Developer, it will prompt you to locate the Java executable. Provide the path to your JDK installation.
#### 5. Configure Oracle Database Connection
- Open Oracle SQL Developer.
- Click on "View" in the menu and select "Connections" to open the Connections tab.
- Right-click on "Connections" and choose "New Connection."
- Enter the connection details such as Connection Name, Username, Password, and SID/Service Name.

> **Note:** If you followed the steps then no need to install Oracle Express Edition(wsl) as it comes with Oracle SQL Developer.


<br>

### 🪟 Windows Subsystem for Linux (WSL)
- Download the [Linux RPM](https://www.oracle.com/tools/downloads/sqldev-downloads.html)
- make sure to move the downloaded file to the WSL filesystem
- Install the RPM package using the following command:
  ```bash
  sudo rpm -i sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm
  ```
- Navigate to the sqldeveloper folder and run the sqldeveloper.sh script.
- ```bash
  cd sqldeveloper
  ./sqldeveloper.sh
  ```
> If you want to create a desktop shortcut, right-click on the sqldeveloper.sh script and select Create Shortcut. You can then copy the shortcut to your desktop.

</details>

To set up PL/SQL on Linux Ubuntu, you'll need to install Oracle Database Express Edition (Oracle XE), which includes the Oracle SQL*Plus and PL/SQL components. Here are the general steps to set up PL/SQL on Linux Ubuntu:

## 1. Install Required Packages
- Oracle Database Express Edition requires some additional packages. Install them using the following commands:
  ```bash
  sudo apt-get install alien libaio1 unixodbc
  ```
## 2. Download or Install Oracle Database Express Edition (Oracle XE):
### A. Download
Go to the Oracle website and download the Oracle Database Express Edition for Linux. Make sure to accept the license agreement.
- [`Oracle Database Express Edition 21c Express Edition for Linux x64`](https://www.oracle.com/database/technologies/xe-downloads.html)
- Extract the downloaded file to a folder of your choice.
  ```bash
  unzip oracle-database-xe-*.rpm.zip
  ```
### B. Install
- Install the RPM package using the following command:
  ```bash
  sudo alien --scripts -d oracle-database-xe-*.rpm
  ```
- Install the Oracle Database Express Edition using the following command:
  ```bash
  sudo dpkg --install oracle-database-xe-*.deb
  ```
## 3. Configure Oracle Database Express Edition using the following command:
  ```bash
  sudo /etc/init.d/oracle-xe-21c configure
  ```
- The configuration script will prompt you to set a password for the SYS and SYSTEM users. Make sure to remember the password you set for these users.
- The configuration script will also prompt you to set the HTTP port for Oracle Application Express (APEX). The default port is 8080(or any other if already port is occupied).
## 4. Start the Oracle Database Express Edition using the following command:
  ```bash
  sudo service oracle-xe-21c start
  ```
## 5. Add the following lines to the end of the /etc/bash.bashrc file:
  ```bash
  export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
  export ORACLE_SID=XE
  export PATH=$ORACLE_HOME/bin:$PATH
  ```
## 6. Load the new environment variables using the following command:
  ```bash
  source /etc/bash.bashrc
  ```
## 7. More Configuration
- Connect to the Oracle Database Express Edition using the following command:
  ```bash
  sqlplus sys as sysdba
  ```
- Enter the password you set for the SYS user when you configured the Oracle Database Express Edition.
- Run the following command to unlock the HR user:
  ```bash
  ALTER USER hr ACCOUNT UNLOCK;
  ```
- Run the following command to change the password for the HR user:
  ```bash
  ALTER USER hr IDENTIFIED BY hr;
  ```
- Connect to the Oracle Database Express Edition using the following command:
  ```bash
  sqlplus hr/hr
  ```
- Stop the Oracle Database Express Edition using the following command:
  ```bash
  sudo service oracle-xe-21c stop
  ```
- Run the following command to exit SQL*Plus:
  ```bash
  exit
  ```

<!-- Oracle Database software installation process for windows -->
# Install Oracle Database software on Windows
1. Download Oracle Database software
1. Go to the [Oracle Database download page](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html) and download the Oracle Database 21c Express Edition for Windows.
   - ![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/feb718a3-66bd-4994-9592-e3c494e50554)
2. Extract the downloaded file to a folder of your choice.
3. Go to the database folder and run the setup.exe file.
   - **Path:** Extracted file `OracleXE213_Win64`
   - ![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/1805f3cd-5c0e-4435-8837-c6a3adc753b3)
4. The Oracle Database Installer will start. Click on the "Set Up Software Only" option and click Next.
   - ![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/5a8d401b-46ac-4221-9ac7-be9dda05d1f2)
   - > This Installation will take some time. So, be patient.
5. Select the "Single Instance Database Installation" option and click Next.
6. [Getting Started](https://www.oracle.com/database/technologies/appdev/xe/quickstart.html)
---

### 🎗️ My References
> My Reminders for setting up PL/SQL on Linux Ubuntu/WSL
>

### Oracle Database software:
```bash
name: system
password: 321654
```
- *Info to save:*
  ```bash
  Multitenant container database: localhost:1521
  Pluggable database: localhost:1521/XEPDB1
  EM Express: https://localhost:5500/em
  ```
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/8896acd3-b980-40aa-b05e-7f4612383941)
<!-- save this link https://localhost:5500/em/shell as Database Home for future opens-->
> #### Oracle Enterprise Manager Database Express: [Database Home](https://localhost:5500/em/shell)

### Oracle SQL Developer:
```bash
cd C:\Users\admin\Downloads\PLSQL\sqldeveloper-23.1.1.345.2114-x64\sqldeveloper
.\sqldeveloper.exe

```
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/a783eb83-dd2f-43d0-b2ad-042f875e16a6)

<!-- ```bash
Name: PlayGroundSQL
Role: SYSDBA
username: ayonssp
password: playing@plsql
host: localhost
port: 1521
sid: xe or orcl
``` -->
> **Note:** *where sid is the name of the database instance. The default name is xe. and for plsql you can use any sid name.*
> ```bash
> sqlplus sys as sysdba
> ```