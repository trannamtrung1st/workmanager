import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  itemStatus: {
    paddingHorizontal: 5,
    borderRadius: 7
  },
  new: {
    backgroundColor: COLOR.cyan
  },
  doing: {
    backgroundColor: COLOR.darkorange
  },
  done: {
    backgroundColor: COLOR.primaryGreen
  }
});
const itemStatus = [styles.itemStatus];
const itemStatusText = [commonStyles.textWhite, commonStyles.fontWeightBold];
const newStatus = itemStatus.concat(styles.new);
const doingStatus = itemStatus.concat(styles.doing);
const doneStatus = itemStatus.concat(styles.done);
const s = {
  itemStatus,
  itemStatusText,
  newStatus,
  doingStatus,
  doneStatus
};

export default s;
