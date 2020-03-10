import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  listItem: {
    padding: 10,
    marginVertical: 5,
    borderLeftWidth: 5,
    borderLeftColor: COLOR.primaryGreen,
    borderBottomWidth: 1,
    borderBottomColor: COLOR.gray
  },
  itemTime: {
    fontStyle: "italic",
    color: COLOR.gray
  }
});
const listItem = [commonStyles.w100, styles.listItem];
const itemNameContainer = [commonStyles.flexRow];
const itemName = [commonStyles.fontWeightBold];
const itemTime = [commonStyles.textRight, styles.itemTime];

const s = {
  listItem,
  itemNameContainer,
  itemName,
  itemTime
};

export default s;
