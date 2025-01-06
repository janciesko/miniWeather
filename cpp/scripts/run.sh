#/bin/bash
BENCHMARK=$1
HOST1=$2
HOST2=$3
HOST3=$4
HOST4=$5

DEVICE_ID_1=0
DEVICE_ID_2=1
DEVICE_ID_3=2
DEVICE_ID_4=3

HASH=`date|md5sum|head -c 5`
FILENAME="${BENCHMARK}_${HASH}"
echo $FILENAME
VARS0="--bind-to core --map-by socket"
VARS1="-x LD_LIBRARY_PATH=/projects/ppc64le-pwr9-rhel8/tpls/cuda/12.0.0/gcc/12.2.0/base/rantbbm/lib64/:$LD_LIBRARY_PATH -x NVSHMEM_SYMMETRIC_SIZE=8589934592"


#One rank
FILENAME_ACTUAL=$FILENAME".res"
echo "t(sec),nranks,d_mass" | tee $FILENAME_ACTUAL
for S in 1 2 4 8 16; do
   for reps in $(seq 1 3); do
      mpirun $VARS0 -np $S ./$BENCHMARK | tee -a $FILENAME_ACTUAL
   done
done 
