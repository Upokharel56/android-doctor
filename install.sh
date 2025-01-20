Download_Url="https://drive.usercontent.google.com/download?id=1HDVD9O7aoB7d_AvsaEn_rou21BuxWm2u&export=download&confirm=t&uuid=1e365524-120f-454a-bac4-140e7e5ab719"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Trying to elevate privileges..."
    sudo "$0" "$@"
    exit $?
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
clear
echo "Installing Android Doctor..."
# Download the .deb file to the temporary directory
curl -L -o "$TEMP_DIR/package.deb" "$Download_Url"

# Install the .deb package
sudo dpkg -i "$TEMP_DIR/package.deb"

# Check if the installation was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to install the package."
    exit 1
fi


echo "Android Doctor has been installed successfully."

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

# Get the original user's home directory
USER_HOME=$(eval echo ~$SUDO_USER)

# Add export to bashrc and zshrc
# Add export to bashrc and zshrc
cat <<EOL >> "$USER_HOME/.bashrc"
export PATH=\$PATH:/usr/local/utsav/bin
alias adoc='android-doctor'
EOL

cat <<EOL >> "$USER_HOME/.zshrc"
export PATH=\$PATH:/usr/local/utsav/bin
alias adoc='android-doctor'
EOL
# Source the updated bashrc and zshrc
. "$USER_HOME/.bashrc"
. "$USER_HOME/.zshrc"

echo "\nInstallation complete. Please type android-doctor to use the Program"
echo "Alternaatively, you can use the  adoc command to launch app to if you prefer"

echo "\n\nApplication will open by default after installation"
echo "Press ctrl+c or close the app to exit"
echo "Always prefer application over command line \n\n"


adoc
echo "Thank you for using Android Doctor"
echo "Have a great day!"