#!/bin/bash
#-------------------------------------------------------#
#---名称------shell脚本获取github的host-----------------#
#---作者----------暮色音铃Twiyin0-----------------------#
#---时间------------2022年4月21日-----------------------#
#---版本---------------V2.0.0---------------------------#
#-------------------------------------------------------#

#使用方法:
#1、在同文件夹内新建一个文本文件命名为"gitPing.txt"
#2、给这个脚本添加x权限"chmod +x ping.sh"
#3、在hostname变量内修改/增加github或者其他的域名

#（可修改） hostname 数组: 每行一个，用引号括起来
hostname=(
"github.com"
"githubapp.com"
"api.github.com"
"live.github.com"
"github.community"
"codeload.github.com"
)

### @start
# 处理首个域名/文件复写
ip=`ping -c 1 ${hostname[0]} | grep -Eoe "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"`           #ping github且用正则表达式匹配规则
url=`echo $ip`                              #将ip改为字符串类型
echo -n ${url#* }" " > gitPing.txt          #截取字符串
echo -n ${hostname[0]} >> gitPing.txt       #保存到文件
unset ip                                    #删除变量，以免变量复用出bug
unset url                                   #删除变量，以免变量复用出bug

# 处理第二个及以后的域名
i=1                                         #计数变量，说实话没搞懂shell的if
len=${#hostname[@]}                         #获取数组长度
while(( $i<$len ))                          #进入循环（退出循环的条件）
do                                          #开始循环
    ip=`ping -c 1 ${hostname[$i]} | grep -Eoe "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"`           #用正则表达式匹配规则
    url=`echo $ip`                              #将ip改为字符串类型
    echo "" >> gitPing.txt                      #换行
    echo -n ${url#* }" " >> gitPing.txt         #截取字符串
    echo -n ${hostname[$i]} >> gitPing.txt      #保存到文件
    let "i++"                                   #增加计数
done                                            #结束循环

# 输出提示
echo Ping Finished!
### @end
#tips:
#推荐一款很好用的软件——nmap
#Nmap是一个网络连接端扫描软件，用来扫描网上电脑开放的网络连接端。确定哪些服务运行在哪些连接端，并且推断计算机运行哪个操作系统（这是亦称 fingerprinting）。它是网络管理员必用的软件之一，以及用以评估网络系统安全。
#也就是说通过这个可以扫描github下其他域名与host。但我懒得研究了..........
#CN-Nmap_link: http://www.nmap.com.cn/
#EN-Nmap_link: https://nmap.org/