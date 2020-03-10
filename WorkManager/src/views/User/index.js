import React, { useState, useRef } from "react";
import { View, Text, Alert } from "react-native";
import { AppLayout, AppButton, AppInput } from "$components";
import { Database } from "$services";
import { UserContext } from "$app-contexts";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import QRCodeScanner from "react-native-qrcode-scanner";
import { RNCamera as Camera } from "react-native-camera";

function User(props) {
  const { navigation } = props;
  const { users } = Database;
  const [currentUser, setCurrentUser] = useState(null);
  const [userContext] = useState({});
  const scannerRef = useRef(null);

  function _onSearchPress() {
    setCurrentUser(null);
  }

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
    setCurrentUser(user);
  }
  console.log(currentUser);

  return (
    <UserContext.Provider value={userContext}>
      <AppLayout {...props} screenHeader="User information">
        <View>
          <View>
            <AppButton
              type="danger"
              text="BACK"
              btnStyle={s.btnOp}
              onPress={() => navigation.goBack()}
            />
          </View>

          {currentUser ? (
            <>
              <View style={s.form}>
                <View style={s.formItemContainer}>
                  <Text>Username</Text>
                  <View style={s.inactiveInputContainer}>
                    <AppInput editable={false} value={currentUser.username} />
                  </View>
                </View>
                <View style={s.formItemContainer}>
                  <Text>Email</Text>
                  <View style={s.inactiveInputContainer}>
                    <AppInput editable={false} value={currentUser.email} />
                  </View>
                </View>
                <View style={s.formItemContainer}>
                  <Text>Phone</Text>
                  <View style={s.inactiveInputContainer}>
                    <AppInput
                      editable={false}
                      value={currentUser.phone_number}
                    />
                  </View>
                </View>
                <View style={s.formItemContainer}>
                  <Text>Full name</Text>
                  <View style={s.inactiveInputContainer}>
                    <AppInput editable={false} value={currentUser.full_name} />
                  </View>
                </View>
                <View style={s.formItemContainer}>
                  <Text>Code</Text>
                  <View style={s.inactiveInputContainer}>
                    <AppInput
                      editable={false}
                      value={currentUser.employee_code}
                    />
                  </View>
                </View>

                {/* <View style={s.btnInputContainer}>
                  <AppButton text="UPDATE" onPress={() => {}} />
                </View> */}
              </View>
            </>
          ) : (
            <View style={s.scannerContainer}>
              <Text>Search user information by scanning the QR code.</Text>
              <QRCodeScanner
                containerStyle={s.scanner}
                ref={scannerRef}
                onRead={_onSuccess}
                // flashMode={Camera.Constants.FlashMode.torch}
              />
            </View>
          )}
        </View>
      </AppLayout>
      <Icon name="search" style={s.searchIcon} onPress={_onSearchPress} />
    </UserContext.Provider>
  );
}

export default User;
