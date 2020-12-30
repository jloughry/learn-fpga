PROJECTNAME=femtosoc
VERILOGS="$PROJECTNAME.v"
echo ======== Firmware
if [ -e FIRMWARE/firmware.hex ]
then
    (cd FIRMWARE/BUILD; rm firmware.hex; ../TOOLS/firmware_words; cp firmware.hex ../)
else    
    echo "Missing FIRMWARE/firmware.hex"
    echo "Using default (FIRMWARE/EXAMPLES/blinker_wait.s)"
    echo "To replace, cd FIRMWARE; ./make_firmware.sh EXAMPLES/....   or C_EXAMPLES/...."
    (cd FIRMWARE; ./make_firmware.sh EXAMPLES/blinker_wait.s)
fi
echo ======== Yosys
yosys -DICE_STICK -q -p "synth_ice40 -relut -top $PROJECTNAME -json $PROJECTNAME.json" $VERILOGS || exit
echo ======== NextPNR
nextpnr-ice40 --force --json $PROJECTNAME.json --pcf icestick.pcf --asc $PROJECTNAME.asc --freq 12 --hx1k --package tq144 $1 || exit
echo ======== IceTime
icetime -p icestick.pcf -P tq144 -r $PROJECTNAME.timings -d hx1k -t $PROJECTNAME.asc
echo ======== IcePack
icepack $PROJECTNAME.asc $PROJECTNAME.bin || exit
echo ======== IceProg
iceprog $PROJECTNAME.bin || exit
echo DONE.


