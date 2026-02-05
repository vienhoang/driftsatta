#!/bin/sh
# =============================================================
# Startskript för lastbalanseraren
# =============================================================

# IP-forwarding är redan aktiverat via sysctls i docker-compose.yml
# så vi behöver inte sätta det här

# Ladda nftables-konfigurationen
nft -f /etc/nftables.conf

echo "Lastbalanserare startad."

# Håll containern igång
tail -f /dev/null