NAME = inception

all:
	@mkdir -p /home/vitor/data/mariadb
	@mkdir -p /home/vitor/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a --volumes -f

fclean: clean
	sudo rm -rf /home/vitor/data/mariadb/*
	sudo rm -rf /home/vitor/data/wordpress/*

re: fclean all

.PHONY: all down clean fclean re
