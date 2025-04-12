FROM ruby:3.1

# 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    openssh-server \
    vim \
    git \
    && rm -rf /var/lib/apt/lists/*

# SSH 서버 설정
RUN mkdir /var/run/sshd
RUN echo 'root:0314' | chpasswd  
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 작업 디렉토리 생성
RUN mkdir -p /root/workspace


# 작업 디렉토리 설정
WORKDIR /root/workspace

# 포트 노출
EXPOSE 4000 22

# SSH 서버만 시작하고 컨테이너 유지
CMD ["/bin/bash", "-c", "service ssh start && tail -f /dev/null"]