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
  link: {
    color: COLOR.primaryBlue
  }
});
const listItem = [commonStyles.w100, styles.listItem];
const bold = [commonStyles.fontWeightBold];
const link = [styles.link];
const s = {
  link,
  bold,
  listItem
};

export default s;
