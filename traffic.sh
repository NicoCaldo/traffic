#!/bin/bash

TC=/sbin/tc

# interface traffic will leave on
IF=ens39

IP=192.168.241.133

# The parent limit, children can borrow from this amount of bandwidth
# based on what's available.
LIMIT=100mbit

shaping () {
  
$TC qdisc del dev $IF root
echo "== DELETE DONE =="

$TC qdisc add dev $IF root handle 1:0 htb default 10

$TC class add dev $IF parent 1:0 classid 1:10 htb rate $LIMIT
$TC class add dev $IF parent 1:0 classid 1:30 htb rate $LIMIT

$TC filter add dev $IF protocol ip parent 1:0 prio 1 u32 match ip dst 192.168.241.33 flowid 1:10
$TC filter add dev $IF protocol ip parent 1:0 prio 1 u32 match ip dst 192.168.241.33 flowid 1:30

echo "== SHAPING DONE =="
}

delay_c() {
  
$TC qdisc del dev $IF root
echo "== DELETE DONE =="

$TC qdisc add dev $IF root handle 1:0 htb default 10

$TC class add dev $IF parent 1:0 classid 1:10 htb rate $LIMIT prio 0

$TC qdisc add dev $IF parent 1:10 netem corrupt 50% delay 100ms 25ms distribution normal

ping -c 5 $IP

$TC filter add dev $IF parent 1:0 prio 0 protocol ip handle 10 fw flowid 1:10

}

duplicate () {
  
$TC qdisc del dev $IF root
echo "== DELETE DONE =="

$TC qdisc add dev $IF root handle 1:0 htb default 10

#ping -c 5 $IP

$TC class add dev $IF parent 1:0 classid 1:10 htb rate $LIMIT prio 0

$TC qdisc add dev $IF parent 1:10 netem duplicate 100%

ping -c 5 $IP

$TC filter add dev $IF parent 1:0 prio 0 protocol ip handle 10 fw flowid 1:10

}


if [ "$1" = "delay_c" ]
then
	delay_c
fi

if [ "$1" = "shaping" ]
then
	shaping
fi

if [ "$1" = "duplicate" ]
then
	duplicate
fi
