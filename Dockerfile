FROM cypress/browsers:latest

# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

# disable shared memory X11 affecting Cypress v4 and Chrome
# https://github.com/cypress-io/cypress-docker-images/issues/270
ENV QT_X11_NO_MITSHM=1
ENV _X11_NO_MITSHM=1
ENV _MITSHM=0

# copy project to /app and workdir
COPY . /app
WORKDIR /app

RUN apt-get update
RUN apt-get install unzip
RUN apt-get install curl
# RUN apt-get install libsoup-3.0-0 -> rodar browser Safari

#install npm depedencies
RUN npm install --no-save
# RUN npm audit 

CMD