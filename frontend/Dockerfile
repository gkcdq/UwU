FROM node:20-alpine
WORKDIR /usr/src/app
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 5173
ENTRYPOINT ["/entrypoint.sh"]