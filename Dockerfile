FROM mcr.microsoft.com/dotnet/sdk:9.0
MAINTAINER Kok How, Teh <funcoolgeek@gmail.com>
RUN apt update -y --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata gnupg2 gnupg gnupg1
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN echo "Asia/Singapore" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt update -y --fix-missing
RUN apt install -y libimage-exiftool-perl software-properties-common redis-server sudo apt-transport-https git-lfs openssh-client git unzip postgresql
RUN curl -sL -o /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip /tmp/awscliv2.zip -d /tmp
RUN /tmp/aws/install
ENV DOCKER_CLIENT_VER 28.1.0
RUN curl -sL -o /tmp/docker-$DOCKER_CLIENT_VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLIENT_VER.tgz
RUN tar zxf /tmp/docker-$DOCKER_CLIENT_VER.tgz -C /tmp
RUN mv /tmp/docker/* /usr/bin
#RUN wget -q https://packages.microsoft.com/config/ubuntu/25.04/packages-microsoft-prod.deb
#RUN dpkg -i packages-microsoft-prod.deb
RUN curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN dotnet tool install --global dotnet-ef
ENV PATH $PATH:/root/.dotnet/tools
# Create the file repository configuration:
#RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Import the repository signing key:
#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# Update the package lists:
#RUN apt update -y
# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
#RUN apt install -y postgresql
#ENTRYPOINT ["run.sh"]
CMD ["bash"]
