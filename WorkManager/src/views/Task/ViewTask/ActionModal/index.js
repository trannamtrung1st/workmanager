import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ViewTaskContext } from "$app-contexts";
import { TaskApi } from "$api";

function ActionModal(props) {
  const viewTaskContext = useContext(ViewTaskContext);
  const { task } = props;
  const [modalVisible, setModalVisible] = useState(false);
  viewTaskContext.setModalVisible = setModalVisible;

  function _onStartPress() {
    const formData = new FormData();
    formData.append("status", "DOING");
    TaskApi.changeStatus(
      task.id,
      formData,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Start successfully");
          setModalVisible(false);
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

  function _onDeleteConfirmed() {
    TaskApi.deleteTask(
      task.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Delete successfully");
          setModalVisible(false);
          viewTaskContext.goBack();
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

  function _onDeletePress() {
    Alert.alert(
      "Are you sure?",
      "This action can not be undone",
      [
        {
          text: "No",
          style: "cancel"
        },
        {
          text: "Yes",
          onPress: _onDeleteConfirmed
        }
      ],
      { cancelable: false }
    );
  }

  return (
    <Modal
      animationIn="slideInUp"
      animationOut="slideOutDown"
      animationInTiming={250}
      animationOutTiming={500}
      backdropTransitionInTiming={-1}
      backdropTransitionOutTiming={-1}
      style={s.actionModal}
      isVisible={modalVisible}
      onBackdropPress={() => setModalVisible(false)}
    >
      {task.status.indexOf("NEW") < 0 ? null : (
        <View style={s.formItemContainer}>
          <AppButton text="START TASK" onPress={_onStartPress} />
        </View>
      )}
      <View style={s.formItemContainer}>
        <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
      </View>
    </Modal>
  );
}

export default ActionModal;
