# importing image centos5.

FROM centos:centos7

# Running update
RUN yum -y update \
# Installing epel-repo
    && yum -y install epel-release \

# Running update and installing nginx
    && yum -y update \
    && yum -y install nginx \

# Removing the nginx main config
    && rm -v /etc/nginx/nginx.conf \

# cleaning all packages cache.
    && yum clean all

# Adding my custom nginx main config file
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Adding gzip.conf to enable gzip compression
COPY ./config/common.d/gzip.conf /etc/nginx/common.d/gzip.conf

# Adding my custom nginx config
COPY ./config/conf.d/site.dev.conf /etc/nginx/conf.d/site.dev.conf

# Expose port 80
EXPOSE 80

# Start Nginx.
CMD ["nginx", "-g", "daemon off;"]