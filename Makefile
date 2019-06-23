IMAGE ?= accounting-api

run:
	ruby main.rb

build:
	docker build . -t ${IMAGE}

container-run:
	docker run -d -p 4567:4567 --name=${IMAGE}-container ${IMAGE}

container-stop:
	docker stop ${IMAGE}-container

