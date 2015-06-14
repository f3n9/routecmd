#!/bin/sh

#rule 23.21.134.0/24 name dl-web.dropbox.com
#rule 31.13.0.0/16 name www.facebook.com
#rule 52.4.0.0/14 name ms*.slack-msgs.com
#rule 54.164.246.0/24 name slack.com
#rule 54.173.140.113/32 name evernote.slack.com
#rule 54.208.38.56/32 name evernote.slack.com
#rule 54.208.69.0/24 name slack.com
#rule 54.209.168.0/24 name slack.com
#rule 54.231.0.0/16 name s3.amazonaws.com
#rule 54.236.247.54/32 name evernote.slack.com
#rule 64.18.0.0/20
#rule 64.233.160.0/19
#rule 66.102.0.0/20
#rule 66.249.80.0/20
#rule 74.112.64.0/21 name silverpop
#rule 74.112.69.0/24 name engage5.silverpop.com
#rule 74.125.0.0/16
#rule 74.208.46.0/24 name streak.com
#rule 96.43.144.0/20 name saleforce
#rule 103.245.222.0/24 name slack.global.ssl.fastly.net
#rule 107.23.22.129/32 name evernote.slack.com
#rule 108.160.164.0/22 name dropbox.com
#rule 108.174.2.0/24 name slideshare.net
#rule 131.103.26.0/24 name jira
#rule 170.149.168.0/21 name nytimes.com
#rule 173.194.0.0/16
#rule 176.32.99.0/24 name evernote.s3.amazonaws.com
#rule 192.0.80.0/24 name slack.com
#rule 192.161.147.0/24 name yxbj.zendesk.com
#rule 198.252.206.0/24
#rule 199.59.243.0/24 name instgram.com
#rule 207.126.144.0/20
#rule 209.85.128.0/17
#rule 209.177.160.0/20 name myworkday.com
#rule 216.58.221.0/24 name accounts.google.com
#rule 216.104.243.0/24 name stage.evernote.com
#rule 216.239.32.0/19

vpngw=192.168.7.1
tid=200

#remove all existing rules in table 10
retval=0
while [ $retval = 0 ]
do
    ip rule delete table $tid
    retval=$?
done

#add new rules
for ip in `grep '^#rule' $0| awk '{print \$2}`
do 
    ip rule add to $ip table $tid
done
ip route add default via $vpngw table $tid
ip route flush cache
