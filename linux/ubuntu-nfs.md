 Ubuntu NFS
============================


 NFS Server 
-----------------
```sh
sudo apt update
sudo apt install nfs-kernel-server

sudo mkdir /var/nfs/general -p
echo '
/var/nfs/general    ${NFS_CLIENT_IP}/32(rw,sync,no_root_squash)
' | tee -a /etc/exports

sudo systemctl restart nfs-kernel-server

sudo ufw status
sudo ufw allow from ${NFS_CLIENT_IP} to any port nfs
```

 NFS Client
-----------------
```sh
sudo apt update
sudo apt install nfs-common

sudo mkdir -p /nfs/general
sudo mount ${NFS_SERVER_IP}:/var/nfs/general /nfs/general

echo '
${NFS_SERVER_IP}:/var/nfs/general    /nfs/general    nfs rw,hard,intr 0 0
' | tee -a /etc/fstab
```
