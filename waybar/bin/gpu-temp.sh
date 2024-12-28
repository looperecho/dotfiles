#!/bin/bash

# echo the gpu temp from nvidia-smi 
nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n 1

