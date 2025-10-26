#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-06bdc05fa4344137e #Replace with your Security Group id
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" ""payment" "dispatch" "web")
ZONE_ID=Z0297829JUP0P2GV8K3D
DOMAIN_NAME="ddaws76s.online"

for i in "${INSTANCES[@]}"
do
    if [$i=="mongodb"] || [ $i =="mysql"] || [ $i =="shipping"]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t3.micro"
    fi

    IP_ADDRESS=$(aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCE_TYPE --security-group-ids sg-06bdc05fa4344137e --tag--specifications "ResourceType=instance,Tags=[{key=Name,Value=$i}]" --query 'Instances[0].
    PrivateIpaddress' --output (text)
    echo "$i: $IP_ADDRESS"
    
    #create Route53 record make sure you delete existing record
    aws route53 change-resource -record -record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment":"creating a record set for cognito endpoint"
        ,"Changes":[{
        ,"Action"               : ""CREATE"
        ,"Resource Recordset"   :{
            "Name"              : "'$!'.'$DOMAIN_NAME'"
            "Type"              : "A"
            ,"TTL"              : 1
            ,"Resource Records" : [{
                "Value"         : "'$IP_ADDRESS'"
            }]
        }
        }]
    }
    done
    