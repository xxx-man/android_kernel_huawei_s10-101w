#!/bin/bash

# location
TOP=`pwd`
export KERNELDIR=$TOP
export PARENTDIR=~
export INITRAMFS_SOURCE=`readlink -f ${KERNELDIR}/#INITRD`
export INITRAMFS_TMP="/tmp/initramfs-source"
export PATH=${PARENTDIR}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/:${PATH}

# system compiler
export CROSS_COMPILE=${PARENTDIR}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-

# kernel
export ARCH=arm

# config
#export KERNEL_CONFIG="hisi_k3v2oem1_defconfig"
export KERNEL_CONFIG="hisi-s10_A_wifi_defconfig"
#export KERNEL_CONFIG="hisi-s10_A_wifi_defconfig_net"

# build script
export USER=`whoami`
export HOST_CHECK=`uname -n`
export OLDMODULES=`find -name *.ko`

clear
echo ""
echo "==================================================================="
echo "Parent dir:		" $PARENTDIR
echo "Kernel build dir:	" $KERNELDIR
echo "Config:			" $KERNEL_CONFIG
echo "==================================================================="

tput setaf 2
echo ""
echo "Cleaning..."
tput sgr0
echo ""

make clean
make distclean
rm -rf ${INITRAMFS_SOURCE}/lib
rm -f ${KERNELDIR}/initrd.cpio.gz

tput setaf 2
echo ""
echo "Done"
tput sgr0
echo ""
