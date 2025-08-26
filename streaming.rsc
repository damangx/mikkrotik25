# streaming.rsc - Address-list entries for Streaming
:log info "Importing streaming list"
/ip firewall address-list add list=Streaming address=youtube.com comment="YouTube"
/ip firewall address-list add list=Streaming address=googlevideo.com comment="YouTube CDN/googlevideo"
/ip firewall address-list add list=Streaming address=tiktokcdn.com comment="TikTok CDN"
/ip firewall address-list add list=Streaming address=netflix.com comment="Netflix"
/ip firewall address-list add list=Streaming address=viu.com comment="Viu"
/ip firewall address-list add list=Streaming address=bilibili.com comment="Bilibili"
/ip firewall address-list add list=Streaming address=fbcdn.net comment="Facebook Video CDN"
