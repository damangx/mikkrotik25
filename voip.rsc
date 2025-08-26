# voip.rsc - VoIP / Video Call address-list
:log info "Importing voip list"
/ip firewall address-list add list=VoIP address=zoom.us comment="Zoom"
/ip firewall address-list add list=VoIP address=meet.google.com comment="Google Meet"
/ip firewall address-list add list=VoIP address=teams.microsoft.com comment="MS Teams"
/ip firewall address-list add list=VoIP address=discord.com comment="Discord"
/ip firewall address-list add list=VoIP address=whatsapp.com comment="WhatsApp Call"
