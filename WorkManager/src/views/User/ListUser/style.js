import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  searchIcon: {
    paddingVertical: 10,
    paddingHorizontal: 12
  },
  plusIcon: {
    paddingVertical: 12,
    paddingHorizontal: 15,
    right: 8,
    bottom: 75
  },
  listContainer: {
    marginBottom: 100
  }
});

const listContainer = [styles.listContainer];
const searchIcon = [appStyles.bottomIcon, styles.searchIcon];
const plusIcon = [appStyles.bottomIcon, styles.plusIcon];
const btnOp = [commonStyles.alignSelfFlexEnd];
const s = {
  plusIcon,
  listContainer,
  btnOp,
  searchIcon
};

export default s;
