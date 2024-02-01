#!/bin/sh

# Change the ownership of /var/www/public to www-data
chown -R www-data:www-data /var/www/public

# Start Nginx
nginx -g "daemon off;"