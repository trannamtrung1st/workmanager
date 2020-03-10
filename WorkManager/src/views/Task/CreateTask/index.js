import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import { AppLayout, AppDateTimePicker, AppButton, AppInput } from "$components";
import { CreateTaskContext } from "$app-contexts";
import s from "./style";

function CreateTask(props) {
  const { navigation } = props;
  const [createTaskContext] = useState({
    data: {
      name: null,
      task_content: null,
      deadline: new Date()
    }
  });
  const data = createTaskContext.data;

  return (
    <CreateTaskContext.Provider value={createTaskContext}>
      <AppLayout {...props} screenHeader="Create new tasks">
        <View>
          <AppButton
            type="danger"
            text="BACK"
            btnStyle={s.btnOp}
            onPress={() => navigation.goBack()}
          />
        </View>

        <View style={s.form}>
          <View style={s.formItemContainer}>
            <Text>Task name</Text>
            <View style={s.inputContainer}>
              <AppInput
                placeholder="Input"
                onChangeText={t => (data.name = t)}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Task content</Text>
            <View style={s.inputContainer}>
              <AppInput
                textAlignVertical={"top"}
                multiline={true}
                placeholder="Content"
                numberOfLines={5}
                onChangeText={t => (data.task_content = t)}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Deadline</Text>
            <AppDateTimePicker
              initDate={data.deadline}
              onDateChanged={(ev, v) => (data.deadline = v)}
            />
          </View>

          <View style={s.btnInputContainer}>
            <AppButton
              text="SUBMIT"
              onPress={() => {
                navigation.goBack();
              }}
            />
          </View>
        </View>
      </AppLayout>
    </CreateTaskContext.Provider>
  );
}

export default CreateTask;
