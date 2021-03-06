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
            const result = {
                id: doc.id,
                data: data,
            }
            const curlat = data.latitude;
            const curlon = data.longitude;
            if (minlat < curlat &&
                minlon < curlon &&
                curlat < maxlat &&
                curlon < maxlon)
                results.push(result);
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

    const scheduleGame = async function(data) {
        const userId = data.userId;
        const participantsData = {};
        participantsData[userId] = true;
        const docData = {
            court: data.courtId,
            creator: data.userId,
            participants: participantsData,
            time: new Date(data.time)
        };
        const gameRef = admin.firestore().collection('games').doc();
        return gameRef.set(docData);
    };

    const addUserGame = async function(data) {
        const userId = data.userId;
        const gameRef = admin.firestore().collection('games').doc(data.gameId);
        const participantsData = {};
        participantsData[userId] = true;
        return gameRef.set({
            participants: participantsData, 
        }, {merge: true});
    };

    const removeUserGame = async function(data) {
        const userId = data.userId;
        const gameRef = admin.firestore().collection('games').doc(data.gameId);
        const participantsData = {};
        participantsData[userId] = false;
        return gameRef.update({
            participants: participantsData,
        });
    };

    const addCourt = async function(data) {
        const courtRef = admin.firestore().collection('courts').doc();
        return courtRef.set(data);
    };

    const getGamesForCourt = async function(data) {
        const courtRef = admin.firestore().collection('games').where("court", "==", data.courtId);
        const results = await courtRef.get();
        const gameData = [];
        results.forEach((doc) => {
            const docData = doc.data();
            const resultData = {
                id: doc.id,
                creator: docData['creator'],
                participants: docData['participants'],
                time: new Date(docData['time']).toISOString(),
                court: docData['court'],
            }
            gameData.push(resultData);
        })
        return gameData;
    };

    const getAllCourts = async function() {
        const courtsRef = admin.firestore().collection('courts');
        const results = await courtsRef.get();
        const courtData = [];
        results.forEach((doc) => {
            const resultData = {
                id: doc.id,
                data: doc.data(),
            }
            courtData.push(resultData);
        });
        return courtData;
    };

    const getAllGames = async function() {
        const gamesRef = admin.firestore().collection('games');
        const results = await gamesRef.get();
        const gameData = [];
        results.forEach((doc) => {
            const docData = doc.data();
            const resultData = {
                id: doc.id,
                creator: docData['creator'],
                participants: docData['participants'],
                time: new Date(docData['time']).toISOString(),
                court: docData['court'],
            }
            gameData.push(resultData);
        });
        return gameData;
    };

    const publicFunctions = {
        getNearbyCourts,
        getGameInfo,
        scheduleGame,
        addUserGame,
        removeUserGame,
        addCourt,
        getAllCourts,
        getAllGames,
        getGamesForCourt,
    };
    return publicFunctions;
})();

