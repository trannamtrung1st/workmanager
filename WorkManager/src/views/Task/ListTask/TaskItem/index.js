import React from "react";
import { View, Text, TouchableOpacity } from "react-native";
import ItemStatusBadge from "../ItemStatusBadge";
import s from "./style";

function TaskItem(props) {
  const { task, onPress } = props;
  return (
    <TouchableOpacity style={s.listItem} onPress={() => onPress(task)}>
      <View style={s.itemNameContainer}>
        <Text style={s.itemName}>{task.name}&nbsp;&nbsp;&nbsp;</Text>
        <ItemStatusBadge status={task.status} />
      </View>

      <Text>{task.task_content}</Text>
      <Text style={s.itemTime}>Deadline: {task.deadline}</Text>
    </TouchableOpacity>
  );
}

export default TaskItem;
