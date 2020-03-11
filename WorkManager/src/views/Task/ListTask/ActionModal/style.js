import React from "react";
import { StyleSheet } from "react-native";
import { appStyles } from "$styles";
import { commonStyles } from "@trannamtrung1st/t-components";

const styles = StyleSheet.create({
  actionModal: {
    position: "absolute",
    bottom: 0,
    padding: 15,
    margin: 0
  }
});
const actionModal = [
  commonStyles.w100,
  appStyles.bgWhite,
  commonStyles.alignSelfCenter,
  styles.actionModal
];
const formItemContainer = [appStyles.formItemContainer];
const formRowItemContainer = formItemContainer.concat(commonStyles.flexRow);

const s = {
  actionModal,
  formRowItemContainer,
  formItemContainer
};

export default s;
