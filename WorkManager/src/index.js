import "react-native-gesture-handler";
import React, { useState } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { AppDrawerNavigator } from "$navigation";
import { AuthContext } from "$app-contexts";
import { Login } from "$views";
import { UserApi } from "$api";
import { G } from "$global";

let logoutIntervalId;
export default function App() {
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
    UserApi.logout(() => {
      G.tokenModel = null;
      setAuthContext(reset());
    });
  }

  function login(tokenModel) {
    UserApi.saveToken(tokenModel);
    G.tokenModel = tokenModel;
    setAuthContext(reset());
  }

  if (!authContext.logoutIntervalSet && authContext.accessToken) {
    authContext.logoutIntervalSet = true;
    logoutIntervalId = setInterval(() => {
      if (authContext.expiresUtc <= new Date()) {
        logout();
      }
    }, 60000);
  }

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
