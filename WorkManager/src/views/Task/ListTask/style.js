import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  listItem: {
    padding: 10,
    marginVertical: 5,
    borderLeftWidth: 5,
    borderLeftColor: COLOR.primaryGreen,
    borderBottomWidth: 1,
    borderBottomColor: COLOR.gray
  },
  itemCreatedTime: {
    fontStyle: "italic",
    color: COLOR.gray
  },
  plusIcon: {
    paddingVertical: 12,
    paddingHorizontal: 15
  },
  listContainer: {
    marginBottom: 100
  }
});
const btnOp = [commonStyles.alignSelfFlexEnd];
const listContainer = [styles.listContainer];
const listItem = [commonStyles.w100, styles.listItem];
const itemNameContainer = [commonStyles.flexRow];
const itemName = [commonStyles.fontWeightBold];
const itemCreatedTime = [commonStyles.textRight, styles.itemCreatedTime];
const plusIcon = [appStyles.bottomIcon, styles.plusIcon];

const s = {
  plusIcon,
  listContainer,
  listItem,
  itemNameContainer,
  itemName,
  itemCreatedTime,
  btnOp
};

export default s;
