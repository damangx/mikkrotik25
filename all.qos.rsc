# ====================================================
# ALL-IN-ONE QOS SCRIPT for RB3011 (ROS 7.19.4 Stable)
# Author: damangx (mikkrotik25)
# Bandwidth: 300M total (auto-share if few users online)
# ====================================================

# ---------- CLEANUP ----------
/ip firewall mangle remove [find]
/queue tree remove [find]
/ip firewall address-list remove [find where comment~"QOS"]

# ---------- ADDRESS LISTS ----------
# Games 🎮
/ip firewall address-list
add list=Games address=roblox.com comment="QOS"
add list=Games address=mlbb.com comment="QOS"
add list=Games address=callofduty.com comment="QOS"
add list=Games address=valorant.com comment="QOS"
add list=Games address=dota2.com comment="QOS"
add list=Games address=genshinimpact.com comment="QOS"

# Streaming 📺
add list=Streaming address=youtube.com comment="QOS"
add list=Streaming address=tiktokcdn.com comment="QOS"
add list=Streaming address=netflix.com comment="QOS"
add list=Streaming address=viu.com comment="QOS"
add list=Streaming address=bilibili.com comment="QOS"
add list=Streaming address=fbcdn.net comment="QOS"

# VoIP 📞
add list=VoIP address=zoom.us comment="QOS"
add list=VoIP address=meet.google.com comment="QOS"
add list=VoIP address=teams.microsoft.com comment="QOS"
add list=VoIP address=discord.gg comment="QOS"
add list=VoIP address=messenger.com comment="QOS"

# Messaging 💬
add list=Messaging address=telegram.org comment="QOS"
add list=Messaging address=whatsapp.net comment="QOS"
add list=Messaging address=viber.com comment="QOS"

# Downloads ⬇️
add list=Downloads address=steamcontent.com comment="QOS"
add list=Downloads address=windowsupdate.com comment="QOS"
add list=Downloads address=googleusercontent.com comment="QOS"

# ---------- MANGLE ----------
/ip firewall mangle
# Games
add chain=forward dst-address-list=Games action=mark-packet \
    new-packet-mark=games passthrough=no comment="QOS-Games"
# Streaming
add chain=forward dst-address-list=Streaming action=mark-packet \
    new-packet-mark=streaming passthrough=no comment="QOS-Streaming"
# VoIP
add chain=forward dst-address-list=VoIP action=mark-packet \
    new-packet-mark=voip passthrough=no comment="QOS-VoIP"
# Messaging
add chain=forward dst-address-list=Messaging action=mark-packet \
    new-packet-mark=messaging passthrough=no comment="QOS-Messaging"
# Downloads
add chain=forward dst-address-list=Downloads action=mark-packet \
    new-packet-mark=downloads passthrough=no comment="QOS-Downloads"
# Default (Others)
add chain=forward action=mark-packet \
    new-packet-mark=others passthrough=no comment="QOS-Others"

# ---------- QUEUE TREE ----------
/queue tree
# Parent queue (300M max)
add name="Total" parent=global max-limit=300M

# High priority (Games, VoIP)
add name="Games" parent=Total packet-mark=games priority=1 max-limit=100M
add name="VoIP" parent=Total packet-mark=voip priority=1 max-limit=50M

# Medium priority (Messaging, Streaming)
add name="Messaging" parent=Total packet-mark=messaging priority=2 max-limit=50M
add name="Streaming" parent=Total packet-mark=streaming priority=3 max-limit=70M

# Low priority (Downloads, Others)
add name="Downloads" parent=Total packet-mark=downloads priority=8 max-limit=30M
add name="Others" parent=Total packet-mark=others priority=8 max-limit=100M

# ---------- NAT (safe, don’t touch PPPoE/IP) ----------
/ip firewall nat
:if ([:len [/ip firewall nat find comment="default-nat"]] = 0) do={
    add chain=srcnat action=masquerade out-interface-list=WAN comment="default-nat"
}

# ---------- DONE ----------
:log info "✅ QOS Script Loaded Successfully"
