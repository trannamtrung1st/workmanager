import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ViewGroupContext } from "$app-contexts";

function ActionModal(props) {
  const viewGroupContext = useContext(ViewGroupContext);
  const [modalVisible, setModalVisible] = useState(false);
  viewGroupContext.setModalVisible = setModalVisible;

  function _onChoosePress() {
    setModalVisible(false);
    viewGroupContext.reload();
  }

  function _onRemoveConfirmed() {
    setModalVisible(false);
    Alert.alert(
      "Message",
      "Remove successfully",
      [
        {
          text: "Ok",
          onPress: () => {
            viewGroupContext.reload();
          }
        }
      ],
      { cancelable: false }
    );
  }

  function _onRemovePress() {
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
          onPress: _onRemoveConfirmed
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
      <View style={s.formItemContainer}>
        <AppButton
          text="CHOOSE TO BE GROUP'S MANAGER"
          onPress={_onChoosePress}
        />
      </View>
      <View style={s.formItemContainer}>
        <AppButton type="danger" text="REMOVE" onPress={_onRemovePress} />
      </View>
    </Modal>
  );
}

export default ActionModal;
