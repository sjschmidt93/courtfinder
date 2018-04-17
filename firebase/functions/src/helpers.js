import * as admin from "firebase-admin";
// Helper Functions

export const helpers = (function() {

    const getNearbyCourts = async function (data) {
        const {latitude, longitude} = data.location;
        const range = data.range;
        const minlat = latitude - range;
        const maxlat = latitude + range;
        const minlon = longitude - range;
        const maxlon = longitude + range;
        const courts = admin.firestore().collection('courts');
        const snapshot = await courts.get();
        const results = [];
        snapshot.forEach((doc) => {
            const data = doc.data();
            const curlat = data.latitude;
            const curlon = data.longitude;
            if (minlat < curlat &&
                minlon < curlon &&
                curlat < maxlat &&
                curlon < maxlon)
                results.push(data);
        });
        return results;
    };

    const getGameInfo = async function(data) {
        if (typeof data.id === undefined)
            throw Error("ID field does not exist");
        const id = data.id;
        const gameRef = admin.firestore().collection('games').doc(id);
        const gameData = await gameRef.get();
        return gameData.data();
    };

    const scheduleGame = async function(data, uid) {
        const docData = {
            court: data.court,
            creator: uid,
            participants: {},
            time: new Date(data.time)
        };
        const gameRef = admin.firestore().collection('games').doc();
        return gameRef.set(docData);
    };

    const addUserGame = async function(data, uid) {
        const userId = data.user || uid;
        const gameRef = admin.firestore().collection('games').doc(data.id);
        const participantsData = {};
        participantsData[userId] = true;
        return gameRef.set({
            participants: participantsData, 
        }, {merge: true});
    };

    const removeUserGame = async function(data, uid) {
        const userId = data.user || uid;
        const gameRef = admin.firestore().collection('games').doc(data.id);
        const participantsData = {};
        participantsData[userId] = false;
        return gameRef.update({
            participants: participantsData,
        });
    };

    const addCourt = async function(data) {
        const courtRef = admin.firestore().collection('courts').doc();
        return courtRef.set(data);
    }

    const publicFunctions = {
        getNearbyCourts,
        getGameInfo,
        scheduleGame,
        addUserGame,
        removeUserGame,
        addCourt,
    };
    return publicFunctions;
})();

