import React from "react";
import { createStackNavigator } from "@react-navigation/stack";
import { SCREENS, COLOR } from "$constants";
import { ViewUser, ListUser, CreateUser } from "$views";
import { fadeIn } from "react-navigation-transitions";

//Transition
const transition = fadeIn(500); // Or whichever you prefer
const config = {
  animation: "timing",
  config: transition.transitionSpec
};
const cardStyleInterpolator = ({ current, next, index, closing, layouts }) => {
  const { progress } = closing._value ? next : current;
  const { width, height } = layouts.screen;
  const containerStyle = transition.screenInterpolator({
    layout: {
      initWidth: width,
      initHeight: height
    },
    position: progress,
    scene: { index: 1 }
  });
  return { containerStyle };
};
//END Transition

const Stack = createStackNavigator();

function UserStackNavigator() {
  return (
    <Stack.Navigator
      initialRouteName={SCREENS.listUser}
      headerMode={"none"}
      screenOptions={{
        transitionSpec: {
          open: config,
          close: config
        },
        cardStyleInterpolator,
        cardStyle: { backgroundColor: COLOR.white }
      }}
    >
      <Stack.Screen name={SCREENS.listUser} component={ListUser} />
      <Stack.Screen name={SCREENS.viewUser} component={ViewUser} />
      <Stack.Screen name={SCREENS.createUser} component={CreateUser} />
    </Stack.Navigator>
  );
}

export default UserStackNavigator;
