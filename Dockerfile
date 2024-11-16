# Usar una imagen base de Nginx
FROM nginx:latest

# Copiar los archivos de la aplicación web al directorio de Nginx
COPY html/ /usr/share/nginx/html/
COPY cgi-bin/ /usr/lib/cgi-bin/

# Copiar el archivo de configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80
EXPOSE 80
