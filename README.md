<h1 align="center">
	INCEPTION
</h1>

### Introduction
This project is an initiation to Docker. You can find the subject PDF [here](subject/Inception_subject_apr_2024.pdf).

### Built with Alpine Linux
This project has been developed using Alpine Linux.

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

### How to build the project ?

1. **Environment Configuration:**
   - Rename the `.env_template` file to `.env`.
   - Fill in all the variables. For the Ngrok token, you need to create an account on the website.

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
- `stop`: Simply stops the project.
- `restart`: Simply stops and start the project.
- `remove`: Stops the project and deletes all previously built images.
- `logs`: Prints all the logs from the project.
- `docker-list`: Prints all Docker images found on the system (not only from the project).
- `re`: Stops the project, removes it, rebuilds it, and starts it again.

</details>

Please note that you MUST start the Makefile as root.
