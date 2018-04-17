// import * as FirebaseTest from "firebase-functions-test";
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
                console.log(result);
                assert.deepInclude(result, data);
                return;
            });
        });
    });
    
    describe('ScheduleGame', () => {
        it('should add a game to the games collection', () => {

        });
    });

    describe('AddUserGame', () => {
        it('should a user as a game participant', () => {

        });
    });

    describe('RemoveUserGame', () => {
        it('should remove a user as a game participant', () => {

        });
    });

    describe('AddCourt', () => {
        it('should add a court to the courts collection', () => {

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
                console.log(result);
                assert.deepEqual(result, data);
                return;
            })
        });
    });

});



