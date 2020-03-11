import React, { useState, useRef } from "react";
import { View, Text, Alert } from "react-native";
import { AppLayout, AppButton, AppInput, ScannerModal } from "$components";
import { Database } from "$services";
import { ListUserContext } from "$app-contexts";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import { SCREENS } from "$constants";
import UserItem from "./UserItem";
import ActionModal from "./ActionModal";

function ListUser(props) {
  const { navigation } = props;
  const { users } = Database;
  const [listUserContext] = useState({
    setScannerOpen: null
  });

  function _onSearchPress() {
    listUserContext.setScannerOpen(true);
  }

  function onSuccess(user) {
    navigation.navigate(SCREENS.viewUser, {
      user
    });
  }

  function onItemPress(user) {
    navigation.navigate(SCREENS.viewUser, {
      user
    });
  }

  function onItemLongPress(item) {
    listUserContext.setModalVisible({
      item,
      show: true
    });
  }

  return (
    <ListUserContext.Provider value={listUserContext}>
      <AppLayout {...props} screenHeader="List of users">
        <View style={s.listContainer}>
          {users.map((u, idx) => (
            <UserItem
              no={idx + 1}
              key={u.id}
              user={u}
              onPress={onItemPress}
              onLongPress={onItemLongPress}
            />
          ))}
        </View>

        <ActionModal />
        <ScannerModal context={listUserContext} onSuccess={onSuccess} />
      </AppLayout>
      <Icon name="search" style={s.searchIcon} onPress={_onSearchPress} />
    </ListUserContext.Provider>
  );
}

export default ListUser;
