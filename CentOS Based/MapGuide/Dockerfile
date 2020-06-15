FROM centos:centos6
ENV URL_HOST="http://download.osgeo.org"
ENV URL_RELPATH="/mapguide/releases"
ENV FDOVER_MAJOR=4
ENV FDOVER_MINOR=1
ENV FDOVER_MAJOR_MINOR=${FDOVER_MAJOR}.${FDOVER_MINOR}
ENV FDOVER_POINT=0
ENV FDOVER_MAJOR_MINOR_REV=${FDOVER_MAJOR_MINOR}.${FDOVER_POINT}
ENV FDOBUILD=7814
ENV FDOARCH=amd64
ENV FDOVER=${FDOVER_MAJOR_MINOR_REV}-${FDOBUILD}_${FDOARCH}
ENV MGVER_MAJOR=3
ENV MGVER_MINOR=1
ENV MGVER_MAJOR_MINOR=${MGVER_MAJOR}.${MGVER_MINOR}
ENV MGVER_POINT=2
ENV MGVER_MAJOR_MINOR_REV=${MGVER_MAJOR_MINOR}.${MGVER_POINT}
ENV MGRELEASELABEL=Final
ENV MGBUILD=9484
ENV MGARCH=amd64
ENV MGVER=${MGVER_MAJOR_MINOR_REV}-${MGBUILD}_${MGARCH}
ENV MG_PATH=/usr/local/mapguideopensource-${MGVER_MAJOR_MINOR_REV}
ENV MGRELEASELABEL=Final

RUN yum update -y \
    && yum install wget java-1.8.0-openjdk -y \
    && export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64 \
    && export PATH=$PATH:$JAVA_HOME/bin

ADD mginstallcentos.sh /
RUN chmod +x /mginstallcentos.sh && ./mginstallcentos.sh

ADD entrypoint.sh /
RUN chmod a+x /entrypoint.sh; \
    chmod a+rw ${MG_PATH}/webserverextensions/www/fusion/lib/tcpdf/cache/
EXPOSE 2810 2811 2812 8008 8009
ENTRYPOINT ["/entrypoint.sh"]
