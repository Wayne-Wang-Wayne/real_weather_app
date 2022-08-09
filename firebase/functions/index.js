
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