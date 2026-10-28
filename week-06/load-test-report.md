# Week 6 – Load Balancing and Auto Scaling

This week, I deployed PropertyLite behind a load balancer with an Auto Scaling Group running two app servers in private subnets. I tested automatic replacement by terminating one server, and AWS started launching its replacement about two minutes later. I also connected through a bastion and ran a five minute CPU test. CPU usage increased, but no additional servers were launched. I learned that the scaling policy looks at average CPU across the group, so putting load on only one server may not be enough to trigger scaling.


## What I learned
I learned how a load balancer sends requests to healthy instances and how Auto Scaling replaces a terminated server. I also learned that high CPU on one instance does not necessarily push the group average above the scaling target.

## Architecture

```mermaid
flowchart TD
    User["User"] -->|HTTP 80| ALB["Load balancer · Public subnets"]
    ALB -->|Port 8080| App1
    ALB -->|Port 8080| App2

    subgraph ASG["Auto Scaling Group · Private subnets"]
        App1["PropertyLite EC2 · AZ 1"]
        App2["PropertyLite EC2 · AZ 2"]
    end

    Laptop["My laptop"] -->|SSH| Bastion["Bastion · Public subnet"]
    Bastion -->|SSH| App1
    Bastion -->|SSH| App2
```

The load balancer routes requests to healthy app servers. Auto Scaling replaces terminated instances and targets 50% average CPU, with capacity between 1 and 4 instances. The bastion provides SSH access for testing.