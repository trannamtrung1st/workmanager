import React, { useState, useContext } from "react";
import { View, Alert, Text } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ListGroupContext, AuthContext } from "$app-contexts";
import { SCREENS } from "$constants";
import { GroupApi } from "$api";

function ActionModal(props) {
  var authContext = useContext(AuthContext);
  const listGroupContext = useContext(ListGroupContext);
  const reset = {
    item: null,
    show: false
  };
  const [modalVisible, setModalVisible] = useState(reset);
  listGroupContext.setModalVisible = setModalVisible;

  function _onDeleteConfirmed() {
    GroupApi.deleteGroup(
      modalVisible.item.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Delete successfully");
          setModalVisible(reset);
          listGroupContext.reload();
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
      isVisible={modalVisible.show}
      onBackdropPress={() => setModalVisible(reset)}
    >
      {authContext.role != "Admin" ? (
        <Text>Nothing to perform</Text>
      ) : (
        <View style={s.formItemContainer}>
          <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
        </View>
      )}
    </Modal>
  );
}

export default ActionModal;
