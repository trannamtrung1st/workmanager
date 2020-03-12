import React, { useRef, useState, useContext } from "react";
import { View, Text, Alert, Modal } from "react-native";
import { AppButton } from "$components";
import s from "./style";
import QRCodeScanner from "react-native-qrcode-scanner";
import { UserApi } from "$api";

function ScannerModal(props) {
  const { context, onSuccess } = props;
  const scannerRef = useRef(null);
  const [modalVisible, setModalVisible] = useState(false);
  context.setScannerOpen = setModalVisible;

  function _onSuccess(e) {
    UserApi.getUsers(
      { fields: ["info", "role"], employee_code: e.data },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }
        const data = await resp.json();
        if (resp.ok) {
          const user = data.data.results[0];
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
        } else {
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
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
