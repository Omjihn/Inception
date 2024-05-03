<h1 align="center">
	INCEPTION
</h1>

### Introduction
This project is an initiation to Docker. You can find the subject PDF [here](https://github.com/Omjihn/Inception/files/15198277/Inception_subject.pdf)

### Alpine Linux

All the docker in this project are using Alpine Linux.

## Why this project ?
The main goal of the project is to initiate people to Docker by guiding them to create their own containers. 
In fact, this project can be very easy if you use prebuilt Docker images, which is why they require us to create them manually.
This helps us betterunderstand what Docker really is and how to 'dockerize' our own apps.

## Mandatory part:

- Wordpress: It allows you to manage the website

- MariaDB: It allows you to create a database and make it accessible to Wordpress

- Nginx: The webserver itself

## Bonus part:

- Redis: It's a Wordpress plugin who allows it to use cache, and so optimise the website usage

- Vsftpd: It's a FTP server linked to the Wordpress volume

- Adminer: Allows you to manage the MariaDB Database

- Ngrok: Allows you to make the website avalible worldwide

## Here's the subject schema but with the bonus part added:

![Schema_Inception_bonus](https://github.com/Omjihn/Inception/assets/110061001/26c1c58a-cda5-4d01-99f2-ef8c22c44b47)

### How to build the project ?

1. **Environment Configuration:**
   - Rename the `.env_template` file to `.env`.
   - Fill in all the variables. For the Ngrok token, you need to create an account on the website.
   - In the file `nginx.conf` located in `srcs/requirements/nginx/conf/` make sure to remplace the server name by you'r own domain name.

2. **Docker Compose Configuration:**
   - Add paths to the `docker-compose.yml` file for the volumes of your database and Wordpress. Ensure the paths exist and are empty.

3. **Building the Project:**
   - Use the Makefile provided at the root of the repository.
   
        ```
        sudo make
        ```

<details>

<summary>Available Makefile Commands</summary>

- `Inception`: Default rule to build and start the project.
- `Inception-logs`: Build and start the containers with real-time logs displayed in your terminal. Press `Ctrl + C` to stop the project.
- `build`: Simply builds the project.
- `start`: Simply starts the project.
- `start-logs`: Simply starts the project with real-time logs displayed in your terminal. Press `Ctrl + C` to stop the project.
- `stop`: Simply stops the project.
- `restart`: Simply stops and start the project.
- `remove`: Stops the project and deletes all previously built images.
- `logs`: Prints all the logs from the project.
- `docker-list`: Prints all Docker images found on the system (not only from the project).
- `re`: Stops the project, removes it, rebuilds it, and starts it again.

</details>

Please note that you MUST start the Makefile as root.

### How to connect to all the services installed ?

**Access my website:**
- Go to your web browser and enter the domain name you have set at the environment configuration part.
- By clicking the login button you can access to the wordpress login page. Of course the login credentials would be the ones you have enter in your `.env` file you can connect as admin or user.

**Redis:**
- To check if Redis is successfully installed go to your wordpress dashboard as admin.
- Then go to settings it should have a redis option, click on it and it's status must be "Connected".

**Adminer:**

- With your browser go to `http://0.0.0.0:8080/adminer.php`.
- Then to connect you need to put the database infos form the `.env`:
![Screenshot from 2024-05-03 10-46-32](https://github.com/Omjihn/Inception/assets/110061001/71897378-699d-4ea6-ae66-2beff5699cf2)
- Of course the password will be the `$SQL_PASSWORD` variable

**Vsftpd:**

- There is multiple ways to do it you could use the ftp command directly in the terminal. But in this example I will use FileZilla cause it's a graphical app.

![Screenshot from 2024-05-03 11-03-15](https://github.com/Omjihn/Inception/assets/110061001/db5ef4ca-9a46-41ce-9cb0-5b92590112d6)

- The password will be the `$FTP_PASSWORD` variable
- Then click "Quickconnect" it will tell's you that the ssl is self-signed. It's normal since you'r in local. Click Ok.
- Now it displaying you all the content from the wordpress volume.

**Ngrock:**

- Considering you've already created a Ngrock account, login to the website.
- Go to your dashboard, then on endpoints.
- Click on the URL, then enter. And it will redirect to your website.
- Since this URL is temporary you will not be able to connect to your wordpress. The server can't know on wich URL redirects you it will then redirects you to your own domain name.
- Now you'r maybe wondering why using Ngrock then. The URL it's giving you is accesible wordwide, so yo can have the page on your phone for example.
- Please note that if you stop you'r project the URL will not work anymore. And every time you you start the projcet it will be a different URL.


