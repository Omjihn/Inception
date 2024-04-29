# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gbricot <gbricot@student.42perpignan.fr    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/29 11:57:18 by gbricot           #+#    #+#              #
#    Updated: 2024/04/29 14:03:16 by gbricot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception

YAML = ./srcs/docker-compose.yml

$(NAME): build start

Inception-logs: build start-logs

build: check_root check_env
	@docker-compose -f $(YAML) build

start: check_root check_env
	@docker-compose -f $(YAML) up --detach

start-logs: check_root check_env
	@docker-compose -f $(YAML) up

stop: check_root
	-@docker-compose -f $(YAML) stop

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

logs: check_root
	@docker-compose -f $(YAML) logs

docker-list: check_root
	@docker ps -a

docker-image: check_root
	@docker images

re: check_env remove $(NAME)

help:
	@echo "Here's all the avalible make commands:\n\n" \
	"- Inception: it's the default rule it will build the project and start it\n" \
	"- Inception-logs: it will build and start the containers with all the logs in real time in your terminal ctrl + c to stop the project\n" \
	"- build: it will simply build the project\n" \
	"- start: it will simply start the project\n" \
	"- stop: it will simply stop the project\n" \
	"- remove: it will stop the project and delete all the previously builded images\n" \
	"- logs: it will print all the logs from the project\n" \
	"- docker-list: it will print all the docker images found on the system by docker (not only from the project)\n" \
	"- re: it will stop the project, remove it, build it and start it again\n" \
	"\rPlease note that HAVE TO to start this Makefile as root"

###		CHECKS		###

check_root:
    ifneq ($(shell whoami),root)
        $(error You must run this Makefile as root)
    endif

check_env:
    ifneq ($(wildcard ./srcs/.env),)
        DOMAIN_NAME := $(shell grep '^DOMAIN_NAME=' ./srcs/.env)
        SQL_DATABASE := $(shell grep '^SQL_DATABASE=' ./srcs/.env)
        SQL_USER := $(shell grep '^SQL_USER=' ./srcs/.env)
        SQL_PASSWORD := $(shell grep '^SQL_PASSWORD=' ./srcs/.env)
        SQL_ROOT_PASSWORD := $(shell grep '^SQL_ROOT_PASSWORD=' ./srcs/.env)
        SITE_TITLE := $(shell grep '^SITE_TITLE=' ./srcs/.env)
        ADMIN_USER := $(shell grep '^ADMIN_USER=' ./srcs/.env)
        ADMIN_PASSWORD := $(shell grep '^ADMIN_PASSWORD=' ./srcs/.env)
        ADMIN_EMAIL := $(shell grep '^ADMIN_EMAIL=' ./srcs/.env)
        USER1_LOGIN := $(shell grep '^USER1_LOGIN=' ./srcs/.env)
        USER1_PASS := $(shell grep '^USER1_PASS=' ./srcs/.env)
        USER1_MAIL := $(shell grep '^USER1_MAIL=' ./srcs/.env)
        FTP_LOGIN := $(shell grep '^FTP_LOGIN=' ./srcs/.env)
        FTP_PASSWORD := $(shell grep '^FTP_PASSWORD=' ./srcs/.env)
        NGROK_TOKEN := $(shell grep '^NGROK_TOKEN=' ./srcs/.env)

        ifeq ($(DOMAIN_NAME) $(SQL_DATABASE) $(SQL_USER) $(SQL_PASSWORD) $(SQL_ROOT_PASSWORD) $(SITE_TITLE) $(ADMIN_USER) $(ADMIN_PASSWORD) $(ADMIN_EMAIL) $(USER1_LOGIN) $(USER1_PASS) $(USER1_MAIL) $(FTP_LOGIN) $(FTP_PASSWORD) $(NGROK_TOKEN)),)
            $(error .env file is not well filled)
        endif
    else
        $(error .env file not found)
    endif