FROM ubuntu:20.04
COPY ./setup.sh /
COPY ./tftpd-hpa /etc/default/tftpd-hpa
COPY ./telnet /etc/xinetd.d/telnet
COPY ./zebra.conf /etc/quagga/zebra.conf
COPY ./ripd.conf /etc/quagga/ripd.conf
COPY ./ospfd.conf /etc/quagga/ospfd.conf
COPY ./bgpd.conf /etc/quagga/bgpd.conf
COPY ./pimd.conf /etc/quagga/pimd.conf
COPY ./isisd.conf /etc/quagga/isisd.conf
COPY ./ospf6d.conf /etc/quagga/ospf6d.conf
COPY ./ripngd.conf /etc/quagga/ripngd.conf
RUN chmod +x /setup.sh
RUN /setup.sh
USER labuser
WORKDIR /home/labuser

