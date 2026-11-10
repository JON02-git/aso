FROM ubuntu:24.04

RUN apt-get update && apt-get install -y openssh-server rsync nano procps && rm -rf /var/lib/apt/lists/*

# Carpeta de ejecución de sshd y claves de host
RUN mkdir -p /run/sshd && ssh-keygen -A

# Usuario de acceso remoto
RUN useradd -m -s /bin/bash soporte && echo 'soporte:soporte123' | chpasswd

# Datos de ejemplo para las copias
RUN mkdir -p /home/soporte/datos/facturas /home/soporte/datos/clientes
RUN for i in 1 2 3 4 5; do echo "Factura $i" > /home/soporte/datos/facturas/factura_$i.txt; done
RUN echo "Ana;Castellon" > /home/soporte/datos/clientes/clientes.csv
RUN chown -R soporte:soporte /home/soporte/datos

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
