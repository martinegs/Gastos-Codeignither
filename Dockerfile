FROM php:8.2-cli

# Instala extensiones necesarias y composer, incluyendo intl
RUN apt-get update && apt-get install -y \
    unzip zip curl git libzip-dev libicu-dev \
    && docker-php-ext-install zip mysqli pdo pdo_mysql intl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Setea el directorio de trabajo
WORKDIR /var/www/html

# Copia todo el proyecto
COPY . .

# Instala dependencias de Composer
RUN composer install

# Expone el puerto (opcional, según cómo expongas en docker-compose)
EXPOSE 8080

# Comando por defecto
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
