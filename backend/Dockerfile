FROM node:20-alpine
RUN npm install -g @nestjs/cli
WORKDIR /usr/src/app
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]