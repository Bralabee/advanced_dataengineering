# Makefile for common developer tasks

up:
	docker-compose --profile gpu up -d --build

up-cpu:
	docker-compose --profile cpu up -d --build

down:
	docker-compose down

logs:
	docker-compose logs --tail=100 --follow

clean:
	docker-compose down -v

ps:
	docker-compose ps

# Add more targets as needed
