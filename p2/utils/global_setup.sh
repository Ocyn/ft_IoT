sudo apt update
# TODO Remove comment to le rendu final mon reuf
# sudo apt update -y

sudo apt install curl ufw htop btop fastfetch -y

systemctl disable firewalld --now

fastfetch