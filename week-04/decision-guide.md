
# Week 4: Storage Decision Guide

## Summary

This week, I worked with S3, RDS, and DynamoDB. I uploaded a file to S3 and set up a lifecycle rule, then created a private MySQL database and connected through EC2. I imported 55,212 property records, removed the sensitive columns listed in the handbook, replaced the original listing IDs, and queried listing counts and average prices by city. I also added a property to DynamoDB and retrieved it by ID. 

One challenge was that the handbook’s MySQL version required Extended Support, so I used MySQL 8.4. The table also already had a primary key, so I had to adjust the SQL before making the synthetic listing ID the new primary key. I learned how EC2 connects to a private RDS database through security groups, how S3, RDS, and DynamoDB serve different storage needs, and why checking results and cleaning up resources are part of completing a lab.

## Guide

| Service | Storage type | Use this when… |
|---|---|---|
| S3 | Object storage | I need to store files, datasets, backups, or application assets. |
| EBS | Block storage | My EC2 instance needs a disk for its operating system or application data. |
| EFS | Shared file storage | Multiple Linux instances need access to the same files. |
| RDS | Relational database | I need SQL queries, relationships, joins, and transactions. |
| DynamoDB | NoSQL database | I need fast lookups by key without managing database servers. |

## What I did

- Uploaded a file to S3 and configured a lifecycle rule.
- Created a private RDS MySQL database and connected through EC2.
- Imported 55,212 property records and removed the handbook’s 17 specified sensitive columns.
- Replaced the original listing IDs with synthetic IDs and made L_ListingID the primary key.
- Queried listing counts and average prices by city.
- Added one property to DynamoDB and retrieved it by its listing ID.
- Deleted the lab database, DynamoDB table, EC2 instance, and its volume.
- Removed the S3 lifecycle rule and uploaded object.

