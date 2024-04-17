# syntax=docker/dockerfile:1
# Establece la imagen base para Node.js
FROM node:14

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo package.json para instalar las dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todos los archivos al directorio de trabajo en el contenedor
COPY . .

# Expone el puerto 3000 en el contenedor
EXPOSE 3000

# Variables de entorno para la conexión a MySQL
ENV MYSQL_HOST=localhost \
    MYSQL_USER=root \
    MYSQL_PASSWORD=123456 \
    MYSQL_DATABASE=testdb

# Comando para iniciar la aplicación
CMD ["node", "app.js"]