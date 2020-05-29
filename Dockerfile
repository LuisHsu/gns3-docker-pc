FROM ubuntu:20.04
COPY ./setup.sh /
RUN chmod +x /setup.sh
RUN /setup.sh
USER labuser
WORKDIR /home/labuser

