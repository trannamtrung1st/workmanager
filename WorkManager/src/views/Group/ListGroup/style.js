import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  plusIcon: {
    paddingVertical: 12,
    paddingHorizontal: 15
  },
  listContainer: {
    marginBottom: 100
  }
});

const listContainer = [styles.listContainer];
const plusIcon = [appStyles.bottomIcon, styles.plusIcon];
const btnOp = [commonStyles.alignSelfFlexEnd];
const s = {
  plusIcon,
  listContainer,
  btnOp
};

export default s;
