import React, { useState, useContext } from "react";
import { View, Alert, Group, Text } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ViewGroupContext, AuthContext } from "$app-contexts";
import { GroupApi } from "$api";

function ActionModal(props) {
  const authContext = useContext(AuthContext);
  const reset = {
    item: null,
    show: false
  };
  const viewGroupContext = useContext(ViewGroupContext);
  const [modalVisible, setModalVisible] = useState(reset);
  viewGroupContext.setModalVisible = setModalVisible;

  function _onChangePress() {
    GroupApi.changeUserRoleInGroup(
      modalVisible.item.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Change role successfully");
          setModalVisible(reset);
          viewGroupContext.reload();
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

  function _onRemoveConfirmed() {
    GroupApi.removeUserFromGroup(
      modalVisible.item.id,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Remove successfully");
          setModalVisible(reset);
          viewGroupContext.reload();
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
      isVisible={modalVisible.show}
      onBackdropPress={() => setModalVisible(false)}
    >
      {authContext.role != "Admin" ? (
        <Text>Nothing to perform</Text>
      ) : (
        <>
          <View style={s.formItemContainer}>
            <AppButton text="CHANGE ROLE" onPress={_onChangePress} />
          </View>
          <View style={s.formItemContainer}>
            <AppButton type="danger" text="REMOVE" onPress={_onRemovePress} />
          </View>
        </>
      )}
    </Modal>
  );
}

export default ActionModal;
