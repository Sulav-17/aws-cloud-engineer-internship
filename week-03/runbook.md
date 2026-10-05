# Week 3: EC2 and PropertyLite

## Setup and Deployment

- Logged into AWS from Ubuntu using the `internship` profile and confirmed I was using `sulav-admin`.
- Created `user-data.sh` with the PropertyLite code, dependencies, and sample data.
- Used a virtual environment and systemd to manage the app. These were additions to the handbook's example.
- Checked the script with `bash -n` before launching.

## EC2 Configuration

- Name: `property-api-01`
- Region: `us-east-1`
- OS: Amazon Linux 2023
- Instance: `t3.micro`
- Storage: 8 GiB gp3
- Network: default VPC with a public IP
- Key pair: `internship-training-key`
- Security group: `internship-property-api-sg`
- Port 22 allowed from my IP only; port 8080 allowed from anywhere.

I pasted the script into User data so the app would be set up when the instance started.

## Testing and SSH

I tested `/health` and `/properties/R100234` using curl. The property endpoint returned the expected Sacramento listing.

I moved the private key into `~/.ssh`, set its permissions, and connected:

    chmod 400 ~/.ssh/internship-training-key.pem
    ssh -i ~/.ssh/internship-training-key.pem ec2-user@<public-dns>

The Amazon Linux welcome message confirmed the connection.

## EBS Snapshot

I created a snapshot of the root volume and waited until it showed Completed.

A new volume created from this snapshot would contain the saved disk data. It would not automatically create a server.

## SSH Troubleshooting

I checked my public IP using:

    curl -4 https://checkip.amazonaws.com

It matched the SSH rule, so nothing needed fixing. I did not encounter a timeout.

If SSH times out, I would check the instance state, public address, SSH rule, and subnet route to the internet gateway. The main takeaway was that “My IP” does not update automatically when my IP changes.

## Cleanup

- Terminated the instance.
- Confirmed the root volume was deleted.
- Deleted the practice snapshot.
