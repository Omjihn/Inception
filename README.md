<h1 align="center">
	INCEPTION
</h1>

### Introduction
This project is an initiation to Docker. You can find the subject PDF [here](https://github.com/Omjihn/Inception/files/15198277/Inception_subject.pdf)

### Alpine Linux

All the docker in this project are using Alpine Linux.

## Why this project ?
The main goal of the project is to introduce people to Docker by guiding them to create their own containers. 
In fact, this project can be very easy if you use prebuilt Docker images, which is why they require us to create them manually.
This helps us betterunderstand what Docker really is and how to 'dockerize' our own apps.

## Mandatory part:

- Wordpress: Website manager.

- MariaDB: Database manager that makes it accessible to Wordpress.

- Nginx: The webserver.

## Bonus part:

- Redis: A Wordpress plugin that enables caching for website optimization.

- Vsftpd: An FTP server linked to the Wordpress volume.

- Adminer: A tool for managing the MariaDB Database.

- Ngrok: Allows the website to be accessible worldwide.

## Here's the subject schema but with the bonus part added:

![Schema_Inception_bonus](https://github.com/Omjihn/Inception/assets/110061001/26c1c58a-cda5-4d01-99f2-ef8c22c44b47)

### Requirements:

- Just check if you have docker and docker-compose installed:

		docker --version
  		docker-compose --version
  
If you see `docker: command not found`, install them using the following command (for Debian/Ubuntu):


		sudo apt install docker docker-compose



### How to build the project ?

1. **Environment Configuration:**
   - Rename the `.env_template` file to `.env`.
   - Fill in all the variables. For the Ngrok token, you need to create an account on the website.
   - In the file `nginx.conf` located in `srcs/requirements/nginx/conf/` make sure to remplace the server name by your own domain name.
   - Add `127.0.0.1 $DOMAIN_NAME` to the `/etc/hosts` file. You can do this with the following command, replacing `$DOMAIN_NAME` with your actual domain name:
   
   			echo "127.0.0.1 $DOMAIN_NAME" | sudo tee -a /etc/hosts


2. **Docker Compose Configuration:**
   - Add paths to the `docker-compose.yml` file for the volumes of your database and Wordpress. Ensure the paths exist and are empty.

3. **Building the Project:**
   - Use the provided Makefile at the root of the repository.
   
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
- `remove-all`: Stops the project and deletes every images, containers or networks.
- `logs`: Prints all the logs from the project.
- `docker-list`: Prints all Docker images found on the system (not only from the project).
- `re`: Stops the project, removes it, rebuilds it, and starts it again.

</details>

#### Please note that you MUST start the Makefile as root.

### How to connect to all the services installed ?

**Access my website:**
- Open your web browser and enter the domain name you have set at the environment configuration part.
- Since it's a local website, even if the ssl certificate is enable, it will display a warning. click "continue anyway".
- You can access the Wordpress login page by clicking the login button. Use the login credentials you entered in your `.env` file as either admin or user.

**Redis:**
- To verify if Redis is installed successfully, go to your Wordpress dashboard as admin.
- Then go to settings, there should be a Redis option. Click on it, and its status should be "Connected."

**Adminer:**

- With your browser go to `http://0.0.0.0:8080/adminer.php`.
- Then to connect you need to put the database infos form the `.env`:

![Screenshot from 2024-05-03 10-46-32](https://github.com/Omjihn/Inception/assets/110061001/71897378-699d-4ea6-ae66-2beff5699cf2)

- Of course the password will be the `$SQL_PASSWORD` variable

**Vsftpd:**

- There is multiple ways to do it you could use the ftp command directly in the terminal. In this example I will use FileZilla cause it's a graphical app.

![Screenshot from 2024-05-03 11-03-15](https://github.com/Omjihn/Inception/assets/110061001/db5ef4ca-9a46-41ce-9cb0-5b92590112d6)

- The password will be the `$FTP_PASSWORD` variable
- Then click "Quickconnect" it will tell's you that the ssl is self-signed. It's normal since you'r in local. Click Ok.
- Now it displaying you all the content from the wordpress volume.

**Ngrok:**

- Assuming you've created a Ngrok account, log in to the website.
- Go to your dashboard, then on endpoints.
- Click on the URL, then enter. And it will redirect to your website.
- Since this URL is temporary you will not be able to connect to your wordpress. The server can't know on wich URL redirects you it will then redirects you to your own domain name.
- Ngrok provides a globally accessible URL, allowing you to view the page on your phone, for example.
- Please note that if you stop your project the URL will not work anymore. And every time you'r starting the projet it will be a different URL.


