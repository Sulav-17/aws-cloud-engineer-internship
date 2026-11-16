import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("Properties")


def convert_number(value):
    if isinstance(value, Decimal):
        return int(value) if value == value.to_integral_value() else float(value)
    raise TypeError(f"Cannot serialize {type(value).__name__}")


def lambda_handler(event, context):
    listing_id = event["pathParameters"]["id"]

    response = table.get_item(
        Key={"L_ListingID": listing_id}
    )

    return {
        "statusCode": 200,
        "body": json.dumps(
            response.get("Item", {}),
            default=convert_number
        )
    } 