#run a command to install qemu, python3, and pip via pacman
sudo pacman -S qemu python3 python-pip

#get macOS-Simple-KVM from github and cd to it
git clone https://github.com/foxlet/macOS-Simple-KVM
cd macOS-Simple-KVM

#activate a virtual environment in pip, and then install click and requests (all three in separate commands)

python3 -m venv venv
source venv/bin/activate
pip install click
pip install requests

#create a bash popup that asks the user to choose between high sierra, mojave, and catalina

PS3='Please enter your choice: '
options=("default" "High Sierra" "Mojave" "Catalina" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "default")
            echo "you chose default"
            ./jumpstart.sh
            break
            ;;
        "High Sierra")
            echo "you chose High Sierra"
            ./jumpstart.sh --high-sierra
            break
            ;;
        "Mojave")
            echo "you chose Mojave"
            ./jumpstart.sh --mojave
            break
            ;;
        "Catalina")
            echo "you chose Catalina"
            ./jumpstart.sh --catalina
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#creat a virtual disk called MyDisk.qcow2 with a size of 80GB
qemu-img create -f qcow2 MyDisk.qcow2 80G

# prompt the user to edit the basic.sh file to add the following to lines to the end
echo "your mac system is now ready to be installed, please edit the basic.sh file to add the following lines to the end of the file"
echo "-drive id=SystemDisk,if=none,file=MyDisk.qcow2 \"
echo "-device ide-hd,bus=sata.4,drive=SystemDisk \"
