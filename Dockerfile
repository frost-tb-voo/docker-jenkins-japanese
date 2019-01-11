FROM jenkins/jenkins:lts
MAINTAINER Novs Yama

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.vcs-url="https://github.com/frost-tb-voo/docker-jenkins-japanese"

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL ja_JP.UTF-8
ENV LANG ${LC_ALL}
ENV LANGUAGE ${LC_ALL}
ENV TZ 'Asia/Tokyo'

RUN apt-get -y update \
 && apt-get -y install locales \
 && apt-get -y autoclean \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*
RUN locale-gen ${LANG}
RUN echo ${LANG} UTF-8 >> /etc/locale.gen
RUN dpkg-reconfigure -f noninteractive locales
RUN update-locale LANG=${LANG}

RUN echo ${TZ} > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

USER jenkins
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL ja_JP.UTF-8
ENV LANG ${LC_ALL}
ENV LANGUAGE ${LC_ALL}
ENV TZ 'Asia/Tokyo'
ENV JAVA_OPTS "-Duser.timezone=${TZ} -Djava.awt.headless=true -Dorg.apache.commons.jelly.tags.fmt.timeZone=${TZ}"

