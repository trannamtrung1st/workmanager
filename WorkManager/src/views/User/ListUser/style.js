import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  searchIcon: {
    width: 62,
    right: 8
  },
  plusIcon: {
    width: 62
  },
  listContainer: {
    marginBottom: 100
  },
  topSearchIcon: {
    bottom: 77
  }
});

const listContainer = [styles.listContainer];
const searchIcon = [appStyles.bottomIcon, styles.searchIcon];
const plusIcon = [appStyles.bottomIcon, styles.plusIcon];
const btnOp = [commonStyles.alignSelfFlexEnd];
const topSearchIcon = searchIcon.concat(styles.topSearchIcon);
const s = {
  topSearchIcon,
  plusIcon,
  listContainer,
  btnOp,
  searchIcon
};

export default s;
