FROM ubuntu

ENV USER csgo
ENV HOME /home/csgo
ENV FOLDER /home/csgo/nydeby/


RUN useradd -m $USER

RUN mkdir $FOLDER
RUN mkdir $FOLDER/server
RUN mkdir $FOLDER/steam
RUN chown -R $USER:$USER $HOME

WORKDIR $FOLDER

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install lib32gcc1 curl net-tools

ADD ./misc/csgo_ds.txt $FOLDER/misc/csgo_ds.txt

USER $USER
WORKDIR $FOLDER/steam

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -C $FOLDER/steam -xvz
RUN ./steamcmd.sh +runscript $FOLDER/misc/csgo_ds.txt

RUN mkdir -p $HOME/.steam/sdk32/
RUN ln -s $FOLDER/steam/linux32/steamclient.so $HOME/.steam/sdk32/steamclient.so
ADD ./misc $FOLDER/misc
ADD ./misc/start.sh $FOLDER/start.sh

ADD ./plugins/addons $FOLDER/server/csgo/addons
ADD ./config/autoexec.cfg $FOLDER/server/csgo/cfg

EXPOSE 27015/udp

WORKDIR $FOLDER
#ENTRYPOINT ["./start.sh"]
