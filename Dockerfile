FROM nvidia/cuda:9.2-runtime-ubuntu18.04
# FROM ubuntu:latest

ENV FLUTTER_VERSION v1.9.1+hotfix.2-stable
ENV ENABLE_FLUTTER_DESKTOP true

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y bash curl unzip xz-utils clang git make lcov libglu1 lib32stdc++6 libxcursor1 libxinerama1 libxrandr2 rsync

WORKDIR /

RUN git clone https://github.com/flutter/flutter.git

ENV PATH $PATH:/flutter/bin/cache/dart-sdk/bin:/flutter/bin

RUN yes | flutter doctor --android-licenses
RUN flutter config --enable-linux-desktop
RUN flutter doctor

ADD . .

ENV FLUTTER_TARGET linux
RUN cd app && flutter pub get && flutter build $FLUTTER_TARGET

RUN chmod +x docker-entry.sh
ENTRYPOINT ["./docker-entry.sh"]