import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import { AppLayout, AppDateTimePicker, AppButton } from "$components";
import { ViewTaskContext } from "$app-contexts";
import s from "./style";

function ViewTask(props) {
  const { navigation } = props;
  const [viewTaskContext] = useState({
    data: {
      name: null,
      task_content: null,
      deadline: new Date()
    }
  });
  const data = viewTaskContext.data;

  return (
    <ViewTaskContext.Provider value={viewTaskContext}>
      <AppLayout {...props} screenHeader="Task detail">
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
              <TextInput
                placeholder="Input"
                onChangeText={t => (data.name = t)}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Task content</Text>
            <View style={s.inputContainer}>
              <TextInput
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
              text="UPDATE"
              onPress={() => {
                console.log(JSON.stringify(data));
                navigation.goBack();
              }}
            />
          </View>
        </View>
      </AppLayout>
    </ViewTaskContext.Provider>
  );
}

export default ViewTask;
