const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.app = functions.auth.user().onCreate( async (user) => {

  if (user.providerData.find(d => d && d.providerId === 'facebook.com') || user.providerData === 'facebook.com') {
    
      try {
      await admin.auth().updateUser(user.uid, {
          emailVerified: true
        })
      } catch (err) {
        console.log('err when verifying email', err)
      }
  }
})