import React from "react";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { SCREENS, COLOR } from "$constants";
import { Logout } from "$views";
import s from "./style";
import {
  TaskStackNavigator,
  UserStackNavigator,
  GroupStackNavigator
} from "$navigation";

const Drawer = createDrawerNavigator();

function AppDrawerNavigator() {
  return (
    <Drawer.Navigator
      drawerContentOptions={{
        activeTintColor: COLOR.black,
        activeBackgroundColor: COLOR.secondaryGreen,
        itemStyle: s.itemStyle
      }}
      initialRouteName={SCREENS.dashboard}
    >
      <Drawer.Screen name={SCREENS.task} component={TaskStackNavigator} />
      <Drawer.Screen name={SCREENS.user} component={UserStackNavigator} />
      <Drawer.Screen name={SCREENS.group} component={GroupStackNavigator} />
      <Drawer.Screen name={SCREENS.logout} component={Logout} />
    </Drawer.Navigator>
  );
}

export default AppDrawerNavigator;
