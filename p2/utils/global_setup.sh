sudo apt update
# Commented only for faster VM re-creating in dev env, TODO: decomment ASAP
# sudo apt update -y

sudo apt install curl ufw htop btop fastfetch -y

systemctl disable firewalld --now

fastfetch