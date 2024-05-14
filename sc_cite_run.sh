#!/bin/bash
#***** NOTE: run this using: sg grp_supplychainai "sbatch thefilename"

#SBATCH --time=48:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --gpus=1
#SBATCH -C 'pascal'   # features syntax (use quotes): -C 'a&b&c&d'
#SBATCH --mem-per-cpu=32768M   # memory per CPU core
#SBATCH -J "seal_test"   # job name

if [ "$(id -gn)" != "grp_supplychainai" ]; then
    echo '*!*!*' This job is not running as the intended group. If you want to run it as grp_supplychainai, run sbatch as follows:  sg grp_supplychainai '"'sbatch thefilename'"'
    exit 1
fi


# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python seal_link_pred.py --dataset ogbl-citation2 --num_hops 1 --use_feature --use_edge_weight --eval_steps 1 --epochs 10 --dynamic_train --dynamic_val --dynamic_test --train_percent 2 --val_percent 1 --test_percent 1