#!/bin/bash

# Caution: If you change any port in this file, do not forget to change them on the Snakefile !
# In order to run this script, the SaGe environment must be activated...

VIRTUOSO_DIR=/usr/local/virtuoso-opensource
FUSEKI_DIR=servers/fuseki

# Starting SaGe servers
nohup sage -w 1 -p 8080 "configs/sage/sage-k2-60sec.yaml" > output/log/sage-k2-60sec.log 2>&1 &
echo -n "$! " > .pids
nohup sage -w 1 -p 8081 "configs/sage/sage-k3-60sec.yaml" > output/log/sage-k3-60sec.log 2>&1 &
echo -n "$! " >> .pids
nohup sage -w 1 -p 8082 "configs/sage/sage-k5-60sec.yaml" > output/log/sage-k5-60sec.log 2>&1 &
echo -n "$! " >> .pids
nohup sage -w 1 -p 8083 "configs/sage/sage-k10-60sec.yaml" > output/log/sage-k10-60sec.log 2>&1 &
echo -n "$! " >> .pids
nohup sage -w 1 -p 8084 "configs/sage/sage-k20-500ms.yaml" > output/log/sage-k20-500ms.log 2>&1 &
echo -n "$! " >> .pids
nohup sage -w 1 -p 8085 "configs/sage/sage-k20-1sec.yaml" > output/log/sage-k20-1sec.log 2>&1 &
echo -n "$! " >> .pids
nohup sage -w 1 -p 8086 "configs/sage/sage-k20-60sec.yaml" > output/log/sage-k20-60sec.log 2>&1 &
echo -n "$! " >> .pids

# Starting Virtuoso
nohup sudo $VIRTUOSO_DIR/bin/virtuoso-t -f -c $VIRTUOSO_DIR/var/lib/virtuoso/db/virtuoso.ini > output/log/virtuoso.log 2>&1 &

# Starting Apache Jena Fuseki
nohup $FUSEKI_DIR/fuseki-server > output/log/fuseki.log 2>&1 &
echo -n "$! " >> .pids

# To be sure that all servers have started
echo "Starting all servers... it will takes 30 seconds..."
sleep 30