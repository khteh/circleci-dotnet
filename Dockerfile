FROM mcr.microsoft.com/dotnet/sdk:6.0.100-focal
MAINTAINER Kok How, Teh <funcoolgeek@gmail.com>
RUN apt update -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata gnupg2 gnupg gnupg1
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN echo "Asia/Singapore" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt install -y libimage-exiftool-perl software-properties-common redis-server sudo apt-transport-https git-lfs awscli
ENV DOCKER_CLIENT_VER 20.10.9
RUN curl -sL -o /tmp/docker-$DOCKER_CLIENT_VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLIENT_VER.tgz
RUN tar -xz -C /tmp -f /tmp/docker-$DOCKER_CLIENT_VER.tgz
RUN mv /tmp/docker/* /usr/bin
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN curl -s -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator
RUN curl -sL -o /usr/local/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN git lfs install
#ENTRYPOINT ["run.sh"]
CMD ["bash"]
