FROM alpine:3.19

# Installera nftables
RUN apk add --no-cache nftables

# Kopiera och fixa radbrytningstecken för alla filer
COPY entrypoint.sh /entrypoint.sh
COPY nftables.conf /etc/nftables.conf

# Fixa radbrytningstecken och gör executable
RUN sed -i 's/\r$//' /entrypoint.sh && \
    sed -i 's/\r$//' /etc/nftables.conf && \
    chmod +x /entrypoint.sh

# Kör entrypoint-skriptet
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]