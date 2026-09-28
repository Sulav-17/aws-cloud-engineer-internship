# Week 2: IAM and Permissions

## What I did

- Created the customer-managed policy `S3UploaderOnly-sulav`.
- Allowed `s3:PutObject` and `s3:GetObject` only for objects in `internship-training-sulav-17`.
- Attached the policy to `s3-test-user`, with no console access.
- Configured the `s3test` CLI profile and confirmed the correct user with `get-caller-identity`.

## Permissions testing

- Ran `aws s3 ls --profile s3test` and received AccessDenied.
- This was expected because the policy does not allow `s3:ListAllMyBuckets`.
- Used the IAM Policy Simulator to test PutObject:
  - Object in the training bucket: Allowed.
  - Object in a different bucket: Denied.
  - Changed the resource back to the training bucket: Allowed.
- These were simulations. I did not create a bucket or upload an object.

## Access Analyzer

- Created `internship-external-access` in us-east-1.
- Selected external access analysis with the current account as the zone of trust.
- After the scan ran, there were 0 active findings.
- This result applies to the supported resources covered by this analyzer, not every security setting in the account.

## What I learned

- IAM policies control which actions an identity can perform on specific resources.
- Least privilege means giving only the permissions needed.
- An implicit deny happens when no matching permission allows an action.
- An explicit deny overrides an allow.
- The resource ARN must match the intended resource.
- The `/*` at the end of my policy's bucket ARN covers objects inside that bucket.

## Cleanup

- Deactivated and deleted the test user's access key after testing.
- Kept the test user and policy.
- My internship profile uses separate credentials.

## Files

- Policy: `policies/s3-uploader.json`
- Evidence: `screenshots/`