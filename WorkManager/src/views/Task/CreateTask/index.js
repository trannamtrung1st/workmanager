import React, { useState } from "react";
import { View, StyleSheet } from "react-native";
import { AppLayout } from "$components";
import { CreateTaskContext } from "$app-contexts";

const styles = StyleSheet.create({});

const s = {};

function CreateTask(props) {
  const { navigation } = props;
  const [createTaskContext] = useState({});

  return (
    <CreateTaskContext.Provider value={createTaskContext}>
      <AppLayout {...props} screenHeader="Create new tasks"></AppLayout>
    </CreateTaskContext.Provider>
  );
}

export default CreateTask;
