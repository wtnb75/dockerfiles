FROM node:alpine
RUN npm i ethercalc
RUN ln -sf /node_modules /node_modules/ethercalc/node_modules
EXPOSE 8000
CMD [ "/node_modules/.bin/ethercalc" ] 
