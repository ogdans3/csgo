
ENV FOLDER /csgo
MKDIR $FOLDER
WORKDIR $FOLDER

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install lib32gcc1 curl net-tools

ENV USER csgo
RUN useradd $USER
RUN chown $USER:$USER $FOLDER

ADD ./misc $FOLDER/misc

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ./steamcmd.sh +runscript csgo_ds.txt

EXPOSE 27015

CMD ["/csgo/misc/start.sh"]
