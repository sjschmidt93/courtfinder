import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {helpers} from "./helpers.js";

admin.initializeApp()

// Callable Function:
export const getNearbyCourts = functions.https.onCall((data, context) => {
    return helpers.getNearbyCourts(data);
});

export const scheduleGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return helpers.scheduleGame(data, uid);
});

export const addUserGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return helpers.addUserGame(data, uid);
});

export const removeUserGame = functions.https.onCall((data, context) => {
    const uid = context.auth.uid;
    return helpers.removeUserGame(data, uid);
});

export const getGameInfo = functions.https.onCall((data, context) => {
    return helpers.getGameInfo(data);
});

export const addCourt = functions.https.onCall((data) => {
    return helpers.addCourt(data);
});