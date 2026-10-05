#!/bin/bash

set -e

dnf install -y python3 python3-pip

mkdir -p /opt/property-api

cat > /opt/property-api/app.py <<'PROPERTYLITE_EOF'
import csv
import os
from flask import Flask, jsonify, request

app = Flask(__name__)
DATA_PATH = os.environ.get("PROPERTY_DATA_PATH", "rets_property_sample.csv")


def load_properties():
    with open(DATA_PATH, newline="") as f:
        return list(csv.DictReader(f))


@app.route("/health")
def health():
    return jsonify(status="ok")


@app.route("/properties")
def list_properties():
    city = request.args.get("city")
    rows = load_properties()
    if city:
        rows = [
            r for r in rows
            if r.get("L_City", "").lower() == city.lower()
        ]
    return jsonify(rows[:50])


@app.route("/properties/<listing_id>")
def get_property(listing_id):
    rows = load_properties()
    match = next(
        (r for r in rows if r.get("L_ListingID") == listing_id),
        None,
    )
    if not match:
        return jsonify(error="not found"), 404
    return jsonify(match)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
PROPERTYLITE_EOF

cat > /opt/property-api/requirements.txt <<'PROPERTYLITE_EOF'
flask==3.0.3
PROPERTYLITE_EOF

cat > /opt/property-api/rets_property_sample.csv <<'PROPERTYLITE_EOF'
L_ListingID,L_City,L_Keyword2,LM_Dec_3,LM_Int2_3,L_SystemPrice,L_Status
R100234,Sacramento,3,2.0,1450,450000,Active
R100235,Fresno,4,2.5,1900,395000,Active
R100236,Sacramento,2,1.0,900,299000,Pending
PROPERTYLITE_EOF

python3 -m venv /opt/property-api/.venv

/opt/property-api/.venv/bin/pip install -r /opt/property-api/requirements.txt

cat > /etc/systemd/system/propertylite.service <<'SERVICE_EOF'
[Unit]
Description=PropertyLite API
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/opt/property-api
ExecStart=/opt/property-api/.venv/bin/python /opt/property-api/app.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
SERVICE_EOF

systemctl daemon-reload

systemctl enable --now propertylite
