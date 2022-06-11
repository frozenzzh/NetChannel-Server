source param.sh

# Run 1 L-app
./fig4-tcp-isol-client-runl.sh tcppingpong_prio0

echo ""
echo "Run 1 L-app (isolated).."

sleep 65

# Run 8 T-apps
./fig4-tcp-isol-client-runt.sh > thru.log &
echo ""
echo "Run 8 T-apps.."

# Measure CPU utilization
sar -u 55 1 > cpu_client.log &
ssh $server_ip 'sar -u 55 1' > cpu_server.log &

sleep 65

thru=$(grep Throughput: thru.log | awk '{x=x+$2;} END {print x;}')
cpu_client=$(grep Average: cpu_client.log | awk '{x=$3+$5;} END {print x*32/100.0;}')
cpu_server=$(grep Average: cpu_server.log | awk '{x=$3+$5;} END {print x*32/100.0;}')
cpu=$(echo $cpu_client $cpu_server | awk '{if ($1 > $2) print $1; else print $2}')
tpc=$(echo $cpu | awk '{print $1/8}')

echo ""
python3 ~/NetChannel/util/read_pingpong.py 1 tcp
echo ""
echo "T-apps Throughput: $thru (Gbps)"
echo "Per-core CPU usage: $tpc"
rm thru.log cpu_client.log cpu_server.log result_tcp_pingpong_0
