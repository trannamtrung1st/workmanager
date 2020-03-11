import React, { useRef, useState, useContext } from "react";
import { View, Text, Alert, Modal } from "react-native";
import { AppButton } from "$components";
import { Database } from "$services";
import s from "./style";
import QRCodeScanner from "react-native-qrcode-scanner";
import { CreateTaskContext } from "$app-contexts";

function ScannerModal(props) {
  const createTaskContext = useContext(CreateTaskContext);
  const { onSuccess } = props;
  const { users } = Database;
  const scannerRef = useRef(null);
  const [modalVisible, setModalVisible] = useState(false);
  createTaskContext.setScannerOpen = setModalVisible;

  function _onSuccess(e) {
    const user = users.filter(u => u.employee_code == e.data)[0];
    if (!user) {
      Alert.alert(
        "Message",
        "Not found",
        [
          {
            text: "Ok",
            onPress: () => {
              scannerRef.current.reactivate();
            }
          }
        ],
        { cancelable: false }
      );
      return;
    }
    setModalVisible(false);
    if (onSuccess) onSuccess(user);
  }

  return (
    <Modal
      animationType="slide"
      transparent={false}
      visible={modalVisible}
      onRequestClose={() => {
        setModalVisible(false);
      }}
    >
      <View style={s.modalContainer}>
        <View>
          <AppButton
            type="danger"
            text="BACK"
            btnStyle={s.btnOp}
            onPress={() => setModalVisible(false)}
          />
        </View>

        <View style={s.scannerContainer}>
          <Text>Search user information by scanning the QR code.</Text>
          <QRCodeScanner
            cameraStyle={s.camera}
            containerStyle={s.scanner}
            ref={scannerRef}
            onRead={_onSuccess}
          />
        </View>
      </View>
    </Modal>
  );
}

export default ScannerModal;
