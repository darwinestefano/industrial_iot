const functions = require("firebase-functions");
const admin = require("firebase-admin");
const highMessage = "The temperature is beyond the maximum threshold possible"+
                "\nImmediate action required!";
const lowMessage = "The temperature is below the minimum threshold possible"+
                "\nImmediate action required!";
admin.initializeApp(functions.config().firebase);

exports.myFunction = functions.firestore
    .document("temperature/{temperature}")
    .onCreate((snapshot, context) => {
      if (snapshot.data().temperature > 35) {
        return admin.messaging().sendToTopic("temperature", {
          notification: {
            title: "ATTENTION!",
            body: highMessage,
            sound: "defaul",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        });
      }
      if (snapshot.data().temperature <20) {
        return admin.messaging().sendToTopic("temperature", {
          notification: {
            title: "ATTENTION!",
            body: lowMessage,
            sound: "defaul",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        });
      }
    });
