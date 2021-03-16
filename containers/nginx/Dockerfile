FROM nginx:stable
RUN rm -f /etc/nginx/conf.d/*
ADD ./containers/nginx/nginx.conf /etc/nginx/conf.d/webapp.conf
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
