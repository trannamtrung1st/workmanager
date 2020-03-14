import React, { useState, useContext } from "react";
import { View, Text } from "react-native";
import { AppLayout, AppButton } from "$components";
import { Database } from "$services";
import { ListTaskContext, AuthContext } from "$app-contexts";
import FilterModal from "./FilterModal";
import TaskItem from "./TaskItem";
import s from "./style";
import Icon from "react-native-vector-icons/FontAwesome5";
import { SCREENS } from "$constants";
import ActionModal from "./ActionModal";
import { HookHelper } from "@trannamtrung1st/t-components";
import { useIsFocused } from "@react-navigation/native";
import { TaskApi } from "$api";

function ListTask(props) {
  const authContext = useContext(AuthContext);
  const { navigation } = props;
  const forceUpdate = HookHelper.useForceUpdate();
  const [listTaskContext] = useState({
    setFilterOpen: null,
    setScannerOpen: null,
    setFilter: newFilter => {
      listTaskContext.filter = newFilter;
      reload();
    },
    filter: {
      status: null,
      //from 7 day ago to now
      from_date: new Date(new Date().getTime() - 518400000),
      to_date: new Date(),
      employee_code: authContext.employeeCode
    },
    tasks: null,
    reload,
    navigate: navigation.navigate
  });

  const isFocused = useIsFocused();
  if (!isFocused) {
    reset();
    return null;
  }

  if (!listTaskContext.tasks) reload();
  const tasks = listTaskContext.tasks ?? [];

  function reload() {
    const params = {
      fields: ["info", "of_user", "created_user"],
      limit: 1000,
      ...listTaskContext.filter
    };
    params.to_date = params.to_date?.toUTCString();
    params.from_date = params.from_date?.toUTCString();
    TaskApi.get(
      params,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }
        const data = await resp.json();
        if (resp.ok) {
          listTaskContext.tasks = data.data.results;
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
    listTaskContext.tasks = null;
  }

  function _onFilterPress() {
    listTaskContext.setFilterOpen(true);
  }

  function onItemPress(item) {
    navigation.navigate(SCREENS.viewTask, {
      id: item.id
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
          {tasks.length ? (
            tasks.map(t => (
              <TaskItem
                key={t.id}
                task={t}
                onPress={onItemPress}
                onLongPress={onItemLongPress}
              />
            ))
          ) : (
            <Text>No task matched with current filter</Text>
          )}
        </View>

        <ActionModal />
        <FilterModal />
      </AppLayout>
      <Icon name="plus" style={s.plusIcon} onPress={_onPlusPress} />
    </ListTaskContext.Provider>
  );
}

export default ListTask;
