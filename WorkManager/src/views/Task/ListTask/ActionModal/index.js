import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ListTaskContext, AuthContext } from "$app-contexts";
import { SCREENS } from "$constants";
import { TaskApi } from "$api";

function ActionModal(props) {
  const authContext = useContext(AuthContext);
  const listTaskContext = useContext(ListTaskContext);
  const reset = {
    item: null,
    show: false
  };
  const [modalVisible, setModalVisible] = useState(reset);
  listTaskContext.setModalVisible = setModalVisible;

  function _onDeleteConfirmed() {
    TaskApi.deleteTask(
      modalVisible.item.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Delete successfully");
          setModalVisible(reset);
          listTaskContext.reload();
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

  function _onCreatePress() {
    setModalVisible(false);
    const { item } = modalVisible;
    listTaskContext.navigate(SCREENS.createTask, {
      source: item
    });
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
      isVisible={modalVisible.show}
      onBackdropPress={() => setModalVisible(reset)}
    >
      <View style={s.formItemContainer}>
        <AppButton text="CREATE NEW FROM THIS TASK" onPress={_onCreatePress} />
      </View>
      {!modalVisible.item ||
      modalVisible.item.created_user.id != authContext.userId ? null : (
        <View style={s.formItemContainer}>
          <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
        </View>
      )}
    </Modal>
  );
}

export default ActionModal;
