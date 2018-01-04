# YouPHPTube Dockerfiles
Docker files for development.

## Installing Docker for Windows
**NOTE: Requires Windows 10 Pro, Enterprise or Education**

In the DockerWin10 directory run the ContainerDev.ps1 script in PowerShell.

`cd DockerWin10`

You will have to temporarily set the execution policy to bypass to run the script.

`Set-ExecutionPolicy Bypass`

To run the script enter this command.

`./ContainerDev.ps1`

## Usage Examples

### To build the encoder

`docker build -t encoder:1 . `

### To run the encoder

`docker run -i -t -p 127.0.0.2:80:80 encoder:1 /bin/bash`

### To exit

`exit`