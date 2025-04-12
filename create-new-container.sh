lxc launch ubuntu:22.04 name-container \
  --network br0 \
  --config=user.user-data="$(cat cloud-init-namtp.yaml)" \
  --config=user.network-config="$(cat cloud-init-network.yaml)"
