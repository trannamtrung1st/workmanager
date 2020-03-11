import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ListTaskContext } from "$app-contexts";
import { SCREENS } from "$constants";

function ActionModal(props) {
  const listTaskContext = useContext(ListTaskContext);
  const reset = {
    item: null,
    show: false
  };
  const [modalVisible, setModalVisible] = useState(reset);
  listTaskContext.setModalVisible = setModalVisible;

  function _onDeleteConfirmed() {
    setModalVisible(reset);
    Alert.alert(
      "Message",
      "Delete successfully",
      [
        {
          text: "Ok",
          onPress: () => {
            listTaskContext.reload();
          }
        }
      ],
      { cancelable: false }
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
    console.log(item);
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
      <View style={s.formItemContainer}>
        <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
      </View>
    </Modal>
  );
}

export default ActionModal;
