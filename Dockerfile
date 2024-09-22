# 1. Choose Base Image / OS
# Kita akan menggunakan OS Ubuntu yang telah di install Nodejs
FROM node:lts

# 2. Define Working Directory
# Didalam OS kita akan membuat folder bernama app
# Yang bertujuan untuk menyimpan semua file yang ada di aplikasi kita
WORKDIR /app

# 3. Copy Package.json & Package-lock.json(*) to Workdir, ./ = app
COPY package*.json ./

# 4. Install Dependencies/Package.json, akan menghasilkan node_modules
# node_modules tidak di copy karna sangat berat, tetapi di install diserver.
# karna internetnya server biasanya kencang
RUN npm install


# 5. Membuat ENV database untuk dimasukan ke environment sistemnya docker
ENV DATABASE_URL postgresql://myuser:mypassword@localhost:5432/mydb?schema=public

# 6. Copy juga all files to Workdir, ./ = app
COPY ./ ./

# 7. Copy prisma juga to Workdir, ./ = app
COPY ./prisma ./

# 8. Lakukan generate prisma & 
RUN npx prisma generate
RUN npm run build


# 9. Expose Port
EXPOSE 3000

# 10. Run the App
# start akan merender yang sudah dibuild dan akan dimasukan kedalam .next
CMD ["npm", "start"]