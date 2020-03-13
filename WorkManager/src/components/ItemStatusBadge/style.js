import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  itemStatus: {
    paddingHorizontal: 5,
    borderRadius: 7,
    marginHorizontal: 2
  },
  new: {
    backgroundColor: COLOR.cyan
  },
  doing: {
    backgroundColor: COLOR.darkorange
  },
  done: {
    backgroundColor: COLOR.primaryGreen
  },
  danger: {
    backgroundColor: COLOR.lightRed
  }
});
const itemStatus = [styles.itemStatus];
const itemStatusText = [commonStyles.textWhite, commonStyles.fontWeightBold];
const newStatus = itemStatus.concat(styles.new);
const doingStatus = itemStatus.concat(styles.doing);
const doneStatus = itemStatus.concat(styles.done);
const dangerStatus = itemStatus.concat(styles.danger);
const s = {
  dangerStatus,
  itemStatus,
  itemStatusText,
  newStatus,
  doingStatus,
  doneStatus
};

export default s;
