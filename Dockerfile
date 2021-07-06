FROM node
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN git clone https://github.com/Fluffy9/bluzelle-upload.git
WORKDIR bluzelle-upload
RUN npm install
ENTRYPOINT ["/entrypoint.sh"]
