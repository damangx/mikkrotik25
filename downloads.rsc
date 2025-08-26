# downloads.rsc - Downloads / Updates
:log info "Importing downloads list"
/ip firewall address-list add list=Downloads address=windowsupdate.microsoft.com comment="Windows Update"
/ip firewall address-list add list=Downloads address=steamcdn.com comment="Steam CDN"
/ip firewall address-list add list=Downloads address=update.microsoft.com comment="MS Update"
/ip firewall address-list add list=Downloads address=dl.google.com comment="Google downloads"
