# Mapguide Open Source
> http://download.osgeo.org/mapguide/releases/3.1.2/Final/ubuntu14_x64/
---
# How to use
```bash
docker push efremropelato/mapguide:tag
docker run -d \
-p 8008:8008 \
-p 8009:8009 \
-p 2810:2810 \
-p 2811:2811 \
-p 2812:2812 \
--restart always \
--name mapguide_3.1.2 efremropelato/mapguide:tag
# or
docker run -d --net=host --name mapguide_3.1.2 efremropelato/mapguide:tag
```
## Tags:

- 3.1.1
- 3.1.2

# Entrypoint params

+ --no-tomcat        ``doesn't start tomcat server``   
+ --no-apache        ``doesn't start the apache server``   
+ --only-mapguide    ``start only mapguide server``  
+ --crash-time       ``time to start mapguide after crash``

```bash
docker run -it efremropelato/mapguide:tag --no-tomcat
```
## Exposed ports

+ 8008 Apache server
+ 8009 Tomcat server
