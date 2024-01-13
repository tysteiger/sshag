# Build: docker build -t nginx:alpine -f .docker/nginx/Dockerfile.dockerfile .
FROM nginx:alpine

#debug tools
ARG CACHEBUST=1
#RUN echo "Cache bust: $CACHEBUST" && ls -la  

#check if the directory exists
RUN mkdir -p /etc/nginx/conf.d && ls -la /etc/nginx/conf.d

#copy the nginx config file
COPY .docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf