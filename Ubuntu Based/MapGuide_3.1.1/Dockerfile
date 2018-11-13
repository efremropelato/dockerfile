FROM ubuntu:14.04.5

RUN apt-get update \
	\
	&& apt-get -y upgrade \
	\
	&& apt-get -y install wget nano ssh

ADD mginstallubuntu.sh /

RUN chmod +x /mginstallubuntu.sh \
&& ./mginstallubuntu.sh --headless --with-sdf --with-shp --with-sqlite --with-gdal --with-ogr --with-kingoracle --with-wfs --with-wms

COPY run.sh /bin/run.sh
RUN chmod +x /bin/run.sh

EXPOSE 2810 2811 2812 8008 8009

CMD ["/bin/bash"]
