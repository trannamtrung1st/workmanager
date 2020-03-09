import React, { useState } from "react";
import { View } from "react-native";
import { AppLayout } from "$components";
import { TextButton } from "@trannamtrung1st/t-components";
import { Database } from "$services";
import { ListTaskContext } from "$app-contexts";
import FilterModal from "./FilterModal";
import TaskItem from "./TaskItem";
import s from "./style";

function ListTask(props) {
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

  return (
    <ListTaskContext.Provider value={listTaskContext}>
      <AppLayout {...props} screenHeader="List of tasks">
        <View style={s.filterContainer}>
          <TextButton
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
    </ListTaskContext.Provider>
  );
}

export default ListTask;
