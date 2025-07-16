# Gunakan image Node.js sebagai base (dasar) untuk kontainer kita.
# node:18-alpine adalah versi Node.js 18 yang lebih ringan (basis Alpine Linux).
FROM node:18-alpine

# Set direktori kerja di dalam kontainer.
# Semua perintah berikutnya akan dijalankan di dalam folder ini.
WORKDIR /usr/src/app

# Salin file penting untuk manajemen dependensi terlebih dahulu.
# Ini termasuk package.json (daftar paket) dan package-lock.json (versi paket terkunci).
# Melakukannya secara terpisah akan membantu Docker membangun lebih cepat jika dependensi tidak berubah.
COPY package.json ./
COPY package-lock.json ./

# Instal Node-RED dan semua dependensinya.
# --production: Hanya instal paket yang dibutuhkan untuk menjalankan aplikasi (bukan untuk pengembangan).
# --unsafe-perm: Diperlukan oleh beberapa "node" Node-RED yang butuh izin khusus saat instalasi.
# --no-optional --no-fund: Mempercepat instalasi dan mengurangi pesan di log.
RUN npm install --production --unsafe-perm --no-optional --no-fund

# Salin semua file proyek Node-RED Anda yang penting ke dalam kontainer.
# Ini akan menyertakan settings.js, flows.json, flows_cred.json, dan file .config.*.json Anda.
# Karena kita sudah menyalin package*.json sebelumnya, kita tidak perlu menyalinnya lagi di sini.
COPY settings.js ./
COPY flows.json ./
COPY flows_cred.json ./
COPY .config.nodes.json ./
COPY .config.runtime.json ./
COPY .config.users.json ./

# Memberi tahu Docker bahwa kontainer ini akan "mendengarkan" di port 1880.
# Ini lebih ke dokumentasi; Railway akan otomatis menangani port.
EXPOSE 1880

# Perintah yang akan dijalankan saat kontainer Docker dimulai.
# Ini akan menjalankan skrip "start" yang sudah kita definisikan di package.json.
CMD ["npm", "start"]
