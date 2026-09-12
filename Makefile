NAME = inception

all:
	@mkdir -p /home/vitosant/data
	@mkdir -p /home/vitosant/data/mariadb
	@mkdir -p /home/vitosant/data/wordpress
	docker compose -f ./vitosant/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a --volumes -f

fclean: clean
	sudo rm -rf /home/vitosant/data/mariadb/*
	sudo rm -rf /home/vitosant/data/wordpress/*

re: fclean all

.PHONY: all down clean fclean re
