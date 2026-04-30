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

#الامر التالي يتغير العنوان الخاص به على حسب عنوان id الخاص بvpn
#/zerotier
#set zt1 disabled=no disabled=no
#/zerotier interface
# add allow-default=yes allow-global=yes allow-managed=yes comment=vpn_zerotier \
 #   disabled=no instance=zt1 name=mangmentViaVPN network=743993800fd13c5f
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
/ip address
#الامر التالي يتغير العنوان الخاص به على حسب عنوان مزود الانترنت لديك
#add address=192.168.1.10/24 comment=defconf interface=wan1 network=\
    # 192.168.1.0
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

/ip dhcp-client
add interface=wan1 name=client1
# Interface not active
add interface=wan2 name=client2 use-peer-dns=no
/ip dhcp-server network
add address=10.10.0.0/22 dns-server=10.10.0.1 gateway=10.10.0.1
add address=192.168.99.0/24 comment="Management Network" dns-none=yes \
    gateway=192.168.99.1
/ip dns
/ip dns
set allow-remote-requests=yes \
    cache-size=32768KiB \
    max-udp-packet-size=1232 \
    servers=1.1.1.1,1.0.0.1,8.8.8.8,8.8.4.4
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

add chain=input action=accept protocol=tcp dst-port=53 in-interface-list=LAN comment="Allow DNS TCP"
  
add action=accept chain=input comment="WireGuard VPN" dst-port=51820 \
    protocol=udp
/ip firewall filter
add chain=input protocol=tcp connection-state=new \
psd=21,3s,3,1 action=add-src-to-address-list \
address-list=port_scanners address-list-timeout=1d comment="Detect Port Scan"
add action=drop chain=input comment="Drop WAN Access" in-interface-list=WAN
add action=accept chain=forward comment="Allow Established/Related" \
    connection-state=established,related
add action=drop chain=forward comment="Drop Invalid" connection-state=invalid
add action=drop chain=forward comment="Drop All"
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
add action=masquerade chain=srcnat comment="VPN NAT" out-interface=mangmentViaVPN
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
/ip service
set www address=192.168.99.0/24
set winbox address=192.168.99.0/24,192.168.192.0/24
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

