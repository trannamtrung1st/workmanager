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
import ImagePicker from "react-native-image-picker";
import { Database } from "$services";
import { TaskApi } from "$api";
import { API } from "$constants";

const options = {
  title: "Choose an image",
  takePhotoButtonTitle: "Take a photo",
  chooseFromLibraryButtonTitle: "Choose from gallery"
};

function ViewTask(props) {
  const authContext = useContext(AuthContext);
  const forceUpdate = HookHelper.useForceUpdate();
  const { navigation, route } = props;
  const taskId = route.params.id;
  const [viewTaskContext] = useState({
    data: null,
    setModalVisible: null,
    goBack: navigation.goBack,
    reload
  });
  const data = viewTaskContext.data;

  if (data == null) {
    reload();
    return null;
  }

  function reload() {
    TaskApi.get(
      {
        fields: [
          "info",
          "detail",
          "created_user",
          "source",
          "of_user",
          "report",
          "review"
        ],
        ids: taskId
      },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        const data = await resp.json();
        if (resp.ok) {
          const task = data.data.results[0];
          if (!task) {
            alert("Not found");
            return;
          }

          viewTaskContext.data = task;
          forceUpdate();
        } else {
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
  }

  function _onUpdate() {
    TaskApi.edit(
      data,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Update successfully");
          forceUpdate();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
  }

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

  function _onUploadImagePress() {
    ImagePicker.showImagePicker(options, onImagePickerResult);
  }

  function _onFinish() {
    const formData = new FormData();
    formData.append("status", "DONE");
    formData.append("task_report", data.task_report ?? "");
    if (data.confirm_image && typeof data.confirm_image != "string") {
      formData.append("confirm_image", {
        uri: data.confirm_image.uri,
        type: "image/png", // or photo.type
        name: "confirm.png"
      });
    }

    TaskApi.changeStatus(
      data.id,
      formData,
      async resp => {
        console.log(resp);
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Finish successfully");
          viewTaskContext.reload();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
  }

  function _onChangeStatus(status) {
    const formData = new FormData();
    formData.append("status", status);
    formData.append("manager_review", data.manager_review ?? "");
    formData.append("task_report", data.task_report ?? "");
    formData.append("mark", data.mark ?? "");

    TaskApi.changeStatus(
      data.id,
      formData,
      async resp => {
        console.log(resp);
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Update status successfully");
          viewTaskContext.reload();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
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
            {data.status.map(s => (
              <ItemStatusBadge status={s} />
            ))}
          </View>
          <View style={s.formItemContainer}>
            <Text>
              Created by:
              <Text style={s.link}> {data.created_user.username}</Text>
            </Text>
          </View>
          <View style={s.formItemContainer}>
            <Text>
              Assigned to:
              <Text style={s.link}> {data.of_user.username}</Text>
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
            <Text>Deadline</Text>
            <AppDateTimePicker
              initDate={new Date(data.deadline)}
              onDateChanged={(ev, v) => (data.deadline = v)}
            />
          </View>
          <View style={s.btnInputContainer}>
            <AppButton text="UPDATE" onPress={_onUpdate} />
          </View>

          <Hr />
          <Text style={s.formHeader}>REPORT SECTION</Text>
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
            <Text>Confirm image</Text>
            <View style={s.formItemContainer}>
              <AppButton
                type="outline-primary"
                text="UPLOAD IMAGE"
                onPress={_onUploadImagePress}
              />
            </View>
            {data.confirm_image ? (
              <Image
                source={
                  typeof data.confirm_image == "string"
                    ? { uri: API.base + data.confirm_image }
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
          <View style={s.formItemContainer}>
            <View style={s.btnInputContainer}>
              <AppButton
                btnStyle={s.btnOp}
                type="danger"
                text="CANCEL"
                onPress={() => _onChangeStatus("CANCEL")}
              />
              <AppButton btnStyle={s.btnOp} text="FINISH" onPress={_onFinish} />
            </View>
          </View>

          <Hr />
          <Text style={s.formHeader}>REVIEW SECTION</Text>
          <View style={s.formItemContainer}>
            <Text>
              Review time:
              <Text> {data.review_time}</Text>
            </Text>
          </View>

          <View style={s.formItemContainer}>
            <Text>Manager's review</Text>
            <View style={s.inputContainer}>
              <AppInput
                textAlignVertical={"top"}
                multiline={true}
                placeholder="Review content"
                numberOfLines={5}
                onChangeText={t => _changeData("manager_review", t)}
                value={data.manager_review}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Rate</Text>
            <View style={s.inputContainer}>
              <AppInput
                keyboardType="number-pad"
                placeholder="Task's result"
                onChangeText={t => _changeData("mark", parseInt(t))}
                value={
                  data.mark
                    ? isNaN(data.mark)
                      ? data.mark.toString()
                      : null
                    : null
                }
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <View style={s.btnInputContainer}>
              <AppButton
                btnStyle={s.btnOp}
                type="danger"
                text="DECLINE"
                onPress={() => _onChangeStatus("DECLINED")}
              />
              <AppButton
                btnStyle={s.btnOp}
                text="ACCEPT"
                onPress={() => _onChangeStatus("ACCEPTED")}
              />
              <AppButton
                btnStyle={s.btnOp}
                text="CONFIRM"
                onPress={() => _onChangeStatus("FINISH CONFIRMED")}
              />
            </View>
          </View>
        </View>
      </AppLayout>
      <Icon name="bars" style={s.actionIcon} onPress={_onActionPress} />

      <ActionModal task={viewTaskContext.data} />
    </ViewTaskContext.Provider>
  );
}

export default ViewTask;
