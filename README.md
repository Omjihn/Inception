<h1 align="center">
	INCEPTION
</h1>

### This is a docker initiation project
You can check the subject pdf by clicking [here](subject/Inception_subject_apr_2024.pdf)

### This project has been made with Alpine Linux

## Why this project ?
The main goal of the project is to initiate pepoles to docker by making them create they own ones.
In fact this project can be very easy if you use prebuilded docker images, that's why they force us to create them by hand.  
This help us to better understand what really is docker and how to 'dockerize' your own apps.

## Mandatory part:

- Wordpress: It allows you to manage the website

- MariaDB: It allows you to create a database and make it accessible to Wordpress

- Nginx: The webserver itself

## Bonus part:

- Redis: It's a Wordpress plugin who allows it to use cache, and so optimise the website usage

- Vsftpd: It's a FTP server linked to the Wordpress volume

- Adminer: Allows you to manage the MariaDB Database

- Ngrok: Allows you to make the website avalible worldwide

### How to build the project ?

- First you will need to rename the .env_template file to .env. Then fill all the variables, for the Ngrok token you need to create an account on the website.

- Secondly you will need to add paths to the docker-compose.yml file. thouses paths are the volumes of your database and the wordpress. Please make sure to add one and that the path is existing and empty.

- Lastly you need to use the Makefile at the root of the repository

      > sudo make
<details>

<summary>All the avalible makefile commands</summary>


- Inception: it's the default rule it will build the project and start it

- Inception-logs: it will build and start the containers with all the logs in real time in your terminal ctrl + c to stop the project

- build: it will simply build the project

- start: it will simply start the project

- stop: it will simply stop the project

- remove: it will stop the project and delete all the previously builded images

- logs: it will print all the logs from the project

- docker-list: it will print all the docker images found on the system by docker (not only from the project)

- re: it will stop the project, remove it, build it and start it again

</details>

Please note that you HAVE TO to start this Makefile as root
