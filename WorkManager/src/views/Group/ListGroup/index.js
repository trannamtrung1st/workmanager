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

function ListGroup(props) {
  const { navigation } = props;
  const { groups } = Database;
  const forceUpdate = HookHelper.useForceUpdate();
  const [listGroupContext] = useState({
    reload: forceUpdate
  });

  function _onCreatePress() {
    navigation.navigate(SCREENS.createGroup);
  }

  function onItemPress(group) {
    navigation.navigate(SCREENS.viewGroup, {
      group
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
