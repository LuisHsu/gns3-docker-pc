build:
	docker build -t vrend/491g-docker .
push:
	docker push vrend/491g-docker
run:
	docker run -it vrend/491g-docker bash
