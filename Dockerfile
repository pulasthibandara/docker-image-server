FROM ubuntu:xenial
MAINTAINER pulasthi1989@gmail.com

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y nginx \
    && rm -rf /var/lib/apt/lists/*

ADD ./image-server.conf /etc/nginx/conf.d/default.conf
ADD ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir /image_cache /image_tmp

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

ADD VERSION /

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]