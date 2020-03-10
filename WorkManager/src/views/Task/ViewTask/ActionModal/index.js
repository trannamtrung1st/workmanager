import React, { useState, useContext } from "react";
import { View } from "react-native";
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
    ImagePicker.showImagePicker(options, onImagePickerResult);
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
          text="START TASK"
          onPress={() => {
            alert("OK");
          }}
        />
      </View>
      <View style={s.formItemContainer}>
        <AppButton text="UPLOAD IMAGE" onPress={_onUploadImagePress} />
      </View>
      <View style={s.formItemContainer}>
        <AppButton
          type="danger"
          text="DELETE"
          onPress={() => {
            alert("OK");
          }}
        />
      </View>
    </Modal>
  );
}

export default ActionModal;
