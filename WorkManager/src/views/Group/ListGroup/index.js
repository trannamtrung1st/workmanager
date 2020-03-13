import React, { useState } from "react";
import { View, Text, Alert } from "react-native";
import { AppLayout, ScannerModal } from "$components";
import { Database } from "$services";
import { ListGroupContext } from "$app-contexts";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import { SCREENS } from "$constants";
import GroupItem from "./GroupItem";
import ActionModal from "./ActionModal";
import { HookHelper } from "@trannamtrung1st/t-components";
import { GroupApi } from "$api";
import { useIsFocused } from "@react-navigation/native";

function ListGroup(props) {
  const { navigation } = props;
  const forceUpdate = HookHelper.useForceUpdate();
  const [listGroupContext] = useState({
    groups: null,
    reload
  });

  const isFocused = useIsFocused();
  if (!isFocused) {
    reset();
    return null;
  }

  if (!listGroupContext.groups) listGroupContext.reload();
  const groups = listGroupContext.groups ?? [];

  function reload() {
    GroupApi.get(
      { fields: ["info"], limit: 1000 },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }
        const data = await resp.json();
        if (resp.ok) {
          listGroupContext.groups = data.data.results;
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
    listGroupContext.groups = null;
  }

  function _onCreatePress() {
    navigation.navigate(SCREENS.createGroup);
  }

  function onItemPress(group) {
    navigation.navigate(SCREENS.viewGroup, {
      id: group.id
    });
  }

  function onItemLongPress(item) {
    listGroupContext.setModalVisible({
      item,
      show: true
    });
  }

  return (
    <ListGroupContext.Provider value={listGroupContext}>
      <AppLayout {...props} screenHeader="List of groups">
        <View style={s.listContainer}>
          {groups.map(u => (
            <GroupItem
              key={u.id}
              group={u}
              onPress={onItemPress}
              onLongPress={onItemLongPress}
            />
          ))}
        </View>

        <ActionModal />
      </AppLayout>
      <Icon name="plus" style={s.plusIcon} onPress={_onCreatePress} />
    </ListGroupContext.Provider>
  );
}

export default ListGroup;
