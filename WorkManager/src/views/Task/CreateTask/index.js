import React, { useState } from "react";
import { View, StyleSheet, Text } from "react-native";
import { AppLayout, AppDateTimePicker, AppButton } from "$components";
import { CreateTaskContext } from "$app-contexts";
import { appStyles } from "$styles";
import { TextInput } from "react-native-gesture-handler";
import { commonStyles } from "@trannamtrung1st/t-components";

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
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const btnOp = [commonStyles.alignSelfFlexEnd];
const s = { form, inputContainer, formItemContainer, btnInputContainer, btnOp };

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
              text="SUBMIT"
              onPress={() => {
                console.log(JSON.stringify(data));
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
