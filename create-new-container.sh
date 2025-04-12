lxc launch ubuntu:22.04 linhmc-hanel  --network br0 --config=user.user-data="$(cat cloud-init-namtp.yaml)"
