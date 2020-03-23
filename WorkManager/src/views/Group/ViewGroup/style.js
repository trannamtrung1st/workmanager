import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";
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
  tblUser: {},
  tblRow: {
    paddingVertical: 10
  },
  empFilterInputContainer: {
    marginRight: 7
  }
});

const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const inputContainer = [appStyles.inputContainer];
const inactiveInputContainer = [appStyles.inactiveInputContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const btnOp = [commonStyles.alignSelfFlexEnd];
const link = [styles.link];
const tblUser = form.concat(styles.tblUser);
const tblRow = inputContainer.concat(styles.tblRow);
const formHeader = [commonStyles.fontWeightBold, styles.formHeader];
const bold = [commonStyles.fontWeightBold];
const empFilterInputContainer = inputContainer.concat([
  commonStyles.flex1,
  styles.empFilterInputContainer
]);
const s = {
  bold,
  formHeader,
  tblRow,
  link,
  tblUser,
  form,
  empFilterInputContainer,
  inputContainer,
  formItemContainer,
  btnInputContainer,
  inactiveInputContainer,
  btnOp
};

export default s;
