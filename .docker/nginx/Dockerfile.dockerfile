# Build: docker build -t nginx:alpine -f .docker/nginx/Dockerfile.dockerfile .
FROM nginx:alpine

#debug tools
ARG CACHEBUST=1
#RUN echo "Cache bust: $CACHEBUST" && ls -la  

#add www-data user and group if they don't exist
RUN addgroup -g 82 -S www-data || true \
 && adduser -u 82 -D -S -G www-data www-data || true

#check if the directory exists
RUN mkdir -p /etc/nginx/conf.d && ls -la /etc/nginx/conf.d

#copy the nginx config file
COPY .docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Switch to the www-data user
USER www-data

# Copy the application files to the Docker image
COPY . /var/www

# Switch back to the root user
USER root

#copy the start.sh script
COPY .docker/nginx/scripts/start.sh /start.sh
RUN chmod +x /start.sh

#set the startup command
CMD ["/start.sh"]