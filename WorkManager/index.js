/**
 * @format
 */

import "react-native-gesture-handler";
import { AppRegistry } from "react-native";
import App from "./src";
import { name as appName } from "./app.json";

console.disableYellowBox = true;
AppRegistry.registerComponent(appName, () => App);

// Background Firebase handler
import messaging, { firebase } from "@react-native-firebase/messaging";

//FCM TOKEN
messaging()
  .getToken()
  .then(token => {
    console.log(token);
  });

const unsubscribe = messaging().onTokenRefresh(async fcmToken => {
  console.log("New FCM Token:", fcmToken);
});
//END FCM TOKEN

//background message pressed: default launch app launcher
messaging().setBackgroundMessageHandler(async remoteMessage => {
  console.log("Message handled in the background!", remoteMessage);

  // Update a users messages list using AsyncStorage
  // const currentMessages = await AsyncStorage.getItem("messages");
  // const messageArray = JSON.parse(currentMessages) ?? [];
  // messageArray.push(remoteMessage.data);
  // await AsyncStorage.setItem("messages", JSON.stringify(messageArray));
});
