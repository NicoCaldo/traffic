# traffic



sudo tcpdump -i ens38 host 192.168.241.130<br />

#metti in ascolto client and ubuntu<br />
sudo iperf3 -s -p 8080<br />

#lancia dati da server a client and ubuntu<br />
sudo iperf3 -c 192.168.241.133 -p 8080 -t 10<br />

#da lanciare su un ulteriore terminale da ubuntu aperto in ssh <br />
sudo ssh nicola@192.168.241.130<br />
sudo iperf3 -c 192.168.241.132 -p 8080 -t 10<br />

#link grafico rete https://miro.com/app/board/o9J_lMjlSkk=/

