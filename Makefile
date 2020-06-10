build:
	docker build -t newinternetlab/491g-docker .
push:
	docker push newinternetlab/491g-docker
run:
	docker run --privileged -it newinternetlab/491g-docker bash
