import React from "react";
import { View, Text, TouchableOpacity } from "react-native";
import s from "./style";
import { ItemStatusBadge } from "$components";

function TaskItem(props) {
  const { task, onPress, onLongPress } = props;
  console.log(task);
  return (
    <TouchableOpacity
      style={s.listItem}
      onPress={() => onPress(task)}
      onLongPress={() => onLongPress(task)}
    >
      <View style={s.itemNameContainer}>
        <Text style={s.itemName}>{task.name}&nbsp;&nbsp;</Text>
        {task.status.map(t => (
          <ItemStatusBadge status={t} />
        ))}
      </View>

      <Text>{task.task_content}</Text>
      <Text style={s.link}>{task.of_user?.username}</Text>
      <Text style={s.itemTime}>Deadline: {task.deadline}</Text>
    </TouchableOpacity>
  );
}

export default TaskItem;
