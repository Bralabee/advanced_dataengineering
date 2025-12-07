# Check health of all running containers
healthcheck:
	docker ps --format '{{.Names}}: {{.Status}}' | grep -v 'Exited'
# Show help for all targets
help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:' Makefile | cut -d: -f1 | xargs -n1 echo '  -'
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

.PHONY: up up-cpu down logs clean ps
