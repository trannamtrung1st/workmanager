import "react-native-gesture-handler";
import React, { useState } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { AppDrawerNavigator } from "$navigation";
import { AuthContext } from "$app-contexts";
import { Login } from "$views";

export default function App() {
  const [authContext, setAuthContext] = useState({
    userToken: null,
    // userToken: "token",
    username: "tnt123",
    roles: ["User", "Manager", "Admin"]
  });
  authContext.setAuthContext = setAuthContext;

  return (
    <AuthContext.Provider value={authContext}>
      {authContext.userToken ? (
        <NavigationContainer>
          <AppDrawerNavigator />
        </NavigationContainer>
      ) : (
        <Login />
      )}
    </AuthContext.Provider>
  );
}
