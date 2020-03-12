import "react-native-gesture-handler";
import React, { useState } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { AppDrawerNavigator } from "$navigation";
import { AuthContext } from "$app-contexts";
import { Login } from "$views";
import { UserApi } from "$api";

let tokenGot = false;
let savedToken = null;
export default function App() {
  const [authContext, setAuthContext] = useState(reset());
  if (!tokenGot) {
    tokenGot = true;
    UserApi.getTokenThen(token => {
      savedToken = JSON.parse(token);
      setAuthContext(reset());
    });
    return null;
  }

  function reset() {
    return {
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
  }

  function logout() {
    UserApi.logout(() => {
      saveToken = null;
      setAuthContext(reset());
    });
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
      logoutTimeoutSet: false,
      login,
      logout
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
