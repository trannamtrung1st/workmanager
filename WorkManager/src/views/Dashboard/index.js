import React from "react";
import { View, Text } from "react-native";
import { AppLayout } from "$components";
import { TextInput } from "react-native";

function Dashboard(props) {
  return (
    <AppLayout {...props}>
      <Text>Dashboard</Text>
    </AppLayout>
  );
}

export default Dashboard;
