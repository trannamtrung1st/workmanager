import React, { useState, useRef } from "react";
import { View, Text } from "react-native";
import { AppLayout } from "$components";
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
    setCurrentUser({});
    alert(e.data);
  }

  return (
    <UserContext.Provider value={userContext}>
      <AppLayout {...props} screenHeader="User information">
        <View>
          {currentUser ? null : (
            <>
              <Text>Search user information by scanning the QR code.</Text>
              <QRCodeScanner
                containerStyle={s.scanner}
                ref={scannerRef}
                reactivate={true}
                onRead={_onSuccess}
                // flashMode={Camera.Constants.FlashMode.torch}
              />
            </>
          )}
        </View>
      </AppLayout>
      <Icon name="search" style={s.searchIcon} onPress={_onSearchPress} />
    </UserContext.Provider>
  );
}

export default User;
