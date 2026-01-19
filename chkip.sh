IP_ADDR=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if ($i=="src") print $(i+1)}')
echo "Current IP Address: $IP_ADDR"
echo "So you can connect cockpit at: https://$IP_ADDR:9090"