import React, { useState, useContext } from "react";
import { View, Alert } from "react-native";
import ImagePicker from "react-native-image-picker";
import { AppButton } from "$components";
import s from "./style";
import Modal from "react-native-modal";
import { ViewTaskContext } from "$app-contexts";

const options = {
  title: "Choose an image",
  takePhotoButtonTitle: "Take a photo",
  chooseFromLibraryButtonTitle: "Choose from gallery"
};
function ActionModal(props) {
  const viewTaskContext = useContext(ViewTaskContext);
  const [modalVisible, setModalVisible] = useState(false);
  viewTaskContext.setModalVisible = setModalVisible;
  const { onImagePickerResult } = props;
  function _onUploadImagePress() {
    setModalVisible(false);
    ImagePicker.showImagePicker(options, onImagePickerResult);
  }

  function _onStartPress() {
    setModalVisible(false);
    viewTaskContext.reload();
  }

  function _onDeleteConfirmed() {
    setModalVisible(false);
    Alert.alert(
      "Message",
      "Delete successfully",
      [
        {
          text: "Ok",
          onPress: () => {
            viewTaskContext.goBack();
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
      isVisible={modalVisible}
      onBackdropPress={() => setModalVisible(false)}
    >
      <View style={s.formItemContainer}>
        <AppButton text="START TASK" onPress={_onStartPress} />
      </View>
      <View style={s.formItemContainer}>
        <AppButton text="UPLOAD IMAGE" onPress={_onUploadImagePress} />
      </View>
      <View style={s.formItemContainer}>
        <AppButton type="danger" text="DELETE" onPress={_onDeletePress} />
      </View>
    </Modal>
  );
}

export default ActionModal;
