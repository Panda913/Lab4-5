# Використовуємо базовий образ Nginx
FROM nginx:latest

# Копіюємо наш index.html до директорії /usr/share/nginx/html в образі Nginx
COPY index.html /usr/share/nginx/html

EXPOSE 80
