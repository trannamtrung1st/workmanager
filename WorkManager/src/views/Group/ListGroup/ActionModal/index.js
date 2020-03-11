import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ListGroupContext } from "$app-contexts";
import { SCREENS } from "$constants";

function ActionModal(props) {
  const listGroupContext = useContext(ListGroupContext);
  const reset = {
    item: null,
    show: false
  };
  const [modalVisible, setModalVisible] = useState(reset);
  listGroupContext.setModalVisible = setModalVisible;

  function _onDeleteConfirmed() {
    setModalVisible(reset);
    Alert.alert(
      "Message",
      "Delete successfully",
      [
        {
          text: "Ok",
          onPress: () => {
            listGroupContext.reload();
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
        <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
      </View>
    </Modal>
  );
}

export default ActionModal;
