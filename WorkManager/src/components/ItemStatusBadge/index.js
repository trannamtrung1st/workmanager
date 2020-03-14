import React from "react";
import { Text, View } from "react-native";
import s from "./style";

function ItemStatusBadge(props) {
  const { status } = props;
  let finalStatus;
  switch (status) {
    case "NEW":
      finalStatus = s.newStatus;
      break;
    case "DOING":
    case "ACCEPTED":
    case "DUE SOON":
      finalStatus = s.doingStatus;
      break;
    case "DONE":
    case "FINISH CONFIRMED":
      finalStatus = s.doneStatus;
      break;
    case "CANCEL":
    case "DECLINED":
    case "LATE":
      finalStatus = s.dangerStatus;
      break;
  }

  return (
    <View style={finalStatus}>
      <Text style={s.itemStatusText}>{status}</Text>
    </View>
  );
}

export default ItemStatusBadge;
