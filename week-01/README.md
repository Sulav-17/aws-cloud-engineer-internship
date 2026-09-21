# Week 1: AWS Account Setup and Security

1. **Root user and daily access**  
   The root user owns the AWS account which is my personal account and has full access. I use `sulav-admin` for daily work and keep root for tasks that specifically require it.

2. **IAM permissions**  
   IAM permissions control which services and resources a user can access and what actions they can perform.

3. **Shared responsibility**  
   AWS secures the physical infrastructure behind its services. I’m responsible for securing my account, permissions, data, application, and resource settings.

4. **Budget and alerts**  
   My monthly budget is US$5, with alerts when actual spending exceeds $4.25 or $5, or forecasted spending exceeds $5. These alerts notify me but do not stop charges.

5. **Connecting Ubuntu to AWS**  
   I connected Ubuntu to AWS using the `internship` profile and browser sign in. This provides temporary credentials without creating a long term access key.

   The temporary login lasts upto 12 hours. However the internship profile stays saved. It is used to authnetication so commands from Ubuntu can access my AWS account. To re coonect the session I run `aws login --profile internship --remote` to restablish connection.

6. **Verifying the connection**  
   I ran `aws sts get-caller-identity --profile internship` and confirmed I was connected to the correct AWS account as `sulav-admin`.