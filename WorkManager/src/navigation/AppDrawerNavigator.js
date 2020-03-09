import React from 'react'
import { createDrawerNavigator } from "@react-navigation/drawer";
import { SCREENS } from "$constants";
import { Dashboard } from "$views";
const Drawer = createDrawerNavigator();

function AppDrawerNavigator() {
  return (
    <Drawer.Navigator initialRouteName={SCREENS.dashboard}>
      <Drawer.Screen name={SCREENS.dashboard} component={Dashboard} />
    </Drawer.Navigator>
  );
}

export default AppDrawerNavigator;
