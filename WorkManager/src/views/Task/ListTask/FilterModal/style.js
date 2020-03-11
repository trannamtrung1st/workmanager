import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btnCancel: {
    marginRight: 10
  },
  filterModal: {
    margin: 0
  },
  filterModalContainer: {
    padding: 15
  },
  empCodeInp: {
    flex: 0.8
  },
  icon: {
    fontSize: 35,
    flex: 0.2
  }
});

const btnCancel = [styles.btnCancel];
const filterModalContainer = [
  appStyles.bgWhite,
  commonStyles.w80,
  styles.filterModalContainer
];
const filterModal = [
  commonStyles.w100,
  commonStyles.centerInside,
  styles.filterModal
];
const formItemContainer = [appStyles.formItemContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const inputContainer = [appStyles.inputContainer];
const flexRow = [commonStyles.flexRow];
const empCodeInp = inputContainer.concat(styles.empCodeInp);
const icon = [
  commonStyles.textCenter,
  commonStyles.textVerticalCenter,
  styles.icon
];

const s = {
  icon,
  empCodeInp,
  flexRow,
  filterModalContainer,
  btnCancel,
  filterModal,
  formItemContainer,
  btnInputContainer,
  inputContainer
};

export default s;
