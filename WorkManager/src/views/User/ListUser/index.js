import React, { useState, useRef, useContext } from "react";
import { View, Text, Alert } from "react-native";
import { AppLayout, AppButton, AppInput, ScannerModal } from "$components";
import { Database } from "$services";
import { ListUserContext } from "$app-contexts";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import { SCREENS } from "$constants";
import UserItem from "./UserItem";
import ActionModal from "./ActionModal";
import { HookHelper } from "@trannamtrung1st/t-components";
import { UserApi } from "$api";
import { useIsFocused } from "@react-navigation/native";

function ListUser(props) {
  const { navigation } = props;

  const forceUpdate = HookHelper.useForceUpdate();
  const [listUserContext] = useState({
    setScannerOpen: null,
    users: null,
    reload
  });
  const isFocused = useIsFocused();
  if (!isFocused) {
    reset();
    return null;
  }

  if (!listUserContext.users) listUserContext.reload();
  const users = listUserContext.users ?? [];

  function reload() {
    UserApi.getUsers(
      { fields: ["info", "role"], limit: 1000 },
      async resp => {
        if (resp.status == 401 || resp.status == 403)
          alert("Unauthorized or access denied");
        const data = await resp.json();
        if (resp.ok) {
          listUserContext.users = data.data.results;
          forceUpdate();
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

  function reset() {
    listUserContext.users = null;
  }

  function _onSearchPress() {
    listUserContext.setScannerOpen(true);
  }

  function _onCreatePress() {
    navigation.navigate(SCREENS.createUser);
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
      <Icon name="plus" style={s.plusIcon} onPress={_onCreatePress} />
    </ListUserContext.Provider>
  );
}

export default ListUser;
