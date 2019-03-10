import * as admin from "firebase-admin";

const serviceAccount = require("../serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://dante-d7735.firebaseio.com"
});

export * from "./goals";
