# Compile
```bash
sudo apt update && sudo apt install git dpkg-dev debhelper dh-dkms -y
git clone https://github.com/firlin123/jupiter-dkms.git
cd jupiter-dkms
dpkg-buildpackage -us -uc
```

# Get files
```bash
sudo apt update && sudo apt install git -y
git clone https://github.com/firlin123/jupiter-dkms.git
git clone https://gitlab.com/evlaV/linux-integration.git
cd linux-integration
git checkout "<kernel package version>"
cp drivers/platform/x86/jupiter.c ../jupiter-dkms/jupiter.c
```
