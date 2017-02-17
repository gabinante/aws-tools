This is a collection of tools (mostly bash functions) the goal of which is to make the default AWS CLI functions:
Easier to use
Easily repeatable
Simpler
Generate output that is easily parsed by humans and/or scripts

# Example Output of commands

## describe-instances-by-tag
uses the describe-instances command to search for your instances by tag (service, environment) and generate human readable output.
```
gabinante ~ $ ec2check prd web
InstanceID           | Availability Zone  | Launch Time               | State      | Private IP         | Public IP          | Instance Type     | Image             | SubnetID          | Architecture    |
"i-0e727d1c2a7532458 | us-west-2b         | 2017-02-17T03:32:08.000Z  | running    | 10.128.101.249     | 54.224.127.17      | c4.2xlarge        | ami-5erd573e      | subnet-42dbd82b   | x86_64"         |
"i-0017acb7124c23817 | us-west-2b         | 2017-02-17T03:32:08.000Z  | running    | 10.128.101.118     | 54.224.207.116     | c4.2xlarge        | ami-5erd573e      | subnet-42dbd82b   | x86_64"         |
"i-02b9b155e1d7128cf | us-west-2a         | 2017-02-17T03:32:08.000Z  | running    | 10.128.100.242     | 54.224.35.183      | c4.2xlarge        | ami-5erd573e      | subnet-7ecbd814   | x86_64"         |
"i-081ec436237rd3b33 | us-west-2a         | 2017-02-17T03:32:08.000Z  | running    | 10.128.100.137     | 54.224.111.145     | c4.2xlarge        | ami-5erd573e      | subnet-7ecbd814   | x86_64"         |
```

## route53create-hz-and-modify
Creates a hosted zone and then creates/modifies records on that hosted zone.
```
gabinante ~ $ route53create gabeslide.com
Creating Hosted Zone...
{
    "HostedZone": {
        "ResourceRecordSetCount": 2,
        "CallerReference": "NDE1YzNjOTgwNRExFjhlNWZlY2FiN2Iy",
        "Config": {
            "PrivateZone": false
        },
        "Id": "/hostedzone/ZO97A9E23H7DR",
        "Name": "gabeslide.com."
    },
    "DelegationSet": {
        "NameServers": [
            "ns-125.awsdns-12.com",
            "ns-1335.awsdns-28.org",
            "ns-1827.awsdns-16.co.uk",
            "ns-952.awsdns-25.net"
        ]
    },
    "Location": "https://route53.amazonaws.com/2013-04-01/hostedzone/ZO97A9E23H7DR",
    "ChangeInfo": {
        "Status": "PENDING",
        "SubmittedAt": "2017-02-17T20:49:04.859Z",
        "Id": "/change/C1KFTZ79245TKX"
    }
}
Waiting for Hosted Zone to finish creating...
Adding alias records...
{
    "ChangeInfo": {
        "Status": "PENDING",
        "Comment": "creating alias for naked domain",
        "SubmittedAt": "2017-02-17T20:49:20.737Z",
        "Id": "/change/C251UZ8BSWO1WE"
    }
}
```
