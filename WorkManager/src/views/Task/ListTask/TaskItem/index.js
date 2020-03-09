import React, { useContext } from "react";
import { View, Text } from "react-native";
import ItemStatusBadge from "../ItemStatusBadge";
import { ListTaskContext } from "$app-contexts";
import { TouchableOpacity } from "react-native-gesture-handler";
import s from "./style";

function TaskItem(props) {
  const listTaskContext = useContext(ListTaskContext);
  const { task } = props;
  return (
    <TouchableOpacity
      style={s.listItem}
      onPress={() => listTaskContext.onItemPress(task)}
    >
      <View style={s.itemNameContainer}>
        <Text style={s.itemName}>{task.name}&nbsp;&nbsp;&nbsp;</Text>
        <ItemStatusBadge status={task.status} />
      </View>

      <Text>{task.task_content}</Text>
      <Text style={s.itemCreatedTime}>Created: {task.created_time}</Text>
    </TouchableOpacity>
  );
}

export default TaskItem;
