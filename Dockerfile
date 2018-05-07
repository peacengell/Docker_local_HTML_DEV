# importing image centos6.

FROM centos:centos7

# Running update
RUN yum -y update
# Installing epel-repo
RUN yum -y install epel-release

# Running update and installing nginx
RUN yum -y update
RUN yum -y install nginx

# Removing the nginx main config
RUN rm -v /etc/nginx/nginx.conf


# Adding my custom nginx main config file
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Adding gzip.conf to enable gzip compression
COPY ./config/common.d/gzip.conf /etc/nginx/common.d/gzip.conf

# Adding my custom nginx config

COPY ./config/conf.d/site.dev.conf /etc/nginx/conf.d/site.dev.conf

# Mount Volumes.
# VOLUME ["./VOLUMES/nginx_logs:/var/log/nginx/", "./VOLUMES/site:/var/www/site.dev"]

# cleaning all packages cache.
RUN yum clean all


# Expose port 80
EXPOSE 80

# Start Nginx.
CMD ["nginx", "-g", "daemon off;"]