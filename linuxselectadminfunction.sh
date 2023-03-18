
# Define menu options
options=("Set Static IP Address" "Edit /etc/hosts/ File" "Perform Nmap Scan" "Quit")

# Display menu and prompt user for selection
echo "Select an option:"
select option in "${options[@]}"
do;
  case $option in
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
      break
      ;;
    *) 
      # Handle invalid selection
      echo "Invalid selection."
      ;;
  esac
done
