import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  btnFilter: {
    padding: 7,
    borderRadius: 7,
    backgroundColor: COLOR.primaryGreen,
    width: 80
  },
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
  }
});
const filterContainer = [];
const btnFilter = [
  commonStyles.centerInside,
  commonStyles.alignSelfFlexEnd,
  styles.btnFilter
];
const listContainer = [];
const listItem = [commonStyles.w100, styles.listItem];
const itemNameContainer = [commonStyles.flexRow];
const itemName = [commonStyles.fontWeightBold];
const itemCreatedTime = [commonStyles.textRight, styles.itemCreatedTime];

const s = {
  listContainer,
  listItem,
  itemNameContainer,
  itemName,
  itemCreatedTime,
  filterContainer,
  btnFilter
};

export default s;
