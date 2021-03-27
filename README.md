# traffic



sudo tcpdump -i ens38 host 192.168.241.130

#metti in ascolto client and ubuntu
sudo iperf3 -s -p 8080

#lancia dati da server a client and ubuntu
sudo iperf3 -c 192.168.241.133 -p 8080 -t 10

#da lanciare su un ulteriore terminale da ubuntu aperto in ssh 
sudo ssh nicola@192.168.241.130
sudo iperf3 -c 192.168.241.132 -p 8080 -t 10

