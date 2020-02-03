FROM centos:8

MAINTAINER Ziyang Li "https://github.com/zylan29"

RUN yum update -y
RUN yum install -y pkgconfig libtool gcc gcc-c++ make openssl openssl-devel pcre libcap flex hwloc lua zlib curl tcl-devel pcre-devel bzip2

COPY --chown=root:root ./trafficserver-8.0.5.tar.bz2 /root/

WORKDIR /root/

RUN tar -xvf trafficserver-8.0.5.tar.bz2

WORKDIR /root/trafficserver-8.0.5

RUN ./configure && make && make install

RUN sed -i 's/\(CONFIG proxy.config.http.server_ports STRING\).*$/\1 80 443:ssl/g' /usr/local/etc/trafficserver/records.config
RUN sed -i 's/\(CONFIG proxy.config.http.insert_request_via_str INT\).*$/\1 0/g' /usr/local/etc/trafficserver/records.config
RUN sed -i 's/\(CONFIG proxy.config.url_remap.pristine_host_hdr INT\).*$/\1 0/g' /usr/local/etc/trafficserver/records.config
RUN sed -i 's/\(CONFIG proxy.config.http.cache.required_headers INT\).*$/\1 0/g' /usr/local/etc/trafficserver/records.config

EXPOSE 80
EXPOSE 443

# Copy startup script.
COPY trafficserver_startup /usr/local/bin/

# Start!
CMD ["trafficserver_startup"]
