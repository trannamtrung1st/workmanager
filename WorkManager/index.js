/**
 * @format
 */

import "react-native-gesture-handler";
import { AppRegistry } from "react-native";
import App from "./src";
import { name as appName } from "./app.json";
import { NotiApi } from "$api";

import PushNotification from "react-native-push-notification";

PushNotification.configure({
  // (optional) Called when Token is generated (iOS and Android)
  onRegister: function(token) {
    console.log("TOKEN:", token);
  },

  // (required) Called when a remote or local notification is opened or received
  onNotification: function(notification) {
    // process the notification
    NotiApi.handleNotification(notification);

    // required on iOS only (see fetchCompletionHandler docs: https://github.com/react-native-community/react-native-push-notification-ios)
    // notification.finish(PushNotificationIOS.FetchResult.NoData);
  }

  // ANDROID ONLY: GCM or FCM Sender ID (product_number) (optional - not required for local notifications, but is need to receive remote push notifications)
  // senderID: "YOUR GCM (OR FCM) SENDER ID",

  // IOS ONLY (optional): default: all - Permissions to register.
  // permissions: {
  //   alert: true,
  //   badge: true,
  //   sound: true
  // },

  // Should the initial notification be popped automatically
  // default: true
  // popInitialNotification: true,

  /**
   * (optional) default: true
   * - Specified if permissions (ios) and token (android and ios) will requested or not,
   * - if not, you must call PushNotificationsHandler.requestPermissions() later
   */
  // requestPermissions: true
});

// Background Firebase handler
import messaging, { firebase } from "@react-native-firebase/messaging";
import { G } from "$global";

//FCM TOKEN
messaging()
  .getToken()
  .then(token => {
    G.currentFCMToken = token;
  });

const unsubscribe = messaging().onTokenRefresh(async fcmToken => {
  console.log("New FCM Token:", fcmToken);
});
//END FCM TOKEN

//background message pressed: default launch app launcher
messaging().setBackgroundMessageHandler(async remoteMessage => {
  console.log("Message handled in the background!", remoteMessage);

  const data = remoteMessage.data;
  PushNotification.localNotification({
    /* Android Only Properties */
    // id: '0', // (optional) Valid unique 32 bit integer specified as string. default: Autogenerated Unique ID
    // ticker: "My Notification Ticker", // (optional)
    // autoCancel: true, // (optional) default: true
    // largeIcon: "ic_launcher", // (optional) default: "ic_launcher"
    // smallIcon: "ic_notification", // (optional) default: "ic_notification" with fallback for "ic_launcher"
    // bigText: "My big text that will be shown when notification is expanded", // (optional) default: "message" prop
    // subText: "This is a subText", // (optional) default: none
    // color: "red", // (optional) default: system default
    // vibrate: true, // (optional) default: true
    // vibration: 300, // vibration length in milliseconds, ignored if vibrate=false, default: 1000
    // tag: 'some_tag', // (optional) add tag to message
    // group: "group", // (optional) add group to message
    // ongoing: false, // (optional) set whether this is an "ongoing" notification
    // priority: "high", // (optional) set notification priority, default: high
    // visibility: "private", // (optional) set notification visibility, default: private
    // importance: "high", // (optional) set notification importance, default: high

    /* iOS and Android properties */
    // title: "Some message babe <3", // (optional)
    // message: "My Notification Message" // (required)
    ...data
    // playSound: false, // (optional) default: true
    // soundName: "default", // (optional) Sound to play when the notification is shown. Value of 'default' plays the default sound. It can be set to a custom sound such as 'android.resource://com.xyz/raw/my_sound'. It will look for the 'my_sound' audio file in 'res/raw' directory and play it. default: 'default' (default sound is played)
    // number: "10", // (optional) Valid 32 bit integer specified as string. default: none (Cannot be zero)
    // repeatType: "day", // (optional) Repeating interval. Check 'Repeating Notifications' section for more info.
    // actions: '["Yes", "No"]' // (Android only) See the doc for notification actions to know more
  });

  // Update a users messages list using AsyncStorage
  // const currentMessages = await AsyncStorage.getItem("messages");
  // const messageArray = JSON.parse(currentMessages) ?? [];
  // messageArray.push(remoteMessage.data);
  // await AsyncStorage.setItem("messages", JSON.stringify(messageArray));
});

console.disableYellowBox = true;
AppRegistry.registerComponent(appName, () => App);
