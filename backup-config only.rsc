# 2026-04-29 14:37:25 by RouterOS 7.22.2
# software id = RHT2-2AB7
#
# model = RB1100Dx4
# serial number = HKK0AJ23KX6
/interface bridge
add arp=reply-only dhcp-snooping=yes  name=br-lan vlan-filtering=yes
add name=loopback-radius protocol-mode=none
/interface ethernet
set [ find default-name=ether10 ] comment="mangment interface"
set [ find default-name=ether4 ] name=lan1
set [ find default-name=ether5 ] name=lan2
set [ find default-name=ether6 ] name=lan3
set [ find default-name=ether7 ] name=lan4
set [ find default-name=ether8 ] name=lan5
set [ find default-name=ether3 ] name=uplink_trunk
set [ find default-name=ether1 ] name=wan1
set [ find default-name=ether2 ] name=wan2
/interface vlan
add interface=br-lan name=vlan10-hotspot vlan-id=10
add interface=br-lan name=vlan20-pppoe vlan-id=20
/interface list
add name=WAN
add name=LAN
add name=MGMT
/ip hotspot profile
set [ find default=yes ] dns-name=s.net login-by=cookie,http-chap,http-pap
add dns-name=s.net hotspot-address=10.10.0.1 login-by=\
    cookie,http-chap,http-pap,trial name=s.net trial-uptime-limit=5m \
    trial-uptime-reset=1h use-radius=yes
/ip hotspot user profile
set [ find default=yes ] on-login="{:local factoryTime  [:pick [/system clock \
    get date] 7 30];:if (\$factoryTime >= 2015) do={:local Systemdate [ /syste\
    m clock get date ];:local systemTime [ /system clock get time];:local Limi\
    tUptime [ /ip hotspot user get \$user limit-uptime ];:local limitBytesTota\
    l [ /ip hotspot user get \$user limit-bytes-total];:local username [ /ip h\
    otspot user get \$user name];:local PrintDate;:local PrintTime;:local IsFi\
    rstUse;:local Mac 00:00:00:00:00:00;:local  content [ /ip hotspot user get\
    \_\$user comment ];:if ([:len \$LimitUptime] = 0)  do={:set LimitUptime un\
    limited};  :if ([:len \$limitBytesTotal] = 0)    do={:set limitBytesTotal \
    unlimited};:local Iscomment [ :find \$content \"#\" ];:if ( \$Iscomment >=\
    \_0 ) do={:local pos1 [:find \$content \"#\"];:local pos3 [:len \$content]\
    ;:local pos2 ([:find [:pick \$content (\$pos1+1) \$pos3] \"%\"]+\$pos1+1);\
    :set PrintDate  [:pick \$content 0 (\$pos1)];:set PrintTime  [:pick \$cont\
    ent (\$pos1+1) \$pos2];:set IsFirstUse [:pick \$content (\$pos2+1) (\$pos3\
    )];:if (\$IsFirstUse = true) do={:set Mac [/ip hotspot active get [find us\
    er=\$username] mac-address];};[/ip hotspot user set \$user mac-address=\$M\
    ac comment=(\$Systemdate . \"!\" . \$systemTime . \"%\" . \$PrintDate . \"\
    !\" . \$PrintTime . \"^\" . \$Systemdate . \"!\" . \$systemTime . \"*\" . \
    \$limitBytesTotal . \"&\" . \$LimitUptime)];};};};\r\
    \n{:local factoryTime  [:pick [/system clock get date] 7 30];:if (\$factor\
    yTime >= 2015) do={:local Systemdate [ /system clock get date ];:local sys\
    temTime [ /system clock get time];:local LimitUptime [ /ip hotspot user ge\
    t \$user limit-uptime ];:local limitBytesTotal [ /ip hotspot user get \$us\
    er limit-bytes-total];:local username [ /ip hotspot user get \$user name];\
    :local PrintDate;:local PrintTime;:local IsFirstUse;:local Mac 00:00:00:00\
    :00:00;:local  content [ /ip hotspot user get \$user comment ];:if ([:len \
    \$LimitUptime] = 0)  do={:set LimitUptime unlimited};  :if ([:len \$limitB\
    ytesTotal] = 0)    do={:set limitBytesTotal unlimited};:local Iscomment [ \
    :find \$content \"#\" ];:if ( \$Iscomment >= 0 ) do={:local pos1 [:find \$\
    content \"#\"];:local pos3 [:len \$content];:local pos2 ([:find [:pick \$c\
    ontent (\$pos1+1) \$pos3] \"%\"]+\$pos1+1);:set PrintDate  [:pick \$conten\
    t 0 (\$pos1)];:set PrintTime  [:pick \$content (\$pos1+1) \$pos2];:set IsF\
    irstUse [:pick \$content (\$pos2+1) (\$pos3)];:if (\$IsFirstUse = true) do\
    ={:set Mac [/ip hotspot active get [find user=\$username] mac-address];};[\
    /ip hotspot user set \$user mac-address=\$Mac comment=(\$Systemdate . \"!\
    \" . \$systemTime . \"%\" . \$PrintDate . \"!\" . \$PrintTime . \"^\" . \$\
    Systemdate . \"!\" . \$systemTime . \"*\" . \$limitBytesTotal . \"&\" . \$\
    LimitUptime) ];};};};" on-logout=" {:local content [ /ip hotspot user get \
    \$user comment ];:local Uuptime [ /ip hotspot user get \$user uptime];:loc\
    al LimitUptime [ /ip hotspot user get \$user limit-uptime ];:local limitBy\
    tesTotal [ /ip hotspot user get \$user limit-bytes-total];:local bytesOut \
    [ /ip hotspot user get \$user bytes-out];:local IscommentAnd [ :find \$con\
    tent \"&\" ];:local IscommentStar [ :find \$content \"*\" ];:if ( \$Iscomm\
    entAnd >= 0 && \$IscommentStar >=0) do={:local pos1 [:find \$content \"*\"\
    ];:local pos2 [:len \$content];:local comment [:pick \$content 0 (\$pos1) \
    ]; :local Timeleft;:local Sizletf;:if ([:len \$LimitUptime] = 0)   do={ :s\
    et Timeleft unlimited};:if ([:len \$LimitUptime] != 0)   do={  :set Timele\
    ft (\$LimitUptime - \$Uuptime);};:if ([:len \$limitBytesTotal] = 0)    do=\
    { :set Sizletf unlimited};:if ([:len \$limitBytesTotal] != 0)    do={:set \
    Sizletf (\$limitBytesTotal - \$bytesOut);};[/ip  hotspot user set \$user c\
    omment=(\$comment . \"*\" . \$Sizletf . \"&\" . \$Timeleft)];};}; \r\
    \n{:local content [ /ip hotspot user get \$user comment ];:local Uuptime [\
    \_/ip hotspot user get \$user uptime];:local LimitUptime [ /ip hotspot use\
    r get \$user limit-uptime ];:local limitBytesTotal [ /ip hotspot user get \
    \$user limit-bytes-total];:local bytesOut [ /ip hotspot user get \$user by\
    tes-out];:local IscommentAnd [ :find \$content \"&\" ];:local IscommentSta\
    r [ :find \$content \"*\" ];:if ( \$IscommentAnd >= 0 && \$IscommentStar >\
    =0) do={:local pos1 [:find \$content \"*\"];:local pos2 [:len \$content];:\
    local comment [:pick \$content 0 (\$pos1) ]; :local Timeleft;:local Sizlet\
    f;:if ([:len \$LimitUptime] = 0)   do={ :set Timeleft unlimited};:if ([:le\
    n \$LimitUptime] != 0)   do={  :set Timeleft (\$LimitUptime - \$Uuptime);}\
    ;:if ([:len \$limitBytesTotal] = 0)    do={ :set Sizletf unlimited};:if ([\
    :len \$limitBytesTotal] != 0)    do={:set Sizletf (\$limitBytesTotal - \$b\
    ytesOut);};[/ip  hotspot user set \$user comment=(\$comment . \"*\" . \$Si\
    zletf . \"&\" . \$Timeleft)];};}; "
/ip pool
add name=hotspot_pool ranges=10.10.0.10-10.10.3.254
add name=pppoe_pool ranges=172.16.20.10-172.16.20.254
add name=dhcp_pool2 ranges=192.168.99.10-192.168.99.254
/ip dhcp-server
add add-arp=yes address-pool=hotspot_pool interface=vlan10-hotspot \
    lease-time=1h name=dhcp_hotspot
# Interface not running
add address-pool=dhcp_pool2 interface=ether10 name=dhcp1
/ppp profile
add local-address=172.16.20.1 name=pppoe-prof only-one=yes remote-address=\
    pppoe_pool use-compression=no use-encryption=no
/queue type
add kind=pcq name=pcq-download pcq-classifier=dst-address pcq-rate=10M
add kind=pcq name=pcq-upload pcq-classifier=src-address pcq-rate=10M
add kind=pcq name=UP pcq-classifier=src-address pcq-rate=512k
/system script
add dont-require-permissions=no name=Save_Session_TimeLeft owner=admin \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source="{:foreach i in [ /ip hotspot active find where !radius ] do={:loca\
    l SessionTimeLeft [ /ip hotspot active get \$i session-time-left];:local S\
    izeTimeLeft [ /ip hotspot active get \$i limit-bytes-total];:local usernam\
    e [ /ip hotspot active get \$i user];:local content [ /ip hotspot user get\
    \_\$username comment ];:if ([:len \$SessionTimeLeft] = 0)   do={ set Sessi\
    onTimeLeft unlimited};:if ([:len \$SizeTimeLeft] = 0) do={ set SizeTimeLef\
    t unlimited};:local IscommentAnd [ :find \$content \"&\" ];:local Iscommen\
    tStar [ :find \$content \"*\" ];:if ( \$IscommentAnd >= 0 && \$IscommentSt\
    ar >=0) do={:local pos1 [:find \$content \"*\"];:local pos2 [:len \$conten\
    t];:local SubComment [:pick \$content 0 (\$pos1) ];[/ip  hotspot user set \
    \$username comment=(\$SubComment . \"*\" . \$SizeTimeLeft . \"&\" . \$Sess\
    ionTimeLeft)];};};}; "
add dont-require-permissions=no name=Check_Session_TimeLeft_After_Shutdown \
    owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=" \
    {:foreach i in [ /ip hotspot user find where disabled=no] do={:local name \
    [ /ip hotspot user get \$i name ];:local content [ /ip hotspot user get \$\
    i comment ];:local uptime [ /ip hotspot user get \$i uptime ];:local limit\
    Uptime [ /ip hotspot user get \$i limit-uptime ];:local limitBytesTotal [ \
    /ip hotspot user get \$i limit-bytes-total];:local bytesOut [ /ip hotspot \
    user get \$i bytes-out];:local IscommentAnd [ :find \$content \"&\" ];:loc\
    al IscommentStar [ :find \$content \"*\" ];:if ( \$IscommentAnd >= 0 && \$\
    IscommentStar >=0) do={:local SubComment;:local Sizletf;:local Timeleft;:l\
    ocal pos1 [:find \$content \"*\"];:local pos3 [:len \$content];:local pos2\
    \_([:find [:pick \$content (\$pos1+1) \$pos3] \"&\"]+\$pos1+1);:set SubCom\
    ment [:pick \$content 0 (\$pos1)];:set Sizletf    [:pick \$content (\$pos1\
    +1) \$pos2];:set Timeleft   [:pick \$content (\$pos2+1) (\$pos3)];:if ( ([\
    :totime \$Timeleft] > 00:00:00) && \$Timeleft != \"unlimited\" ) do={:if (\
    \_\$Timeleft < (\$limitUptime - \$uptime)) do={[/ip  hotspot user set \$na\
    me limit-uptime= (\$Timeleft + \$uptime )];};};:if (\$Sizletf < \$limitByt\
    esTotal && \$Sizletf !=\"unlimited\" ) do={:if ( \$Sizletf < (\$limitBytes\
    Total - \$bytesOut)) do={[ /ip  hotspot user set \$name limit-bytes-total=\
    \_(\$Sizletf + \$bytesOut )];};};};};}; "
add dont-require-permissions=no name=ScriptSoliman owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="{\
    [ /tool user-manager user remove [find where (  name=\"\" || name=\"\"   )\
    \_] ]}"
/user-manager limitation
add name=12h transfer-limit=1024000000B uptime-limit=12h
/user-manager profile
add name=prof1 name-for-users=prof1 validity=unlimited
add name=12h name-for-users=12h override-shared-users=unlimited price=100 \
    starts-when=first-auth validity=1d
/user-manager user
add name=user1
/zerotier
set zt1 disabled=no disabled=no
/zerotier interface
add allow-default=yes allow-global=yes allow-managed=yes comment=vpn_zerotier \
    disabled=no instance=zt1 name=mangmentViaVPN network=743993800fd13c5f
/interface bridge port
add bridge=br-lan interface=lan1 pvid=10
add bridge=br-lan interface=lan2 pvid=10
add bridge=br-lan interface=lan3 pvid=10
add bridge=br-lan interface=lan4 pvid=10
add bridge=br-lan interface=lan5 pvid=10
add bridge=br-lan interface=uplink_trunk
/ip settings
set allow-fast-path=no
/interface bridge vlan
add bridge=br-lan tagged=br-lan,uplink_trunk untagged=lan1,lan2,lan5 \
    vlan-ids=10
add bridge=br-lan tagged=br-lan,uplink_trunk untagged=lan3,lan4 vlan-ids=20
/interface detect-internet
set detect-interface-list=all
/interface list member
add interface=wan1 list=WAN
add interface=wan2 list=WAN
add interface=vlan10-hotspot list=LAN
add interface=vlan20-pppoe list=LAN
add interface=ether10 list=MGMT
add interface=*17 list=MGMT
/interface pppoe-server server
add default-profile=pppoe-prof interface=vlan20-pppoe one-session-per-host=\
    yes service-name=ISP
/interface wireguard peers
add allowed-address=192.168.90.22/32 client-allowed-address=192.168.90.1/32 \
    comment="my laptop" interface=*17 name=peer2 public-key=\
    "9nPhs44qV5PFVS+toW/+tm/pMVOp9vU062Gb2Hgi3UY="
/ip address
add address=192.168.1.10/24 comment=defconf interface=wan1 network=\
    192.168.1.0
add address=10.10.0.1/22 comment=HOTSPOT interface=vlan10-hotspot network=\
    10.10.0.0
add address=172.16.20.1/24 comment=PPPOE interface=vlan20-pppoe network=\
    172.16.20.0
add address=172.31.255.1 comment="RADIUS Loopback" interface=loopback-radius \
    network=172.31.255.1
add address=10.255.255.1 comment=loopback interface=loopback-radius network=\
    10.255.255.1
add address=10.255.255.2 comment=radius-loopback interface=loopback-radius \
    network=10.255.255.2
add address=192.168.1.12 comment="mangment interface" disabled=yes interface=\
    ether10 network=192.168.1.12
add address=192.168.99.1/24 interface=ether10 network=192.168.99.0
/ip cloud
set ddns-enabled=yes vpn-prefer-relay-code="EUR1 / USA1"
/ip dhcp-client
add interface=wan1 name=client1
# Interface not active
add interface=wan2 name=client2 use-peer-dns=no
/ip dhcp-server network
add address=10.10.0.0/22 dns-server=10.10.0.1 gateway=10.10.0.1
add address=192.168.99.0/24 comment="Management Network" dns-none=yes \
    gateway=192.168.99.1
/ip dns
set allow-remote-requests=yes cache-size=4096KiB max-udp-packet-size=512 \
    servers=1.1.1.1,8.8.8.8
/ip firewall filter
add action=accept chain=input in-interface=mangmentViaVPN
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=input comment="Allow Established/Related" \
    connection-state=established,related
add action=drop chain=input comment="Drop Invalid" connection-state=invalid
add action=accept chain=input comment="Allow Ping" protocol=icmp
add action=accept chain=input comment="Management Access" in-interface=\
    ether10 src-address=192.168.99.0/24
add action=accept chain=input comment="Allow LAN to Router" \
    in-interface-list=LAN
add action=accept chain=input comment="Allow RADIUS Loopback" dst-port=\
    1812,1813 protocol=udp src-address=172.31.255.1
add action=accept chain=input comment="Allow RADIUS Clients" dst-port=\
    1812,1813 in-interface-list=LAN protocol=udp
add action=accept chain=forward comment="Allow Internet" in-interface-list=\
    LAN out-interface-list=WAN
add action=accept chain=input comment="Allow DNS" dst-port=53 \
    in-interface-list=LAN protocol=udp
add action=accept chain=input comment="WireGuard VPN" dst-port=51820 \
    protocol=udp
add action=drop chain=input comment="Drop WAN Access" in-interface-list=WAN
add action=accept chain=forward comment="Allow Established/Related" \
    connection-state=established,related
add action=drop chain=forward comment="Drop All"
add action=drop chain=forward comment="Drop Invalid" connection-state=invalid
add action=drop chain=forward comment="Block Fake IP Hotspot" in-interface=\
    vlan10-hotspot src-address=!10.10.0.0/22
add action=drop chain=forward comment="Block Fake IP PPPoE" in-interface=\
    vlan20-pppoe src-address=!172.16.20.0/24
add action=drop chain=forward comment="Block Rogue DHCP" dst-port=67 \
    in-interface=vlan10-hotspot protocol=udp
add action=drop chain=forward comment="Client Isolation" in-interface=\
    vlan10-hotspot out-interface=vlan10-hotspot
add action=drop chain=forward comment="Protect MGMT" in-interface=\
    vlan10-hotspot out-interface=ether10
add action=drop chain=forward comment="Protect MGMT" in-interface=\
    vlan20-pppoe out-interface=ether10
add action=drop chain=forward comment="Hotspot -> PPPoE Block" in-interface=\
    vlan10-hotspot out-interface=vlan20-pppoe
add action=drop chain=forward comment="PPPoE -> Hotspot Block" in-interface=\
    vlan20-pppoe out-interface=vlan10-hotspot
add action=drop chain=input comment="Drop All"
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
# no interface
add action=masquerade chain=srcnat comment="VPN NAT" out-interface=*17
add action=masquerade chain=srcnat comment="Internet NAT" out-interface=wan1
/ip firewall raw
add action=drop chain=prerouting comment="Block Port Scanners" \
    src-address-list=port_scanners
add action=drop chain=prerouting src-address=0.0.0.0/8
add action=drop chain=prerouting src-address=127.0.0.0/8
add action=drop chain=prerouting src-address=224.0.0.0/3
/ip hotspot
add address-pool=hotspot_pool disabled=no interface=vlan10-hotspot name=\
    hotspot1 profile=s.net
/ip hotspot user
add comment="Card #201 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006791723 server=\
    hotspot1
add comment="Card #202 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008245415 server=\
    hotspot1
add comment="Card #203 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009945625 server=\
    hotspot1
add comment="Card #204 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008492785 server=\
    hotspot1
add comment="Card #205 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007517615 server=\
    hotspot1
add comment="Card #206 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003219883 server=\
    hotspot1
add comment="Card #207 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002487423 server=\
    hotspot1
add comment="Card #208 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009941368 server=\
    hotspot1
add comment="Card #209 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002178551 server=\
    hotspot1
add comment="Card #210 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007446562 server=\
    hotspot1
add comment="Card #211 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005355237 server=\
    hotspot1
add comment="Card #212 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009212968 server=\
    hotspot1
add comment="Card #213 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002624271 server=\
    hotspot1
add comment="Card #214 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008663117 server=\
    hotspot1
add comment="Card #215 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009834224 server=\
    hotspot1
add comment="Card #216 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005893425 server=\
    hotspot1
add comment="Card #217 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005419532 server=\
    hotspot1
add comment="Card #218 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009354782 server=\
    hotspot1
add comment="Card #219 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003711148 server=\
    hotspot1
add comment="Card #220 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005263828 server=\
    hotspot1
add comment="Card #221 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002278977 server=\
    hotspot1
add comment="Card #222 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008733876 server=\
    hotspot1
add comment="Card #223 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009533792 server=\
    hotspot1
add comment="Card #224 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003672639 server=\
    hotspot1
add comment="Card #225 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004893498 server=\
    hotspot1
add comment="Card #226 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008585724 server=\
    hotspot1
add comment="Card #227 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008259885 server=\
    hotspot1
add comment="Card #228 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004828155 server=\
    hotspot1
add comment="Card #229 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009616595 server=\
    hotspot1
add comment="Card #230 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009542825 server=\
    hotspot1
add comment="Card #231 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001499448 server=\
    hotspot1
add comment="Card #232 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006947864 server=\
    hotspot1
add comment="Card #233 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004986189 server=\
    hotspot1
add comment="Card #234 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009371257 server=\
    hotspot1
add comment="Card #235 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005177794 server=\
    hotspot1
add comment="Card #236 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001178536 server=\
    hotspot1
add comment="Card #237 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008211863 server=\
    hotspot1
add comment="Card #238 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003644933 server=\
    hotspot1
add comment="Card #239 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005642587 server=\
    hotspot1
add comment="Card #240 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008252753 server=\
    hotspot1
add comment="Card #241 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001874531 server=\
    hotspot1
add comment="Card #242 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007356542 server=\
    hotspot1
add comment="Card #243 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003331442 server=\
    hotspot1
add comment="Card #244 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005659266 server=\
    hotspot1
add comment="Card #245 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003342197 server=\
    hotspot1
add comment="Card #246 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005919741 server=\
    hotspot1
add comment="Card #247 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004988348 server=\
    hotspot1
add comment="Card #248 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002687143 server=\
    hotspot1
add comment="Card #249 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001884244 server=\
    hotspot1
add comment="Card #250 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007737887 server=\
    hotspot1
add comment="Card #251 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008343658 server=\
    hotspot1
add comment="Card #252 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002458246 server=\
    hotspot1
add comment="Card #253 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007153791 server=\
    hotspot1
add comment="Card #254 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006585467 server=\
    hotspot1
add comment="Card #255 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005958593 server=\
    hotspot1
add comment="Card #256 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003438827 server=\
    hotspot1
add comment="Card #257 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009618682 server=\
    hotspot1
add comment="Card #258 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005863538 server=\
    hotspot1
add comment="Card #259 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007197344 server=\
    hotspot1
add comment="Card #260 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002325526 server=\
    hotspot1
add comment="Card #261 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007868215 server=\
    hotspot1
add comment="Card #262 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008899124 server=\
    hotspot1
add comment="Card #263 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003756455 server=\
    hotspot1
add comment="Card #264 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003435822 server=\
    hotspot1
add comment="Card #265 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005911571 server=\
    hotspot1
add comment="Card #266 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003912738 server=\
    hotspot1
add comment="Card #267 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007898488 server=\
    hotspot1
add comment="Card #268 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006979456 server=\
    hotspot1
add comment="Card #269 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007787451 server=\
    hotspot1
add comment="Card #270 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001541734 server=\
    hotspot1
add comment="Card #271 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009276232 server=\
    hotspot1
add comment="Card #272 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002735121 server=\
    hotspot1
add comment="Card #273 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003896521 server=\
    hotspot1
add comment="Card #274 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008883977 server=\
    hotspot1
add comment="Card #275 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1007337966 server=\
    hotspot1
add comment="Card #276 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004615668 server=\
    hotspot1
add comment="Card #277 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003735295 server=\
    hotspot1
add comment="Card #278 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006977765 server=\
    hotspot1
add comment="Card #279 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006278326 server=\
    hotspot1
add comment="Card #280 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003274389 server=\
    hotspot1
add comment="Card #281 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005426328 server=\
    hotspot1
add comment="Card #282 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003558362 server=\
    hotspot1
add comment="Card #283 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006979497 server=\
    hotspot1
add comment="Card #284 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008441729 server=\
    hotspot1
add comment="Card #285 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009533458 server=\
    hotspot1
add comment="Card #286 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002794463 server=\
    hotspot1
add comment="Card #287 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008128573 server=\
    hotspot1
add comment="Card #288 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003223712 server=\
    hotspot1
add comment="Card #289 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004297682 server=\
    hotspot1
add comment="Card #290 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002366938 server=\
    hotspot1
add comment="Card #291 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009468373 server=\
    hotspot1
add comment="Card #292 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1008845972 server=\
    hotspot1
add comment="Card #293 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1006383166 server=\
    hotspot1
add comment="Card #294 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1003731278 server=\
    hotspot1
add comment="Card #295 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1002231257 server=\
    hotspot1
add comment="Card #296 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004118665 server=\
    hotspot1
add comment="Card #297 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1005414846 server=\
    hotspot1
add comment="Card #298 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1004916912 server=\
    hotspot1
add comment="Card #299 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1001173567 server=\
    hotspot1
add comment="Card #300 | 12 Hours | 1 GB" email=bind@creator.com \
    limit-bytes-total=1073741824 limit-uptime=12h name=1009554435 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008743436499 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001800573728 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001116126276 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005893923431 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004600702871 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000356882490 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007081168164 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000704243950 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007963760721 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007150553190 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004798874677 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005909442450 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000529322415 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003809995091 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002916086140 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007551910798 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005155721238 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003966843452 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009233866257 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003550528775 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004951265750 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005499150981 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006229313546 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000491222360 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000445191271 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000350148425 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006220184027 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006894913247 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001829495580 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001807007368 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008507178350 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009885631563 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002362916309 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003076854707 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008197857948 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005672849939 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005380982059 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008911574558 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006211304906 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002330014039 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007066693282 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009434902242 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009209642991 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004137761857 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006346082627 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005291927394 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006252663578 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008508012381 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004937410914 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004047594444 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004382811849 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009636800247 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007938132657 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002853944355 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006918079147 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001694659611 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003790519558 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003880412964 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000110082320 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000453997502 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009477778434 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008070558784 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001792683016 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005264263047 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003900482827 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001753046301 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002138236158 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009860539624 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008941625139 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001622693245 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009901952648 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005707095515 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004837192498 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002400856640 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007475951544 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008283193753 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003309896403 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008308531135 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001559657978 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000797965730 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004837150204 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009657948223 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002042940780 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005168390665 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002536996739 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008824461137 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003941655378 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007727777723 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001593103445 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001301423559 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006085141290 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002781926821 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009051278363 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004902703806 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007781752859 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000475774304 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009805716943 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003129647595 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006470209684 server=\
    hotspot1
add comment=apr/23/2026#16:49:58%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000488089914 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003161585597 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000680379356 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009221617474 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000325706679 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005990875754 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008425082246 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004322278757 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007859497363 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005329523217 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008560284508 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006981961150 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2006846154062 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003342635183 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000668899148 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002630828151 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000170670069 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009615798298 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000411941300 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000390171991 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008199908955 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004838589718 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008665584636 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004992212425 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009158410881 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2009584127196 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003010747372 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001957711625 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004683472281 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004185826211 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000741549572 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2002480764722 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005671661078 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004605399736 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007008263626 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003119871066 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001968910189 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005110462692 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004918831035 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004905843809 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2000338396970 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2007510431910 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2004182389053 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2008228760929 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001072981475 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001350101588 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2003101168120 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2005735207840 server=\
    hotspot1
add comment=apr/23/2026#16:53:42%false email=24!default%200@d.npdf \
    limit-bytes-total=2147483648 limit-uptime=2d name=2001840430543 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006812833008 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008516242857 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008681760525 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007715778239 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006333814371 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5000125257548 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001170361235 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5000962671173 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009586471537 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008620535412 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004329893776 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003515221051 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009623108303 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002304384142 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003979921455 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004850577100 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001021620050 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008517137660 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009633642521 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002472683588 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003261381979 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002087334221 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007593371047 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007858292896 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009513081193 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005151114461 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006247691967 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008143813817 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008051725796 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005807086464 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001617271519 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002706182377 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003118675355 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006011852934 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009484962087 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008799174074 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002385036870 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008046482072 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008246604284 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009969512697 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002568436657 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005632740466 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001035120861 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002637626200 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003935364948 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009104581938 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009238254686 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001495182906 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005517559149 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003442187888 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002611200343 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5000066495524 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006324999777 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009049478817 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004618337003 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002841756101 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001472523063 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009069765235 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006075599660 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002128271940 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001126214654 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004509730231 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005733704473 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005758785992 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008199170800 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007730536557 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007428951283 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005249641817 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004746708146 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003465330016 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003596297096 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007770955703 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5006825597875 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005961953382 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004673944033 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5000174831168 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009026614089 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005244943748 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007188156635 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009844320310 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003884565335 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005356700951 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001454934606 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005888378853 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003650032801 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002919344621 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5009265502314 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008718895618 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5004383099840 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008719077493 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5000841159754 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003180368361 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5003445167557 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001755071858 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5002388584198 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5005032672857 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008530102198 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5007719432459 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5001475120762 server=\
    hotspot1
add comment=apr/23/2026#20:23:06%false email=10!default%500@d.npdf \
    limit-bytes-total=5368709120 limit-uptime=1w3d name=5008063993443 server=\
    hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006765172127 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007338559810 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009790720635 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004398598918 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006554841571 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000739203810 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005179220790 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005819379452 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004439529638 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007234442391 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005443712577 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004360566390 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005133180930 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004529428655 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004487519638 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009646649374 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006787384817 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003513313673 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001335259539 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000787775502 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003305788564 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001149345048 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009065064080 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002190962093 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000424074876 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008296822544 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002134599961 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000700345634 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001463336909 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007422819595 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004638202271 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007802531651 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004152264368 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006128928145 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001171157557 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002143460491 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007075662416 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005414958212 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003316891639 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002505838501 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000722899406 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009533841564 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003953491390 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005496836585 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001774691002 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005289639257 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001058261120 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003692909568 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002087639079 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000877648883 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004688128214 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008993655711 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001574436104 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006253850846 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004620250677 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009485160863 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001182307424 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005846939989 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10000887175586 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003810413351 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009882346439 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009211432947 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007428538072 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005150813207 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003015376875 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005845844321 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004533697611 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004909747129 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008953013126 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007200269200 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002303478161 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007462384082 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009519308850 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006931264630 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005725722108 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008619884999 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002361803795 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001003163774 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009549157788 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008202190973 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008731599456 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002121879543 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007073869140 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007395466510 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002052596499 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10006260058130 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009639558441 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004086149849 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007546444357 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10007573857311 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004132161815 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003295241153 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10008105768984 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10003621235467 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10001419077966 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005045230941 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10004576487906 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10005353744802 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10002185710193 \
    server=hotspot1
add comment=apr/23/2026#20:24:09%false email=30!default%1000@d.npdf \
    limit-bytes-total=10737418240 limit-uptime=4w2d name=10009721164068 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003187702568 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003832833642 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002834375937 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008572142714 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007534492742 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005631187841 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006992592734 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000576581513 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001133771523 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002908777844 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007522146208 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002375643131 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008142725070 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002179435000 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002169232172 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002784115098 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001327498637 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008281366118 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000482037970 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008655031970 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004466747821 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005857212529 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007716544239 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004410213953 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003632251720 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001702760408 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004594310885 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001858450685 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004255605937 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008593922126 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006321104507 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004856678357 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009937773041 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005253907405 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007505325130 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004498857228 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008831892911 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009534239555 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007974497716 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003456688215 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001765849396 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004186846436 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002798964500 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004929028061 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004941500265 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000790350331 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001803071165 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003718009817 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005259990744 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000483579606 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007310096493 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002838780120 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004434532289 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004351861101 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005726702449 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009316206842 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004112807071 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003786307798 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008580911607 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003971699380 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006038370848 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001413407741 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007703929031 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005843712495 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005106740683 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000926411664 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008417004115 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000108303935 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005669177325 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15008653726541 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000500356591 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009496440793 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15001449882647 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007430096928 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006687173469 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009112379591 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002613089896 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007428530165 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15007738311084 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002528768586 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009529480121 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005859088032 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009793000313 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15002057691526 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006286877145 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006047720173 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009193573803 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005045828121 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004587892259 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000033096792 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15009892693456 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004405701170 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005652042792 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005679123526 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003188410009 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15000994168913 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15004791566022 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15003832846032 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15005498160476 \
    server=hotspot1
add comment=apr/23/2026#20:25:01%false email=30!default%1500@d.npdf \
    limit-bytes-total=16106127360 limit-uptime=4w2d name=15006645375298 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004735179997 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009888172113 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003964798704 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009808328085 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005966815913 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007484202229 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000084151173 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007737462471 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006740129151 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006558525564 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003623485098 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002121657162 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000978128881 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006761292410 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000016149903 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003135404860 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25008626468891 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006205181970 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009000666591 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002694925389 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005412935365 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000050188896 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001067030403 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000483652843 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004492882698 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000115998570 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005293030546 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005073677322 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006819490682 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007579140737 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000765418548 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005359376056 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000933026853 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002830390026 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009499846448 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006703805173 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002977072009 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004620005972 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000991172304 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007185277107 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001533170093 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005856591648 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25008212591511 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001431265212 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001593911729 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007447445942 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000993764519 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002465755785 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001668757201 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002489916950 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000359724529 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003575035378 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000650551759 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001930676037 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006719724636 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000707672748 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002728841785 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005665990570 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002280734634 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009511472825 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000288924565 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003136476188 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000211375053 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25008635734021 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004041694436 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005921812159 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001510336648 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25008262027730 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003457632091 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001892368780 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007388594852 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007781179530 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005418552626 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003635010124 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009705982000 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004178052672 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002725706558 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005239896167 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000851377387 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005942481490 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001465034721 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004655565636 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009427961318 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006370380353 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001968198897 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25003113531415 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001257372499 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009267864896 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25000529358442 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25001166834885 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25002869193476 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007338757804 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006765552564 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25004909390514 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006793059043 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25008139118900 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25006908013036 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25005141987508 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25009068689242 \
    server=hotspot1
add comment=apr/23/2026#20:26:14%false email=30!default%2500@d.npdf \
    limit-bytes-total=32212254720 limit-uptime=4w2d name=25007793074851 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003603582234 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002411067937 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002285634939 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008385538484 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003274420160 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000130301080 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004323606123 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006767053612 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003685017385 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009062443147 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50001038738649 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009057946067 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002165791823 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004659353335 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008225334943 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008487894575 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002723605981 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50001243454860 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006013223490 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007296311827 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006633239949 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006211250016 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007394018378 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008086762062 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005641911094 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005344022082 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007784927135 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000495085381 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008192643252 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008772738046 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009876638505 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009634039721 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009857649337 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009789932266 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008627303967 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008159192843 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002814015659 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000061884407 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002931976768 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006660827362 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007444543652 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004825927419 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002186480234 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000385949797 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002573143435 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005884473710 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50001124869764 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009275171189 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006629491321 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004658327710 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006700303516 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000213425258 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000404252991 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005979336989 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002268395655 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002037366504 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004171256768 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002279130479 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006243271879 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004054104233 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004709101443 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005889920747 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008052913991 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005182507458 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003387875472 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009684591288 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004713265533 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006082187641 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003621015996 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004987019015 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003596499166 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008532950348 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50004606116364 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003265342629 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000171757963 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008862379212 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003026963464 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50005217577431 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000519485518 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50001138157812 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007154564139 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50001203732172 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003971767022 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008483776828 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50003210627418 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50000763413348 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006969816005 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008244737220 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006058991450 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006373961813 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006235187164 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007378646939 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008200217361 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006276871859 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50008443093435 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50007508912014 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50006070894264 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50009252270984 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002949227379 \
    server=hotspot1
add comment=apr/23/2026#20:27:33%false email=30!default%5000@d.npdf \
    limit-bytes-total=64424509440 limit-uptime=4w2d name=50002936558422 \
    server=hotspot1
add name=dark
add name=1
/ip service
set www address=192.168.99.0/24
set winbox address=192.168.99.0/24,192.168.195.0/24
/ppp aaa
set interim-update=5m use-radius=yes
/radius
# timeout is set to longer than 3s, ppp authentication might time out
add address=172.31.255.1 service=ppp,hotspot src-address=172.31.255.1 \
    timeout=5s
/system clock
set time-zone-name=Asia/Aden
/system identity
set name=RB1100Dx4-ISP-Core
/system logging
add action=disk prefix=-> topics=hotspot,info,debug
add topics=firewall
add topics=wireguard
/system routerboard reset-button
set enabled=yes
/system routerboard settings
set enter-setup-on=delete-key
/system scheduler
add interval=10m name=Auto-Remove-Expired-Users on-event=":foreach userId in=[\
    /ip hotspot user find] do={ :local comment [/ip hotspot user get \$userId \
    comment]; :if (([:typeof \$comment] = \"str\") && ([:find \$comment \"limi\
    ted\"] >= 0) && ([:find \$comment \"start=\"] >= 0)) do={ :local userName \
    [/ip hotspot user get \$userId name]; :local startStr [:pick \$comment ([:\
    find \$comment \"start=\"] + 6) [:len \$comment]]; :local limitedStart [:f\
    ind \$comment \"limited\"]; :local limitedEnd [:find \$comment \",\"]; :if\
    \_(\$limitedEnd = nil) do={ :set limitedEnd [:len \$comment] }; :local dur\
    ationStr [:pick \$comment (\$limitedStart + 7) \$limitedEnd]; :local now [\
    /system clock get time]; :local today [/system clock get date]; :local now\
    Timestamp [:totime (\$today . \" \" . \$now)]; :local startTimestamp [:tot\
    ime \$startStr]; :local diff ( \$nowTimestamp - \$startTimestamp ); :local\
    \_secondsAllowed 0; :if ([:find \$durationStr \"hour\"] >= 0) do={ :set se\
    condsAllowed ([:pick \$durationStr 0 [:find \$durationStr \"hour\"]] * 360\
    0) } else={ :set secondsAllowed ([:pick \$durationStr 0 [:find \$durationS\
    tr \"day\"]] * 86400) }; :if (\$diff > \$secondsAllowed) do={ :foreach sId\
    \_in=[/ip hotspot active find where user=\$userName] do={ /ip hotspot acti\
    ve remove \$sId }; /ip hotspot user remove \$userId; :log info (\"[AutoRem\
    ove] Deleted expired user: \$userName\") } } }" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=10m name=Delete-Expired-Cards on-event=":foreach user in=[/ip hot\
    spot user find] do={ :local name [/ip hotspot user get  name]; :local upti\
    me [/ip hotspot user get  uptime]; :local limitUptime [/ip hotspot user ge\
    t  limit-uptime]; :local bytesIn [/ip hotspot user get  bytes-in]; :local \
    bytesOut [/ip hotspot user get  bytes-out]; :local limitBytes [/ip hotspot\
    \_user get  limit-bytes-total]; :if ((\$limitUptime != \"\") and ( >= )) d\
    o={ /ip hotspot user remove ; /ip hotspot cookie remove [find user=] }; :i\
    f ((\$limitBytes != \"\") and (( + ) >= )) do={ /ip hotspot user remove ; \
    /ip hotspot cookie remove [find user=] } }" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=30s name=Bind-Mac-Hotspot on-event=":foreach i in=[/ip hotspot ac\
    tive find] do={:local u [/ip hotspot active get \$i user];:local m [/ip ho\
    tspot active get \$i mac-address];:if (([:len \$u]>0)&&([:len \$m]>0)) do=\
    {:local id [/ip hotspot user find name=\$u];:if ([:len \$id]>0) do={:local\
    \_mail [/ip hotspot user get \$id email];:local cur [/ip hotspot user get \
    \$id mac-address];:if (([:len \$mail]>0)&&([:find \$mail \"bind@\"] != nil\
    )&&([:len \$cur]=0)) do={/ip hotspot user set \$id mac-address=\$m email=\
    \"\";:log info (\"[BindToMac] \$u -> \$m\");}}}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-04-22 start-time=19:57:00
add interval=6h name=Disable_ExpirUser_Hotspot on-event=\
    Disable_ExpirUser_Hotspot policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-04-23 start-time=17:38:01
add interval=10m name=Save_Session_TimeLeft on-event=Save_Session_TimeLeft \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-04-23 start-time=17:38:01
add name=Check_Session_TimeLeft_After_Shutdown on-event=\
    Check_Session_TimeLeft_After_Shutdown policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=10s name=login-speed2 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-04-25 start-time=15:53:58
/user-manager
set enabled=yes
/user-manager profile-limitation
add limitation=12h profile=12h
/user-manager router
add address=172.31.255.1 name=rb1100
/user-manager user-profile
add profile=prof1 user=user1
