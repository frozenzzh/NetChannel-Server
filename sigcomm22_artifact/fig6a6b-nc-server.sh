server_ip=${1:-192.168.10.117}
iface=${2:-ens2f0}

# Configuration
sudo ~/NetChannel/scripts/run_single_flow_set_up.sh $iface

flows=1
#core_id=12
flow=0
while (( flow < flows ));do
        ((core=flow%4*4+16))
        sudo taskset -c 28 ~/NetChannel/util/server --ip $server_ip --port $((4000 + flow)) &
        (( flow++ ))
done
