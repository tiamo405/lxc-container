* chatgpt: https://chatgpt.com/share/67f9d28a-ec34-8000-8eb3-2aa69428f316
* đây là cách tạo các máy ảo hóa trên ubuntu
* mỗi container có thể có 1 ip riêng để ssh
* Công cụ: LXD
# Install
## Bước 1: Gỡ bản cũ (nếu có)
```
sudo apt remove --purge lxd lxd-client -y
```
## Bước 2: Cài Snap (nếu chưa có)
sudo apt install snapd -y
## Bước 3: Cài LXD mới qua Snap
sudo snap install lxd
Bản này luôn là bản mới nhất (LXD 5.x hoặc cao hơn).
Sau đó: Thêm user của bạn vào group lxd
sudo usermod -aG lxd $USER
Rồi logout và login lại, hoặc:
newgrp lxd
## Bước 4: cấu hình mạng
1. Tạo bridge br0 trên máy B
* lưu ý chỉ nên dùng 1 file .yaml khi apply
```
sudo apt install bridge-utils -y
sudo nano /etc/netplan/01-netcfg.yaml
```
```sh
network:
  version: 2
  renderer: networkd
  ethernets:
    enp5s0:
      dhcp4: no
  bridges:
    br0:
      interfaces: [enp5s0]
      addresses: [192.168.5.106/24]
      dhcp4: no
      gateway4: 192.168.5.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```
Thay các giá trị:
* 192.168.5.106 → IP tĩnh bạn muốn gán cho máy
* 192.168.5.1 → địa chỉ modem/router
sau đó:
```
sudo netplan apply
```
# Bước 5: khởi tạo lại LXD
- Would you like to use LXD clustering? (yes/no) [default=no]: chọn no
- Do you want to configure a new storage pool? (yes/no) [default=yes]: yes
- Name of the new storage pool: default
- Name of the storage backend to use (dir, zfs, lvm, btrfs): dir
- Would you like to connect to a MAAS server? (yes/no) [default=no]: chọn no
- Would you like to create a new local network bridge? (yes/no) [default=yes]:  no
- Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]:  chon yes
- Name of the existing bridge or host interface: br0
- Would you like LXD to be available over the network? (yes/no) [default=no]:  chọn no
- Would you like stale cached images to be updated automatically? (yes/no) [default=yes] yes
- Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: no
# Bước 6: khởi tạo thử 1 container
run file bash.sh (file config se tu khoi tao q user và add ssh-key máy A vào để máy A có thể ssh luôn)
```
bash create-new-container.sh
```