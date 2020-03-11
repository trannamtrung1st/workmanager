import React, { useState } from "react";
import { View } from "react-native";
import { AppLayout, AppButton } from "$components";
import { Database } from "$services";
import { ListTaskContext } from "$app-contexts";
import FilterModal from "./FilterModal";
import TaskItem from "./TaskItem";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import { SCREENS } from "$constants";
import ActionModal from "./ActionModal";
import { HookHelper } from "@trannamtrung1st/t-components";

function ListTask(props) {
  const { navigation } = props;
  const { tasks } = Database;
  const forceUpdate = HookHelper.useForceUpdate();
  const [filter, setFilter] = useState({
    status: null,
    //from 7 day ago to now
    fromDate: new Date(new Date().getTime() - 518400000),
    toDate: new Date(),
    employee_code: null
  });
  const [listTaskContext] = useState({
    setFilterOpen: null,
    setScannerOpen: null,
    setFilter,
    filter: null,
    reload: forceUpdate,
    navigate: navigation.navigate
  });
  listTaskContext.filter = filter;

  function _onFilterPress() {
    listTaskContext.setFilterOpen(true);
  }

  function onItemPress(item) {
    navigation.navigate(SCREENS.viewTask, {
      task: item
    });
  }

  function onItemLongPress(item) {
    listTaskContext.setModalVisible({
      item: item,
      show: true
    });
  }

  function _onPlusPress() {
    navigation.navigate(SCREENS.createTask);
  }

  return (
    <ListTaskContext.Provider value={listTaskContext}>
      <AppLayout {...props} screenHeader="List of tasks">
        <View>
          <AppButton
            text="FILTER"
            btnStyle={s.btnOp}
            onPress={_onFilterPress}
          />
        </View>

        <View style={s.listContainer}>
          {tasks.map(t => (
            <TaskItem
              key={t.id}
              task={t}
              onPress={onItemPress}
              onLongPress={onItemLongPress}
            />
          ))}
        </View>

        <ActionModal />
        <FilterModal />
      </AppLayout>
      <Icon name="plus" style={s.plusIcon} onPress={_onPlusPress} />
    </ListTaskContext.Provider>
  );
}

export default ListTask;
