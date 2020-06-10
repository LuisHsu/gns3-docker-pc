build:
	docker build -t newinternetlab/491g-docker .
push:
	docker push netinternetlab/491g-docker
run:
	docker run --privileged -it newinternetlab/491g-docker bash
