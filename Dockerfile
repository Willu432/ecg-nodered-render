# Gunakan image Node.js sebagai base image
FROM node:18-alpine

# Set direktori kerja di dalam kontainer
WORKDIR /usr/src/app

# Salin package.json dan package-lock.json untuk menginstal dependensi
COPY package*.json ./

# Instal Node-RED dan dependensinya.
# Menggunakan --unsafe-perm diperlukan untuk beberapa node yang butuh izin khusus.
# --no-optional dan --no-fund untuk instalasi yang lebih bersih dan cepat.
RUN npm install --production --unsafe-perm --no-optional --no-fund

# Salin semua file proyek Node-RED Anda ke dalam kontainer
# Ini akan menyalin Dockerfile, package.json, settings.js, dan semua file .config.*.json, flows.json, flows_cred.json
COPY . .

# Secara default, Node-RED akan menggunakan variabel lingkungan PORT dari Render.
# EXPOSE hanya untuk dokumentasi, memberitahu bahwa port 1880 akan digunakan.
EXPOSE 1880

# Command untuk menjalankan Node-RED.
# Karena file konfigurasi Anda berada di root (bukan di direktori 'data'),
# kita akan menggunakan direktori kerja saat ini sebagai userDir.
CMD ["npm", "start"]
