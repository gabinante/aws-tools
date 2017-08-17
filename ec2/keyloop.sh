#A bash function to loop through all of your keys and users, in a desperate attempt to ssh to that instance you've never logged into before.
keyloop() {
      me=`whoami`
      sshdir="/Users/$me/.ssh"
      users="centos ec2-user root ubuntu"
      host=$1
      [ "$#" -ne 1 -a "$#" ] && echo "Usage: keyloop <ipaddress>" && return 100
     echo "Trying all the keys, this might take a minute..."
     for dir in $sshdir
      do
        find $sshdir -type f -name "*.pem"
      done > /tmp/keylist.txt
      for line in `cat /tmp/keylist.txt`;
        do
          for user in $users
            do
              ssh -ttX -i $line $user@$1 2> /dev/null
          done
        done
  }
