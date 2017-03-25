# dockerd --storage-opt dm.basesize=30G
# docker run -e "GSLT=" -it csgo
docker run -e "GSLT=" -p 27015:27015 -p 27015:27015/udp -it csgo
