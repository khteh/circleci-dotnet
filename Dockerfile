FROM mcr.microsoft.com/dotnet/sdk:7.0-jammy
MAINTAINER Kok How, Teh <funcoolgeek@gmail.com>
RUN apt update -y --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata gnupg2 gnupg gnupg1
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN echo "Asia/Singapore" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt update -y --fix-missing
RUN apt install -y libimage-exiftool-perl software-properties-common redis-server sudo apt-transport-https git-lfs awscli openssh-client git
ENV DOCKER_CLIENT_VER 24.0.7
RUN curl -sL -o /tmp/docker-$DOCKER_CLIENT_VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLIENT_VER.tgz
ENV DOCKERIZE_VERSION v0.7.0
RUN wget -q https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN tar -xz -C /tmp -f /tmp/docker-$DOCKER_CLIENT_VER.tgz
RUN mv /tmp/docker/* /usr/bin
RUN wget -q https://packages.microsoft.com/config/ubuntu/23.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN curl -sL -o /usr/local/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN dotnet tool install --global dotnet-ef --version 7.0.13
ENV PATH $PATH:/root/.dotnet/tools
# Create the file repository configuration:
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# Update the package lists:
RUN apt update -y
# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
RUN apt install -y postgresql
#ENTRYPOINT ["run.sh"]
CMD ["bash"]
