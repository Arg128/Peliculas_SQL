# Usar una imagen base de Nginx
FROM nginx:latest

# Instalar FastCGI wrapper
##Esto permite el uso de CGI's dentro de nuestras webb
RUN apt-get update && apt-get install -y fcgiwrap

# Copiar los archivos de la aplicación web al directorio de Nginx
COPY html/ /usr/share/nginx/html/
COPY cgi-bin/ /usr/lib/cgi-bin/

# Copiar el archivo de configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx y FastCGI wrapper
CMD ["sh", "-c", "service fcgiwrap start && nginx -g 'daemon off;'"]

