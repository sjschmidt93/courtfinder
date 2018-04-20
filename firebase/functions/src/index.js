import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {helpers} from "./helpers.js";

admin.initializeApp()

// Callable Function:
export const getNearbyCourts = functions.https.onCall((data, context) => {
    return helpers.getNearbyCourts(data);
});

export const scheduleGame = functions.https.onCall((data, context) => {
    return helpers.scheduleGame(data);
});

export const addUserGame = functions.https.onCall((data, context) => {
    return helpers.addUserGame(data);
});

export const removeUserGame = functions.https.onCall((data, context) => {
    return helpers.removeUserGame(data);
});

export const getGameInfo = functions.https.onCall((data, context) => {
    return helpers.getGameInfo(data);
});

export const addCourt = functions.https.onCall((data) => {
    return helpers.addCourt(data);
});

export const getGamesForCourt = functions.https.onCall((data) => {
    return helpers.getGamesForCourt(data);
});

export const getAllCourts = functions.https.onCall((data) => {
    return helpers.getAllCourts();
});

export const getAllGames = functions.https.onCall((data) => {
    return helpers.getAllGames();
});