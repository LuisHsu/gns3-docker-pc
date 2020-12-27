Setup
=====
In GNS3:

New Template -> Manually create -> Docker -> Docker containers -> New -> New image.

Set the Image name as "newinternetlab/docker-pc:latest" and add two (if needed) network adapters. Then drag the new template onto the screen.



Update Images in GNS3
=====================

If the Docker image is updated to include more programs or files, then you need to clear the Docker image cache so it is redownloaded from Docker Hub.

On your host machine, use the SSH connection details in the VirtualBox window to connect to the GNS3 VM.

(If you are running on a Linux host and chose to run Docker images on your system directly, then just open a regular terminal.)

Once logged in with username and password gns3, hit enter and then choose the option for a terminal.

Delete the Docker nodes in the GNS3 graphical diagram.

Run `docker rmi -f newinternetlab/docker-pc`

Re-add the Docker nodes and you will see in the GNS3 console at the bottom of the window that the image is being re-pulled from Docker Hub.
