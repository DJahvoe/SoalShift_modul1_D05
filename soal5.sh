#!/bin/bash
 awk '{if(!/[Ss][Uu][Dd][Oo]/ && /[Cc][Rr][Oo][Nn]/ && NF<13)print;}' /var/log/commands.log > ~/modul1/log.txt
