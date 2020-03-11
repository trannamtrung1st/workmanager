import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import { AppLayout, AppDateTimePicker, AppButton, AppInput } from "$components";
import { CreateTaskContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";

function CreateTask(props) {
  const { navigation, route } = props;
  const source = route?.params?.source;
  const forceUpdate = HookHelper.useForceUpdate();
  const currentDate = new Date();
  let deadline = source ? new Date(source.deadline) : currentDate;
  if (deadline < currentDate) deadline = currentDate;

  const [createTaskContext] = useState({
    data: {
      name: source?.name,
      task_content: source?.task_content,
      deadline: deadline,
      source
    }
  });
  const data = createTaskContext.data;

  function changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

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
          {source ? (
            <View style={s.formItemContainer}>
              <Text>
                Source:
                <Text style={s.link}> {source.name}</Text>
              </Text>
            </View>
          ) : null}

          <View style={s.formItemContainer}>
            <Text>Task name</Text>
            <View style={s.inputContainer}>
              <AppInput
                placeholder="Input"
                onChangeText={t => changeData("name", t)}
                value={data.name}
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
                onChangeText={t => changeData("task_content", t)}
                value={data.task_content}
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
