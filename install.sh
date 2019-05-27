# Ensure that the repo has been cloned recursively, or MBED will not be downloaded!
# git clone --recursive https://github.com/KyleBjornson/Blinky_ECadmium.git

GCC_FOLDER_NAME=gcc-arm-none-eabi-8-2018-q4-major
VERSION=1_0_0
CADMIUM_DEPENDENCIES=0

PARENT_DIR="$(dirname "$PWD")"

echo "Dependencies will install here: "$PARENT_DIR"/"

echo "Do you wish to install Cadmium Dependencies as well? (Git and GCC 7 for Cadmium Desktop)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Dependencies will be installed first."; CADMIUM_DEPENDENCIES=1; break;;
        No ) echo "Dependencies will not be installed."; break;;
    esac
done

echo "Continue with Install?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo "### Install Dependencies ###"

if [ $CADMIUM_DEPENDENCIES -eq 1 ]
then

	echo "--> Git"
	sudo apt-get -y install git

	echo "-->GCC for Cadmium Desktop"
	sudo apt-get -y install libboost-all-dev
	sudo add-apt-repository -y ppa:jonathonf/gcc-7.1
	sudo apt-get update
	sudo apt-get -y install gcc-7 g++-7
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-7 --slave /usr bin/gcc-nm gcc-nm /usr/bin/gcc-nm-7 --slave /usr/bin/gcc-ranlib gcc-ranlib usr/bin/gcc-ranlib-7
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60 --slave /usr/bin/g++-ar g++-ar /usr/bin/g++-ar-7 --slave /usr/bin/g++-nm g++-nm /usr/bin/g++-nm-7 --slave /usr/bin/g++-ranlib g++-ranlib usr/bin/g++-ranlib-7 g++ -v

fi


echo "-->Python and PIP"
sudo apt-get -y install python2.7 python-pip

echo "### Download GCC ARM Compiler ###"
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2?revision=d830f9dd-cd4f-406d-8672-cca9210dd220?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,8-2018-q4-major -O gcc-arm-none-eabi-8-2018-q4-major.tar.bz2

echo "### Extract GCC ARM Tarball ###"
tar jxf $GCC_FOLDER_NAME.tar.bz2

echo "### Install GCC ARM Compiler in /opt/gcc-arm-none-eabi-8-2018-q4-major ###"
sudo mv ./$GCC_FOLDER_NAME /opt/

echo "### Cleaning Up GCC ARM Download ###"
sudo rm $GCC_FOLDER_NAME.tar.bz2

echo "### Install MBED-CLI ###"
sudo pip install mbed-cli

echo "### Set MBED Compiler Path ###"
mbed config -G GCC_ARM_PATH /opt/$GCC_FOLDER_NAME/bin

echo "### Download Boost 1.70.0 ###"
wget https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.bz2 -O boost_1_70_0.tar.bz2

echo "### Extract Boost ###"
tar jxf boost_1_70_0.tar.bz2
mv boost_1_70_0 ../

echo "### Cleanup Boost Download ###"
sudo rm boost_1_70_0.tar.bz2

cd ../

echo "### Clone Cadmium (Forked Version for Alpha ECadmium Release) ###"
git clone https://github.com/KyleBjornson/cadmium.git

echo "### Clone DESTimes ###"
git clone https://github.com/Laouen/DESTimes.git

