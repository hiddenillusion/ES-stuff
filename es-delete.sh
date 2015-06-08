#!/bin/bash
es2unix=$(which es)
if [[ -e $es2unix ]]; then
        echo "[+] Current ES indices:"
        es indices -v

        echo "[+] Proceed with deletion? [y/n]"
        read answer
        if [[ $answer == "Y" || $answer == "y" ]]; then
                es indices | awk '{if (NF==7 && $2 !~ /kibana-int/) print $2}' | while read index; do echo "[+] Deleting indice: $index" && curl -XDELETE http://localhost:9200/$index; done ; echo "[+] Verification..." ; es indices -v
        else
                echo "[+] exiting then..."
        fi
else
        echo "[!] es2unix not installed - elasticsearch.org/es2unix/es"
fi
