import React from "react";
import { View, Text, TouchableOpacity } from "react-native";
import s from "./style";

function UserItem(props) {
  const { no, user, onPress, onLongPress } = props;
  return (
    <TouchableOpacity
      style={s.listItem}
      onPress={() => onPress(user)}
      onLongPress={() => onLongPress(user)}
    >
      <View>
        <Text>
          <Text style={s.bold}>No</Text>: {no}
        </Text>
        <Text>
          <Text style={s.bold}>Username</Text>:{" "}
          <Text style={s.link}>{user.username}</Text>
        </Text>
        <Text>
          <Text style={s.bold}>Full name</Text>: {user.full_name}
        </Text>
        {user.role ? (
          <Text>
            <Text style={s.bold}>Role:</Text> {user.role}
          </Text>
        ) : (
          <Text>
            <Text style={s.bold}>Groups</Text>:{" "}
            <Text>{user.groups.map(g => g.name).join(", ")}</Text>
          </Text>
        )}
      </View>
    </TouchableOpacity>
  );
}

export default UserItem;
