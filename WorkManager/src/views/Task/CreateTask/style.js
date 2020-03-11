import React from "react";
import { StyleSheet } from "react-native";
import { appStyles } from "$styles";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  form: {
    paddingHorizontal: 17,
    paddingVertical: 10,
    marginVertical: 10
  },
  link: {
    color: COLOR.primaryBlue
  },
  empCodeInp: {
    flex: 0.8
  },
  icon: {
    fontSize: 35,
    flex: 0.2
  }
});

const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const inputContainer = [appStyles.inputContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const btnOp = [commonStyles.alignSelfFlexEnd];
const link = [styles.link];
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
  link,
  form,
  inputContainer,
  formItemContainer,
  btnInputContainer,
  btnOp
};

export default s;
