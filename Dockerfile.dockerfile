# Gunakan image resmi Node-RED sebagai base
FROM nodered/node-red

# Setel direktori kerja di dalam container
WORKDIR /data

# Salin flows.json dan flows_cred.json yang sudah ada ke dalam container
COPY flows.json /data/flows.json
COPY flows_cred.json /data/flows_cred.json

# Jika Anda memiliki file settings.js kustom, salin juga
# Hapus baris ini jika Anda menggunakan settings.js default
# COPY settings.js /data/settings.js

# Jika Anda perlu menginstal palette Node-RED tambahan (misalnya, node-red-contrib-dashboard)
# Anda dapat menambahkannya di sini. Ini akan berjalan setiap kali deploy.
# RUN npm install node-red-contrib-dashboard
# RUN npm install node-red-node-serialport # Jika Anda butuh ini (tapi ingat, Node-RED di cloud tidak bisa akses serial fisik lokal)

# Expose port default Node-RED
EXPOSE 1880

# Jalankan Node-RED saat container dimulai
# --userDir /data memastikan Node-RED menggunakan direktori /data di dalam container
CMD ["npm", "start", "--", "--userDir", "/data"]