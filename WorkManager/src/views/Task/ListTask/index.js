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

function ListTask(props) {
  const { navigation } = props;
  const { tasks } = Database;
  const [filter, setFilter] = useState({
    status: null,
    fromDate: null,
    toDate: null
  });
  const [listTaskContext] = useState({
    setFilterOpen: null,
    onItemPress,
    setFilter
  });

  function _onFilterPress() {
    listTaskContext.setFilterOpen(true);
  }

  function onItemPress(item) {
    alert(item.name);
  }

  function _onPlusPress() {
    navigation.navigate(SCREENS.createTask);
  }

  return (
    <ListTaskContext.Provider value={listTaskContext}>
      <AppLayout {...props} screenHeader="List of tasks">
        <View style={s.filterContainer}>
          <AppButton
            text="FILTER"
            btnStyle={s.btnFilter}
            onPress={_onFilterPress}
          />
        </View>

        <View style={s.listContainer}>
          {tasks.map(t => (
            <TaskItem key={t.id} task={t} />
          ))}
        </View>

        <FilterModal />
      </AppLayout>
      <Icon name="plus" style={s.plusIcon} onPress={_onPlusPress} />
    </ListTaskContext.Provider>
  );
}

export default ListTask;
