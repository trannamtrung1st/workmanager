import React, { useState } from "react";
import { View, StyleSheet, Text } from "react-native";
import { AppLayout } from "$components";
import { CreateTaskContext } from "$app-contexts";
import { appStyles } from "$styles";
import { TextInput } from "react-native-gesture-handler";

const styles = StyleSheet.create({
  form: {
    paddingHorizontal: 17,
    paddingVertical: 10,
    marginVertical: 10
  }
});

const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const inputContainer = [appStyles.inputContainer];
const s = { form, inputContainer, formItemContainer };

function CreateTask(props) {
  const { navigation } = props;
  const [createTaskContext] = useState({});

  return (
    <CreateTaskContext.Provider value={createTaskContext}>
      <AppLayout {...props} screenHeader="Create new tasks">
        <View style={s.form}>
          <View style={s.formItemContainer}>
            <Text>Task name</Text>
            <View style={s.inputContainer}>
              <TextInput placeholder="Input" />
            </View>
          </View>
        </View>
      </AppLayout>
    </CreateTaskContext.Provider>
  );
}

export default CreateTask;
