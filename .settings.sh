TOOLS="vivado ise quartus libero stop stat"

# PATHs

ISE_DIR=/opt/Xilinx/ise
VIVADO_DIR=/opt/Xilinx/vivado
QUARTUS_DIR=/opt/Intel/quartus
LIBERO_DIR=/opt/Microsemi/libero

# Extra info

LIBERO_LIC_PORT=1702
LIBERO_LIC_HOST=localhost
LIBERO_LMGRD_DIR=/opt/Microsemi/Linux_Licensing_Daemon
LIBERO_LIC_FILE=/opt/Microsemi/License.dat
LIBERO_LIC_LOG=/tmp/libero-license.log

# Exports

TOOL=$1

if [ -z "$TOOL" ]; then
   TOOL=all
else
   if [[ ! $TOOLS == *$TOOL* ]]; then
      echo "Unsuported tool $TOOL";
   fi
fi

## Xilinx

if [ $TOOL == "all" ] || [ $TOOL == "vivado" ]; then
   echo "Configuring Vivado"
   if [[ -d $VIVADO_DIR ]]; then
      export PATH=$VIVADO_DIR/bin:$PATH
   else
      echo "$VIVADO_DIR doesn't exists"
   fi
fi

if [ $TOOL == "all" ] || [ $TOOL == "ise" ]; then
   echo "Configuring ISE"
   if [[ -d $ISE_DIR ]]; then
      export PATH=$ISE_DIR/ISE/bin/lin64:$PATH
   else
      echo "$ISE_DIR doesn't exists"
   fi
fi

## Intel/Altera

if [ $TOOL == "all" ] || [ $TOOL == "quartus" ]; then
   echo "Configuring Quartus"
   if [[ -d $QUARTUS_DIR ]]; then
      export PATH=$PATH:$QUARTUS_DIR/quartus/bin
      # Platform Designer (Qsys) workaround
      export PERL5LIB=$QUARTUS_DIR/quartus/linux64/perl/lib/5.28.1
   else
      echo "$QUARTUS_DIR doesn't exists"
   fi
fi

# Microchip/Microsemi/Actel

if [ $TOOL == "all" ] || [ $TOOL == "libero" ]; then
   echo "Configuring Libero"
   if [[ -d $LIBERO_DIR ]]; then
      export PATH=$PATH:$LIBERO_DIR/Libero/bin
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu
      export LM_LICENSE_FILE=$LIBERO_LIC_PORT@$LIBERO_LIC_HOST
      if [ -z `pidof lmgrd` ]; then
         echo "Launching Microsemi License manager... "
         $LIBERO_LMGRD_DIR/lmgrd -c $LIBERO_LIC_FILE -l $LIBERO_LIC_LOG
      else
         echo "Microsemi License manager is already running... "
      fi
   else
      echo "$LIBERO_DIR doesn't exists"
   fi
fi

if [ $TOOL == "stop" ]; then
   if [[ -d $LIBERO_LMGRD_DIR ]]; then
      $LIBERO_LMGRD_DIR/lmutil lmdown -c $LIBERO_LIC_FILE -q
   else
      echo "$LIBERO_LMGRD_DIR doesn't exists"
   fi
fi

if [ $TOOL == "stat" ]; then
   if [[ -d $LIBERO_LMGRD_DIR ]]; then
      $LIBERO_LMGRD_DIR/lmutil lmstat -c $LIBERO_LIC_FILE
   else
      echo "$LIBERO_LMGRD_DIR doesn't exists"
   fi
fi
