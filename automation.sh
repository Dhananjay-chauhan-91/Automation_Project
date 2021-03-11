s3_bucket='upgrad-dhananjay'
user_name='Dhananjay'
timestamp=$(date '+%d%m%Y-%H%M%S') 
sudo apt update -y
ap_chk=$(dpkg -l apache2 | grep -c 'apache2')
#echo $ap_chk
if [ $ap_chk -eq 0 ]
then
sudo apt install apache2
fi
ap_serv=$(systemctl --type=service --state=running | grep -c 'apache2.service')
#echo $ap_serv
if [ $ap_serv -eq 0 ]
then
sudo systemctl start 'apache2.service'
fi
sudo tar -cvf /tmp/${user_name}-httpd-logs-${timestamp}.tar -P /var/log/apache2/*.log
aws s3 \
cp /tmp/${user_name}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${user_name}-httpd-logs-${timestamp}.tar
