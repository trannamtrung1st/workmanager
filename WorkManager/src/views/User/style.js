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
    marginTop: 80
  },
  scannerContainer: {
    marginTop: 50
  },
  form: {
    paddingHorizontal: 17,
    paddingVertical: 10,
    marginVertical: 10
  }
});

const searchIcon = [appStyles.bottomIcon, styles.searchIcon];
const scanner = [styles.scanner];
const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const inputContainer = [appStyles.inputContainer];
const inactiveInputContainer = [appStyles.inactiveInputContainer];
const scannerContainer = [styles.scannerContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const btnOp = [commonStyles.alignSelfFlexEnd];
const s = {
  form,
  inputContainer,
  formItemContainer,
  btnInputContainer,
  inactiveInputContainer,
  btnOp,
  scanner,
  scannerContainer,
  searchIcon
};

export default s;
