#!/bin/bash 


CURDIR=$1

COUNT=$(ls $CURDIR | wc -w )

echo $CURDIR $COUNT

