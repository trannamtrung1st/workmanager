import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import { AppLayout, AppDateTimePicker, AppButton, AppInput } from "$components";
import { CreateTaskContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import { Database } from "$services";
import Icon from "react-native-vector-icons/FontAwesome5";
import ScannerModal from "./ScannerModal";

function CreateTask(props) {
  const { navigation, route } = props;
  const { users } = Database;
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
      source,
      employee_code: null
    },
    setScannerOpen: null
  });
  const data = createTaskContext.data;
  let sourceUser;
  if (source) {
    sourceUser = users.filter(u => u.username == source.of_user)[0];
    data.employee_code = sourceUser.employee_code;
  }

  function _changeData(name, val) {
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
                onChangeText={t => _changeData("name", t)}
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
                onChangeText={t => _changeData("task_content", t)}
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

          <View style={s.formItemContainer}>
            <Text>Assign to</Text>
            <View style={s.flexRow}>
              <View style={s.empCodeInp}>
                <AppInput
                  placeholder="Employee code"
                  onChangeText={v => _changeData("employee_code", v)}
                  value={data.employee_code}
                />
              </View>
              <Icon
                name="camera"
                style={s.icon}
                onPress={() => createTaskContext.setScannerOpen(true)}
              />
            </View>
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
      <ScannerModal />
    </CreateTaskContext.Provider>
  );
}

export default CreateTask;
