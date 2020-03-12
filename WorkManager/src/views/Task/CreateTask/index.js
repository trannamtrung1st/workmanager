import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import {
  AppLayout,
  AppDateTimePicker,
  AppButton,
  AppInput,
  ScannerModal
} from "$components";
import { CreateTaskContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import { Database } from "$services";
import Icon from "react-native-vector-icons/FontAwesome5";
import { TaskApi } from "$api";

function CreateTask(props) {
  const { navigation, route } = props;
  const { users } = Database;
  const source = route?.params?.source;
  const forceUpdate = HookHelper.useForceUpdate();
  const currentDate = new Date();
  let deadline = source ? new Date(source.deadline) : currentDate;
  if (deadline < currentDate) deadline = currentDate;
  let sourceUser = source
    ? (sourceUser = users.filter(u => u.username == source.of_user)[0])
    : null;
  const [createTaskContext] = useState({
    data: {
      name: source?.name,
      task_content: source?.task_content,
      deadline: deadline,
      source,
      employee_code: sourceUser?.employee_code
    },
    setScannerOpen: null
  });
  const data = createTaskContext.data;

  function _changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

  function onSuccess(user) {
    _changeData("employee_code", user.employee_code);
  }

  function _onSubmit() {
    TaskApi.create(
      data,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Create successfully");
          navigation.goBack();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        alert("Something's wrong");
      }
    );
  }

  return (
    <CreateTaskContext.Provider value={createTaskContext}>
      <AppLayout {...props} screenHeader="Create new task">
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
            <AppButton text="SUBMIT" onPress={_onSubmit} />
          </View>
        </View>
      </AppLayout>
      <ScannerModal context={createTaskContext} onSuccess={onSuccess} />
    </CreateTaskContext.Provider>
  );
}

export default CreateTask;
