sudo rmmod nd_module
cd ~/NetChannel/module/
make clean && make -j9
cd ~/NetChannel/util/
make clean && make -j9
cd ~/NetChannel/scripts
./pre-run.sh
#最后要手动运行sudo ~/NetChannel/scripts/run_module.sh
#实际上运行了sudo sysctl /net/nd/nd_add_host=1