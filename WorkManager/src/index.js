import "react-native-gesture-handler";
import React, { useState, useEffect } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { AppDrawerNavigator } from "$navigation";
import { AuthContext } from "$app-contexts";
import { Login } from "$views";
import { UserApi } from "$api";
import { G } from "$global";
import messaging from "@react-native-firebase/messaging";
import AsyncStorage from "@react-native-community/async-storage";

let logoutIntervalId;
export default function App() {
  useEffect(() => {
    //foreground handler
    const unsubscribe = messaging().onMessage(async remoteMessage => {
      console.log("FCM Message Data:", remoteMessage.data);

      // Update a users messages list using AsyncStorage
      // const currentMessages = await AsyncStorage.getItem("messages");
      // const messageArray = JSON.parse(currentMessages) ?? [];
      // messageArray.push(remoteMessage.data);
      // await AsyncStorage.setItem("messages", JSON.stringify(messageArray));
    });
    return unsubscribe;
  }, []);

  const [authContext, setAuthContext] = useState(reset());
  if (!G.tokenGot) {
    G.tokenGot = true;
    UserApi.getTokenThen(token => {
      G.tokenModel = JSON.parse(token);
      const context = reset();
      setAuthContext(context);
    });
    return null;
  }

  function reset() {
    return {
      accessToken: G.tokenModel?.access_token,
      expiresUtc: G.tokenModel?.expires_utc,
      username: G.tokenModel?.username,
      employeeCode: G.tokenModel?.employee_code,
      userId: G.tokenModel?.user_id,
      logoutIntervalSet: false,
      login,
      logout
    };
  }

  function logout() {
    if (logoutIntervalId) clearInterval(logoutIntervalId);
    UserApi.logout(err => {
      if (err) return;
      G.tokenModel = null;
      setAuthContext(reset());
    });
  }

  function login(tokenModel) {
    UserApi.saveToken(tokenModel, () => {
      G.tokenModel = tokenModel;
      setAuthContext(reset());
    });
  }

  if (!authContext.logoutIntervalSet && authContext.accessToken) {
    authContext.logoutIntervalSet = true;
    logoutIntervalId = setInterval(() => {
      if (authContext.expiresUtc <= new Date()) {
        logout();
      }
    }, 60000);
  }

  console.log(G.tokenModel?.user_id);
  return (
    <AuthContext.Provider value={authContext}>
      {authContext.accessToken ? (
        <NavigationContainer>
          <AppDrawerNavigator />
        </NavigationContainer>
      ) : (
        <Login />
      )}
    </AuthContext.Provider>
  );
}
