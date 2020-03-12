import "react-native-gesture-handler";
import React, { useState } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { AppDrawerNavigator } from "$navigation";
import { AuthContext } from "$app-contexts";
import { Login } from "$views";
import { UserApi } from "$api";
import { HookHelper } from "@trannamtrung1st/t-components";

let tokenGot = false;
let savedToken = null;
export default function App() {
  const forceUpdate = HookHelper.useForceUpdate();
  if (!tokenGot) {
    tokenGot = true;
    saveToken = UserApi.getTokenThen(token => {
      saveToken = JSON.parse(token);
      forceUpdate();
    });
  }

  const reset = {
    accessToken: savedToken?.access_token,
    expiresUtc: savedToken?.expires_utc,
    username: savedToken?.username,
    role: savedToken?.role,
    employeeCode: savedToken?.employee_code,
    userId: savedToken?.user_id,
    logoutTimeoutSet: false,
    login,
    logout
  };
  const [authContext, setAuthContext] = useState(reset);

  function logout() {
    UserApi.logout();
    setAuthContext(reset);
  }

  function login(tokenModel) {
    UserApi.saveToken(tokenModel);
    var newContext = {
      accessToken: tokenModel.access_token,
      employeeCode: tokenModel.employee_code,
      expiresUtc: new Date(tokenModel.expires_utc),
      role: tokenModel.role,
      userId: tokenModel.user_id,
      username: tokenModel.username,
      logoutTimeoutSet: false
    };
    setAuthContext(newContext);
  }

  if (!authContext.logoutTimeoutSet && authContext.accessToken)
    setTimeout(logout, authContext.expiresUtc - new Date());

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
