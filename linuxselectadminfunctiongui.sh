
# Define menu options
options=("Set Static IP Address" "Edit /etc/hosts/ File" "Perform Nmap Scan" "Quit")

# Display menu and prompt user for selection
selection=$(zenity --list --title="Select an Option" --column="Options" "${options[@]}" --width=400 --height=300)

# Handle user selection
case $selection in
  "Set Static IP Address")
    # Call set static IP address script
    ./set_static_ip_address.sh
    ;;
  "Edit /etc/hosts/ File")
    # Call edit /etc/hosts/ file script
    ./edit_hosts_file.sh
    ;;
  "Perform Nmap Scan")
    # Call perform Nmap scan script
    ./nmap_scan.sh
    ;;
  "Quit")
    # Exit script
    exit 0
    ;;
  *) 
    # Handle invalid selection
    zenity --error --text="Invalid selection."
    ;;
esac
