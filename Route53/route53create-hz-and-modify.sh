# A function to quickly generate and modify Route 53 records from the command line.

route53create() {
   random=$(date +%s | md5 | base64 | head -c 32 ; echo)
   zone=$1
   echo "Creating Hosted Zone..."
   aws route53 create-hosted-zone --name $zone --caller-reference $random | tee /dev/tty | grep "\"Id\": \"/hostedzone/" | while read line
   do
    echo "Waiting for Hosted Zone to finish creating..."
    sleep 15
    echo "Adding alias record(s)..."
    zoneid=$(echo $line | awk '{print $2}' | awk -F'/' '{print $3}' | awk -F'"' '{print $1}')
    aws route53 change-resource-record-sets --hosted-zone-id $zoneid  --change-batch file://~/Documents/route53create-hzalias.json
   done
}
