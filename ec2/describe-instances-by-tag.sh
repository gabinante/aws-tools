# Credit to Calvin Wong (cwong47), who wrote the first version of this script.
# Main use for this is to quickly and easily pull information about your ec2 instances based on environment and role. It's designed as a function you can put in your bash profile.
# This check assumes you have tags for your ec2 which separate services and environments. Change filters accordingly.

ec2check() {
     regions="us-east-1 us-west-1 us-west-2"
     query='Reservations[*].Instances[*].[InstanceId,Placement.AvailabilityZone,LaunchTime,State.Name,PrivateIpAddress,PublicIpAddress,InstanceType,ImageId,SubnetId,Architecture]'
     env=$1
     service=$2

     [ "$#" -ne 2 -a "$#" ] && echo "Usage: ec2check2 <env> <service>" && return 100
     [ "$env" == "prd" -o "$env" == "stg" ] && profile="prd"
     [ "$env" == "tst" -o "$env" == "int" ] && profile="dev"

printf "| %-20s | %-18s | %-25s | %-10s | %-18s | %-18s | %-17s | %-17s | %-17s | %-15s |\n" "InstanceID" "Availability Zone" "Launch Time" "State" "Private IP" "Public IP" "Instance Type" "Image" "SubnetID" "Architecture"
     for region in $regions
     do
         aws ec2 describe-instances \
             --profile $profile \
             --region $region \
             --filters Name=tag:service,Values=${service} Name=tag:environment,Values=${env} \
             --output text \
             --query $query
     done | while read line;
     do
             set -- $line;
             printf "| %-20s | %-18s | %-25s | %-10s | %-18s | %-18s | %-17s | %-17s | %-17s | %-15s |\n" $*;
     done
 }
