import React from "react";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { SCREENS, COLOR } from "$constants";
import { Dashboard, Task, Logout } from "$views";
import s from "./style";

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
      <Drawer.Screen name={SCREENS.dashboard} component={Dashboard} />
      <Drawer.Screen name={SCREENS.task} component={Task} />
      <Drawer.Screen name={SCREENS.logout} component={Logout} />
    </Drawer.Navigator>
  );
}

export default AppDrawerNavigator;
