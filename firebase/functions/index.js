
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { firestore } = require("firebase-admin");
admin.initializeApp();

exports.removeExpiredPostAndPic = functions.pubsub.schedule("every 240 hours").onRun(async (context) => {
  const db = admin.firestore();
  const now = firestore.Timestamp.now();
  const ts = now.toMillis() - 1296000000; // 24 hours in milliseconds = 86400000

  const snap = await db.collection("posts").where("postDateTimeStamp", "<", ts).get();
  let promises = [];

  for(const snapChild of snap.docs){
    const bucket = admin.storage().bucket();
    const path = `post_image/${snapChild.data().postId}.jpg`;
    await bucket.file(path).delete();
    await db.collection("replies").doc(snapChild.data().postId).delete();
  }
  snap.forEach((snap) => {
    promises.push(snap.ref.delete());
  });
  return Promise.all(promises);
});

exports.onCreatePost = functions.firestore
.document('posts/{docId}')
.onCreate((snap, context) => {
  const postData = snap.data();
  const locCode = postData.locCode;
  const location = `${postData.postCity} ${postData.postTown}`;
  const postText = postData.postText;
  const postId = postData.postId;
  const imageUrl = postData.imageUrl;

  const message = {
    data: {
      location: location,
      locCode: locCode,
      postId: postId
    },
    notification: {
      title: location,
      body: postText
    },
    android:{
      priority: "high"
    },
    topic: locCode,
  };
  admin
    .messaging()
    .send(message)
    .then((response) => {
    console.log("Successfully sent message:", `locCode = ${locCode}, location = ${location}, postText = ${postText}`);
  })
  .catch((error) => {
    console.log("Error sending message:", error);
  });
});


// exports.sendNotification = functions.https.onCall(async (data, context) => {

//   const location = data.location;
//   const topicCode = data.topicCode;
//   const postText = data.postText;

//   const message = {
//     data: {
//       location: location,
//       content: `${location}: ${postText}`,
//     },
//     topic: topicCode,
//   };
//   admin
//     .messaging()
//     .send(message)
//     .then((response) => {
//     console.log("Successfully sent message:", response);
//   })
//   .catch((error) => {
//     console.log("Error sending message:", error);
//   });

//   return `Successfully send notification`;
// });