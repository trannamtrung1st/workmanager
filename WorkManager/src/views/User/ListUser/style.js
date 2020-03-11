import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  searchIcon: {
    paddingVertical: 10,
    paddingHorizontal: 12
  }
});

const searchIcon = [appStyles.bottomIcon, styles.searchIcon];
const btnOp = [commonStyles.alignSelfFlexEnd];
const s = {
  btnOp,
  searchIcon
};

export default s;
