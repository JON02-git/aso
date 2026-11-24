FROM ubuntu:24.04

# cron: para practicar con el módulo cron de Ansible
# iproute2: comando ip, que Ansible usa para obtener los datos de red de cada nodo
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    cron \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# El usuario ubuntu ya existe: establecemos contraseña y permisos
RUN echo "ubuntu:ubuntu" | chpasswd && \
    usermod -aG sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Corrige el propietario y permisos del home de ubuntu en todos los contenedores
RUN chown ubuntu:ubuntu /home/ubuntu && \
    chmod 755 /home/ubuntu

# Configurar SSH
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 22

# Arranca SSH y cron, corrige el propietario del volumen y mantiene el contenedor activo.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]