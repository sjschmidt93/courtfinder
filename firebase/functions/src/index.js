import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as geofire from "geofire";

admin.initializeApp()

// Callable Function:
export const getNearbyCourts = functions.https.onCall((data, context) => {
    const {latitude, longitude} = data.location;
    const courts = admin.firestore().collection('courts');    
    const ref = admin.database().ref('courts')
    const geoFire = new geofire(ref);
    const query = geoFire.query({
        center: [latitude, longitude],
        radius: 0.5
    });
    const keys = [];
    query.on('key_entered', (key, location, distance) => {
        keys.push(key)
    });
    return new Promise((resolve) => {
        query.on('ready', () => {
            resolve(keys);
        });
    }).then((keys) => {
        return getDataForKeys(courts, keys);
    });
});

export const scheduleGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return {};
});

export const addUserGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return true;
});

export const removeUserGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return true;
});

export const getGameInfo = functions.https.onCall((data, context) => {
    return {};
});


// Cloud Firestore Events
export const addToGeoFire = functions.firestore.document('courts/{id}').onCreate((snap, context) => {
    const id = snap.ref.id;
    const data = snap.data()
    const ref = admin.database().ref('courts')
    const geoFire = new geofire(ref);
    return geoFire.set(id, [data.latitude, data.longitude]);
});


// Helper Functions
async function getDataForKeys(collection, keyList) {
    results = [];
    results = await Promise.all(keyList.map(async (key) => {
        return await collection.doc(key);
    }))
    return results;
}