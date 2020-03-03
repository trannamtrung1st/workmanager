import "react-native-gesture-handler";
import React from "react";
import { View, Text } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import DemoApp from "@trannamtrung1st/t-components/DemoApp";
import { Container, Header, Content, Footer } from "native-base";

const Stack = createStackNavigator();

function DemoNativeBase() {
  return (
    <Container>
      <Header>
        <Text>This is native base</Text>
      </Header>
      <Content>
        <Text>My main content</Text>
      </Content>
      <Footer>
        <Text>This is footer</Text>
      </Footer>
    </Container>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator headerMode={"none"} initialRouteName={"DemoNativeBase"}>
        <Stack.Screen name="DemoApp" component={DemoApp} />
        <Stack.Screen name="DemoNativeBase" component={DemoNativeBase} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
