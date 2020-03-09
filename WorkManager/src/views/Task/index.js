import React from "react";
import { View, Text } from "react-native";
import { AppLayout } from "$components";
import { TextInput } from "react-native";

function Task(props) {
  return (
    <AppLayout {...props}>
      <Text>Task</Text>
    </AppLayout>
  );
}

export default Task;
