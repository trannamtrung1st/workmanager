import React from "react";
import { View, Text, TouchableOpacity } from "react-native";
import s from "./style";

function GroupItem(props) {
  const { group, onPress, onLongPress } = props;
  return (
    <TouchableOpacity
      style={s.listItem}
      onPress={() => onPress(group)}
      onLongPress={() => onLongPress(group)}
    >
      <View>
        <View style={s.itemNameContainer}>
          <Text style={s.itemName}>{group.name}&nbsp;&nbsp;&nbsp;</Text>
        </View>

        <Text>{group.description}</Text>
        <Text style={s.itemTime}>Created time: {group.created_time}</Text>
      </View>
    </TouchableOpacity>
  );
}

export default GroupItem;
