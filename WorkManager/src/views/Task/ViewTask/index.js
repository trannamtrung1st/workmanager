import React, { useState, useContext } from "react";
import { View, Text, TextInput, Image } from "react-native";
import {
  AppLayout,
  AppDateTimePicker,
  AppButton,
  Hr,
  AppInput,
  ItemStatusBadge
} from "$components";
import { ViewTaskContext, AuthContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import Icon from "react-native-vector-icons/FontAwesome5";
import ActionModal from "./ActionModal";

function ViewTask(props) {
  const authContext = useContext(AuthContext);
  const forceUpdate = HookHelper.useForceUpdate();
  const { navigation, route } = props;
  const [viewTaskContext] = useState({
    data: route.params.task,
    setModalVisible: null,
    reload: () => {
      forceUpdate();
    },
    goBack: navigation.goBack
  });
  const data = viewTaskContext.data;

  function _changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

  function _onActionPress() {
    viewTaskContext.setModalVisible(true);
  }

  function onImagePickerResult(response) {
    if (response.didCancel) {
    } else if (response.error) {
      alert("Something's wrong");
    } else {
      const source = { uri: response.uri };

      // You can also display the image using data:
      // const source = { uri: 'data:image/jpeg;base64,' + response.data };
      data.confirm_image = source;
      forceUpdate();
    }
  }

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
          <Text style={s.formHeader}>GENERAL INFORMATION</Text>
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

          {data.source ? (
            <View style={s.formItemContainer}>
              <Text>
                Source:
                <Text style={s.link}> {data.source.name}</Text>
              </Text>
            </View>
          ) : null}

          {data.created_time ? (
            <View style={s.formItemContainer}>
              <Text>
                Created time:
                <Text> {data.created_time}</Text>
              </Text>
            </View>
          ) : null}
          {data.start_time ? (
            <View style={s.formItemContainer}>
              <Text>
                Start time:
                <Text> {data.start_time}</Text>
              </Text>
            </View>
          ) : null}
          {data.end_time ? (
            <View style={s.formItemContainer}>
              <Text>
                End time:
                <Text> {data.end_time}</Text>
              </Text>
            </View>
          ) : null}
          <View style={s.formRowItemContainer}>
            <Text>Status: </Text>
            <ItemStatusBadge status={data.status} />
          </View>
          <View style={s.formItemContainer}>
            <Text>
              Created by:
              <Text style={s.link}> {data.created_user}</Text>
            </Text>
          </View>
          <View style={s.formItemContainer}>
            <Text>
              Assigned to:
              <Text style={s.link}> {data.of_user}</Text>
            </Text>
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
            <Text>Report</Text>
            <View style={s.inputContainer}>
              <AppInput
                textAlignVertical={"top"}
                multiline={true}
                placeholder="Report content"
                numberOfLines={5}
                onChangeText={t => _changeData("task_report", t)}
                value={data.task_report}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Deadline</Text>
            <AppDateTimePicker
              initDate={new Date(data.deadline)}
              onDateChanged={(ev, v) => (data.deadline = v)}
            />
          </View>

          <View style={s.formItemContainer}>
            <Text>Confirm image</Text>
            {data.confirm_image ? (
              <Image
                source={
                  typeof data.confirm_image == "string"
                    ? { uri: data.confirm_image }
                    : data.confirm_image
                }
                style={s.image}
                resizeMethod={"scale"}
                resizeMode={"contain"}
              />
            ) : (
              <Text style={s.italic}>Nothing</Text>
            )}
          </View>

          <Hr />

          <Text style={s.formHeader}>REVIEW SECTION</Text>
          {data.review_time ? (
            <>
              <View style={s.formItemContainer}>
                <Text>
                  Review time:
                  <Text> {data.review_time}</Text>
                </Text>
              </View>

              <View style={s.formItemContainer}>
                <Text>Manager's review</Text>
                <View style={s.inactiveInputContainer}>
                  <AppInput
                    textAlignVertical={"top"}
                    multiline={true}
                    editable={false}
                    placeholder="Review content"
                    numberOfLines={5}
                    onChangeText={t => _changeData("manager_review", t)}
                    value={data.manager_review}
                  />
                </View>
              </View>

              <View style={s.formItemContainer}>
                <Text>Rate</Text>
                <View style={s.inactiveInputContainer}>
                  <AppInput
                    editable={false}
                    keyboardType="number-pad"
                    placeholder="Task's result"
                    onChangeText={t => (data.mark = parseInt(t))}
                    value={data.mark?.toString()}
                  />
                </View>
              </View>
            </>
          ) : null}
          <View style={s.btnInputContainer}>
            <AppButton
              text="UPDATE"
              onPress={() => {
                navigation.goBack();
              }}
            />
          </View>
        </View>
      </AppLayout>
      <Icon name="th-large" style={s.actionIcon} onPress={_onActionPress} />

      <ActionModal onImagePickerResult={onImagePickerResult} />
    </ViewTaskContext.Provider>
  );
}

export default ViewTask;
