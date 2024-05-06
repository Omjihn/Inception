# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gbricot <gbricot@student.42perpignan.fr    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/29 11:57:18 by gbricot           #+#    #+#              #
#    Updated: 2024/05/03 12:55:37 by gbricot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception

YAML = ./srcs/docker-compose.yml

$(NAME): info_root build start

Inception-logs: info_root build start-logs

build:
	@docker-compose -f $(YAML) build

start:
	@docker-compose -f $(YAML) up --detach

start-logs:
	@docker-compose -f $(YAML) up

stop:
	-@docker-compose -f $(YAML) stop

restart : stop start

remove: stop
	-@docker rm	nginx \
				wordpress \
				redis \
				vsftpd \
				adminer \
				mariadb \
				ngrok

	-@docker rmi srcs_nginx \
				srcs_wordpress \
				srcs_redis \
				srcs_vsftpd \
				srcs_adminer \
				srcs_mariadb \
				srcs_ngrok \
				alpine:3.19.1

	-@docker volume rm	srcs_mariadb \
				srcs_wordpress

	-@docker network rm	srcs_inception 

remove-all: stop
	@echo "Do you really want to delete all your system stopped dockers and all your images ? [y/n]"
	@read -r response; \
	if [ "$$response" = "y" ]; then \
		docker system prune -af ; \
	elif [ "$$response" = "n" ]; then \
		echo "Aborting..." ; \
		exit; \
	else \
		echo "Invalid input. Please enter 'y' or 'n'"; \
		exit; \
	fi

logs:
	@docker-compose -f $(YAML) logs

docker-list:
	@docker ps -a

docker-image:
	@docker images

re: remove $(NAME)

help:
	@echo "Here's all the avalible make commands:\n\n" \
	"- Inception: Default rule to build and start the project.\n" \
	"- Inception-logs: Build and start the containers with real-time logs displayed in your terminal. Press Ctrl + C to stop the project.\n" \
	"- build: Simply builds the project.\n" \
	"- start: Simply starts the project.\n" \
	"- start-logs: Simply starts the project with real-time logs displayed in your terminal. Press Ctrl + C to stop the project." \
	"- stop: Simply stops the project.\n" \
	"- restart: Simply stops and start the project.\n" \
	"- remove: Stops the project and deletes all previously built images.\n" \
	"- remove-all: Stops the project and deletes every images, containers or networks." \
	"- logs: Prints all the logs from the project.\n" \
	"- docker-list: Prints all Docker images found on the system (not only from the project).\n" \
	"- re: Stops the project, removes it, rebuilds it, and starts it again.\n" \
	"\rPlease note that you MUST start the Makefile as root."

###		INFO_PRINT		###

info_root:
	@echo "Reminder: please run this makefile as root user."
