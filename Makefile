build:
	docker build -t newinternetlab/docker-pc .
push:
	docker push newinternetlab/docker-pc
run:
	docker run --privileged -it newinternetlab/docker-pc bash
