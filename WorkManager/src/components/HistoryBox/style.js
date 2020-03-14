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
  italic: {
    fontStyle: "italic"
  }
});

const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const inputContainer = [appStyles.inputContainer];
const link = [styles.link];
const tbl = form.concat(styles.tblUser);
const tblRow = inputContainer.concat(styles.tblRow);
const formHeader = [commonStyles.fontWeightBold, styles.formHeader];
const bold = [commonStyles.fontWeightBold];
const italic = [styles.italic];
const s = {
  italic,
  bold,
  formHeader,
  tblRow,
  link,
  tbl,
  form,
  inputContainer,
  formItemContainer
};

export default s;
