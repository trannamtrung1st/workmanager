import React, { useState, useContext } from "react";
import { View, Alert, Text } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ListUserContext, AuthContext } from "$app-contexts";
import { SCREENS } from "$constants";
import { UserApi } from "$api";

function ActionModal(props) {
  const authContext = useContext(AuthContext);
  const listUserContext = useContext(ListUserContext);
  const reset = {
    item: null,
    show: false
  };
  const [modalVisible, setModalVisible] = useState(reset);
  listUserContext.setModalVisible = setModalVisible;

  function _onDeleteConfirmed() {
    UserApi.deleteUser(
      modalVisible.item.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Delete successfully");
          setModalVisible(reset);
          listUserContext.reload();
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

  if (!modalVisible.item) return null;

  const modalChildren = [];
  if (modalVisible.item.role == "Admin")
    modalChildren.push(
      <View style={s.formItemContainer}>
        <Text>Nothing to perform</Text>
      </View>
    );
  else
    modalChildren.push(
      <View style={s.formItemContainer}>
        <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
      </View>
    );

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
        modalChildren
      )}
    </Modal>
  );
}

export default ActionModal;
