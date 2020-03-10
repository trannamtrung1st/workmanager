import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  searchIcon: {
    paddingVertical: 10,
    paddingHorizontal: 12
  },
  scanner: {
    marginTop: 100
  }
});
const btnOp = [commonStyles.alignSelfFlexEnd];
const searchIcon = [appStyles.bottomIcon, styles.searchIcon];
const scanner = [styles.scanner];
const s = {
  scanner,
  searchIcon,
  btnOp
};

export default s;
