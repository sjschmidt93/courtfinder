import argparse
import firebase_admin
import json
from firebase_admin import credentials
from firebase_admin import firestore

def firebase_upload(data):
    db = firestore.client()
    games = db.collection('courts')
    for item in data:
        games.document().set(item)
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Upload data to firebase')
    parser.add_argument('data', help='data file to uplaod')
    args = parser.parse_args()
    
    cred = credentials.Certificate('./CourtFinder.json')
    firebase_admin.initialize_app(cred)
    with open(args.data) as f:
        data = json.load(f)
    firebase_upload(data)