#!/bin/bash
###
### Help and usage (--help or -h) (Справка)
_help() {
    echo -e "${BLUE}
Installation guide - Arch Wiki
${BOLD}For more information, see the wiki: \
${GREY}<https://wiki.archlinux.org/index.php/Installation_guide>${NC}"
}
###
### SHARED VARIABLES AND FUNCTIONS (ОБЩИЕ ПЕРЕМЕННЫЕ И ФУНКЦИИ)
### Shell color codes (Цветовые коды оболочки)
RED="\e[1;31m"; GREEN="\e[1;32m"; YELLOW="\e[1;33m"; GREY="\e[3;93m"
BLUE="\e[1;34m"; CYAN="\e[1;36m"; BOLD="\e[1;37m"; MAGENTA="\e[1;35m"; NC="\e[0m"
###
loadkeys ru
setfont cyr-sun16
clear
################
echo ""
echo -e "${GREEN}:: ${NC}Installation Commands :=) "
echo -e "${CYAN}=> ${NC}Acceptable limit for the list of arguments..."
getconf ARG_MAX  # Допустимый лимит (предел) списка аргументов...'
echo -e "${BLUE}:: ${NC}The determination of the final access rights"
umask  # Определение окончательных прав доступа - Для суперпользователя (root) umask по умолчанию равна 0022
echo -e "${BLUE}:: ${NC}Current full date"
echo "$(date -u "+%F %H:%M")"
## %F - полная дата, то же что и %Y-%m-%d; %H - hour (00..23); %M - minute (00..59)
################
echo ""
echo -e "${GREEN}=> ${NC}To check the Internet, you can ping a service"
# ping google.com -W 2 -c 1
ping -c 2 archlinux.org  # Утилита ping - это очень простой инструмент для диагностики сети
echo -e "${CYAN}==> ${NC}If the ping goes we go further ... :)"  # Если пинг идёт едем дальше ... :)
###
echo ""
echo -e "${GREEN}=> ${NC}Make sure that your network interface is specified and enabled"
echo " Show all ip addresses and their interfaces "
## Показать все ip адреса и их интерфейсы
ip a  # Смотрим какие у нас есть интернет-интерфейсы
sleep 1
#####################
echo ""
echo -e "${BLUE}:: ${NC}Update the package databases"
## Обновим базы данных пакетов
pacman -Sy --print-format "%r"  # Указывает похожий на printf формат для контроля вывода операции --print; «% r» для репозитория
#pacman -Sy --noconfirm  # обновить списки пакетов из репозиториев
sleep 1
################
echo ""
echo -e "${BLUE}:: ${NC}Install the Terminus font"  # Установим шрифт Terminus
pacman -S terminus-font --noconfirm  # Моноширинный растровый шрифт (для X11 и консоли)
# pacman -Sy terminus-font --noconfirm  # Моноширинный растровый шрифт (для X11 и консоли)
# pacman -Syy terminus-font  # Моноширинный растровый шрифт (для X11 и консоли)
# man vconsole.conf
echo ""
echo -e "${BLUE}:: ${NC}Setting up the Russian language, changing the console font to one that supports Cyrillic for ease of use"
loadkeys ru  # Настроим русский язык, изменим консольный шрифт на тот, который поддерживает кириллицу для удобства работы
# loadkeys us
#setfont ter-v12n
#setfont ter-v14b
#setfont cyr-sun16
setfont ter-v16b ### Установленный setfont
#setfont ter-v20b  # Шрифт терминус и русская локаль # чтобы шрифт стал побольше
### setfont ter-v22b
### setfont ter-v32b
echo -e "${CYAN}==> ${NC}Добавим русскую локаль в систему установки"
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
echo -e "${BLUE}:: ${NC}Обновим текущую локаль системы"
locale-gen  # Мы ввели locale-gen для генерации тех самых локалей
sleep 1
echo -e "${BLUE}:: ${NC}Указываем язык системы"
export LANG=ru_RU.UTF-8
#export LANG=en_US.UTF-8
echo -e "${BLUE}:: ${NC}Проверяем, что все заявленные локали были созданы:"
locale -a  # Смотрим какте локали были созданы
sleep 1
clear
######################
echo ""
echo -e "${GREEN}:: ${NC}Проверьте, находится ли он в среде live или chroot "
## Check if in live or chroot environment
## Проверьте, находится ли он в среде live или chroot
if [[ -z ${1-} ]]; then

	## Check boot mode
	## Проверьте режим загрузки

	if [[ -d /sys/firmware/efi ]]; then
		echo "UEFI mode detected!"
		IsUEFI="yes"
	else
		echo "BIOS mode detected!"
		IsUEFI="no"
	fi
echo ""
echo -e "${GREEN}:: ${NC}Обнаружение центрального процессора "	
	## CPU detection
	## Обнаружение центрального процессора
	if grep Intel /proc/cpuinfo; then
		IntelCPU="yes"
	else
		IntelCPU="no"
	fi
echo ""
echo -e "${GREEN}:: ${NC}Вот обнаруженные диски "	
	# echo "Here are the detected disks:"
	## Вот обнаруженные диски:
	lsblk -p | grep disk
	echo -e "\nType the disk you want to install ArchLinux (eg: /dev/sdX, /dev/vdX, /dev/nvme*nX): "
	## Введите диск, на который вы хотите установить Arch Linux (eg: /dev/sdX, /dev/vdX, /dev/nvme*nX):
	read disk
	if [[ $(lsblk -p | grep $disk) ]]; then
		echo "Correct disk!"
		## Правильный диск!
	else
		echo "Wrong disk selected!"
		## Выбран неправильный диск!
		exit
	fi


