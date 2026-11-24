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

# Configurar SSH
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

# Arrancar SSH y cron, y mantener el contenedor activo.
# Así, si un playbook reinicia SSH, el contenedor no se detiene.
CMD ["bash", "-c", "service ssh start && service cron start && exec sleep infinity"]
