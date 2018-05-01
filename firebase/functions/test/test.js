const FirebaseTest = require('firebase-functions-test');
import * as firebase from "firebase";
import * as chai from "chai";
import * as sinon from "sinon";
import * as admin from "firebase-admin";
import * as fs from "fs";
import {helpers} from "../helpers.js";
const assert = chai.assert;

const config = require('./testconfig');
firebase.initializeApp(config);
const test = FirebaseTest(config, '../serviceAcount.json');

describe('Cloud Functions', () => {
    let myFuncs, adminInitStub;

    before(() => {
        myFuncs = require('../index.js');
    });

    after(() => {
        test.cleanup();
    });

    describe('GetNearbyCourts', () => {
        let doc;
        const data = {
            latitude: "40",
            longitude: "-90",
            region: "Champaign",
            name: "Some Court",
        };
        before(() => {
            doc = admin.firestore().collection('courts').doc();
            return doc.set(data);
        });
        after(()=> {
            return doc.delete();
        });
        it('should get courts within the given range', () => {
            const query = {
                "location": {
                    "latitude": 40,
                    "longitude": -90,
                },
                "range": 5,
            }

            return helpers.getNearbyCourts(query).then((result) => {
                assert.deepInclude(result, data);
                return;
            });
        });
    });
    
    describe('ScheduleGame', () => {
        const ids = [];
        it('should add a game to the games collection', async () => {
            const query = {
                courtId: "somecourt",
                userId: "someuser"
            }
            const writeResult = await helpers.scheduleGame(query);
            const ref = admin.firestore().collection('games').where('court', '==', 'somecourt');
            const result = await ref.get();
            assert.isAbove(result.size, 0);
            result.forEach((doc) => {
                ids.push(doc.id);
                const data = doc.data();
                assert.equal(data.creator, "someuser");
            });
        });
        after(async () => {
            return Promise.all(ids.map((id) => {
                const item = admin.firestore().collection('games').doc(id);
                return item.delete();
            }));
        });
    });

    describe('AddUserGame', () => {
        let gameRef;
        const data = {
            court: "courtid",
            creator: "creatorid",
            participants: {
                p1: true,
                p2: true,
            },
            time: Date.now(),
        }
        before(() => {
            gameRef = admin.firestore().collection('games').doc();
            return gameRef.set(data);
        });
        after(() => {
            return gameRef.delete();
        });
        it('should add a user as a game participant', async () => {
            const query = {
                gameId: gameRef.id,
                userId: "userid",
            }
            const result = await helpers.addUserGame(query);
            const doc = await gameRef.get();
            const data = doc.data();
            assert.isTrue(data.participants["userid"]);
        });
    });

    describe('RemoveUserGame', () => {
        let gameRef;
        const data = {
            court: "courtid",
            creator: "creatorid",
            participants: {
                p1: true,
                p2: true,
                userid: true,
            },
            time: Date.now(),
        }
        before(() => {
            gameRef = admin.firestore().collection('games').doc();
            return gameRef.set(data);
        });
        after(() => {
            return gameRef.delete();
        });
        it('should remove a user as a game participant', async () => {
            const query = {
                gameId: gameRef.id,
                userId: "userid",
            }
            const queryResult = await helpers.removeUserGame(query);
            const doc = await gameRef.get();
            const result = doc.data();
            assert.isFalse(result.participants["userid"]);
        });
    });

    describe('AddCourt', () => {
        const ids = [];
        it('should add a court to the courts collection', async () => {
            const query = {
                name: "New Court",
                latitude: 0,
                longitude: 0,
                region: "test",
            }
            const writeResult = await helpers.addCourt(query);
            const ref = admin.firestore().collection('courts').where('name', '==', "New Court");
            const result = await ref.get();
            assert.isAbove(result.size, 0);
            result.forEach((doc) => {
                ids.push(doc.id);
                assert.deepEqual(doc.data(), query);
            });
            return;
        });
        after(() => {
            return Promise.all(ids.map((id) => {
                const item = admin.firestore().collection('courts').doc(id);
                return item.delete();
            }));
        });
    });

    describe('GetGameInfo', () => {
        let doc;
        const data = {
            court: "testcourt",
            participants: [
                "userid"
            ],
            time: new Date("April 23, 2018"),
        }
        before(() => {
            doc = admin.firestore().collection('games').doc();
            return doc.set(data);
        });
        after(() => {
            return doc.delete();
        });
        it('should return the data for a specific game', () => {
            const query = {
                id: doc.id
            }
            return helpers.getGameInfo(query).then((result) => {
                assert.deepEqual(result, data);
                return;
            })
        });
    });

    describe('GetGamesForCourt', () => {
        let gameDoc;
        let courtDoc;
        const curDate = new Date(Date.now());
        const gameData = {
            creator: "someuser",
            court: "newcourt",
            participants: [],
            time: curDate,
        };
        const testGameData = {
            creator: "someuser",
            court: "newcourt",
            participants: [],
            time: curDate.toISOString(),
        }
        const courtData = {
            latitude: 20,
            longitude: 20,
            name: "Court",
            region: "test",
        };
        before(() => {
            gameDoc = admin.firestore().collection('games').doc("newgame");
            courtDoc = admin.firestore().collection('courts').doc("newcourt");
            return Promise.all([
                gameDoc.set(gameData),
                courtDoc.set(courtData),
            ]);
        });
        after(() => {
            return Promise.all([
                gameDoc.delete(),
                courtDoc.delete(),
            ]);
        });
        it('should find games by court id', () => {
            const query = {courtId: "newcourt"};
            return helpers.getGamesForCourt(query).then((result) => {
                assert.deepEqual(result[0], testGameData);
                return;  
            });
        });
    });
});



