#/bin/bash
# 安装盘
diskPath="/dev/nvme0n1"
# 主机名
hostname="kael-PC"
# 用户名
username="kael"

i(){
  time=$(date "+%Y-%m-%d %H:%M:%S")
  echo -e "\033[32m==> \033[0m $time [info]: $1"
}

# 检查网络
i "检查网络"
ping baidu.com

# 同步网络
i "同步网络"
timedatectl set-ntp true

# 开始分区
i "开始分区"
sgdisk -Z $diskPath
sgdisk -n=0:0:+260M -t=0:ef00 $diskPath
sgdisk -N=0 $diskPath

# 引导盘地址
diskPath_efi=$(fdisk -l $diskPath | awk "/$diskPath/" | awk "/EFI/" | awk '{print $1}')
diskPath_ext4=$(fdisk -l $diskPath | awk "/$diskPath/" | awk "/Linux/" | awk '{print $1}')

# 格式化并挂载分区
i "格式化并挂载分区"
mkfs.fat -F 32 $diskPath_efi
mkfs.ext4 -m 5 $diskPath_ext4
mount $diskPath_ext4 /mnt
mkdir /mnt/boot
mount -o umask=0077 $diskPath_efi /mnt/boot

# 设置中国源
i "设置中国源"
curl -L -o /etc/pacman.d/mirrorlist "https://archlinux.org/mirrorlist/?country=CN"
sed -i 's/^.//g' /etc/pacman.d/mirrorlist

# 安装系统
i "安装系统"
export LANG=C
pacstrap /mnt base linux linux-firmware bash-completion e2fsprogs vim networkmanager pacman-contrib sudo amd-ucode intel-ucode
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt

# 系统初始化设置
i "系统初始化设置"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo $hostname > /etc/hostname
echo "127.0.0.1 localhost
127.0.0.1 $hostname
::1 ip6-localhost ip6-loopback
::1 $hostname" > /etc/hosts
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
sed -i 's/#zh_CN.UTF-8/zh_CN.UTF-8/g' /etc/locale.gen
sed -i 's/#zh_TW.UTF-8/zh_TW.UTF-8/g' /etc/locale.gen
locale-gen
echo LANG=zh_CN.UTF-8 > /etc/locale.conf
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

# 创建用户
i "创建用户$username"
useradd -m -G wheel -s /bin/bash $username
passwd $username

# 安装引导程序
i "安装引导程序"
pacman -S grub
grub-install --removable --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# 退出新系统环境
i "退出新系统环境"
exit
umount -R /mnt

i "安装完成"
