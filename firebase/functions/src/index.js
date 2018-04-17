import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {helpers} from "./helpers.js";

admin.initializeApp()

// Callable Function:
export const getNearbyCourts = functions.https.onCall((data, context) => {
    return helpers.getNearbyCourts(data);
});

export const scheduleGame = functions.https.onCall((data, context) => {
    return helpers.scheduleGame(data, context);
});

export const addUserGame = functions.https.onCall((data, context) => {
    return helpers.addUserGame(data, context);
});

export const removeUserGame = functions.https.onCall((data, context) => {
    return helpers.removeUserGame(data, context);
});

export const getGameInfo = functions.https.onCall((data, context) => {
    return helpers.getGameInfo(data);
});

export const addCourt = functions.https.onCall((data) => {
    return helpers.addCourt(data);
});