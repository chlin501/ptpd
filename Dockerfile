ARG IMAGE_VERSION=latest

FROM debian:$IMAGE_VERSION

# ARG is reset after FROM keyword
ARG ROOT_PASSWORD=root
ARG DEST_DIR=/ptpd

LABEL "Author"="Chia-Hung Lin"

RUN apt-get update
# RUN apt-get install -y net-tools procps less
# dependencies for debugging by vscode
RUN apt-get install -y apt-utils gcc build-essential make gdb gdbserver rsync zip openssh-server git

COPY ./src/ptpd2 $DEST_DIR/
# COPY ./test/client-e2e-socket.conf ${dest_dir}/
COPY ./start $DEST_DIR/

# configure to communiate with vscode
RUN mkdir -p /var/run/sshd
RUN echo "root:$ROOT_PASSWORD" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p $DEST_DIR
WORKDIR $DEST_DIR

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22

# ENTRYPOINT ["/ptpd/start"]
