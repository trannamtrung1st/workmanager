import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btnCancel: {
    marginRight: 10
  },
  filterModal: {
    marginVertical: 250,
    padding: 15
  }
});

const btnCancel = [styles.btnCancel];
const filterModal = [
  commonStyles.w80,
  appStyles.bgWhite,
  commonStyles.alignSelfCenter,
  styles.filterModal
];
const formItemContainer = [appStyles.formItemContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const inputContainer = [appStyles.inputContainer];

const s = {
  btnCancel,
  filterModal,
  formItemContainer,
  btnInputContainer,
  inputContainer
};

export default s;
