import React from "react";
import { StyleSheet } from "react-native";
import { DIMENSIONS } from "$constants";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  page: {},
  form: {
    height: DIMENSIONS.height * 0.26
  },
  header: {
    flex: 0.2
  },
  headerText: {
    fontSize: 27
  },
  body: {
    flex: 0.8
  },
  inputContainer: {
    marginVertical: 5,
    marginHorizontal: 10
  },
  inputIcon: {
    flex: 0.15,
    fontSize: 30
  },
  input: {
    flex: 0.85,
    paddingHorizontal: 10
  },
  btnLogin: {
    marginTop: 5,
    paddingVertical: 10,
    paddingHorizontal: 70
  }
});
const page = [
  commonStyles.flex1,
  commonStyles.centerInside,
  appStyles.bgSecGreen
];
const form = [
  commonStyles.w75,
  appStyles.bgWhite,
  appStyles.borderPrimaryGreen,
  styles.form
];
const header = [
  commonStyles.centerInside,
  appStyles.bgPrimaryGreen,
  styles.header
];
const headerText = [commonStyles.textWhite, styles.headerText];
const headerTextApp = [commonStyles.textBlack, commonStyles.fontWeightBold];
const body = [commonStyles.centerInside, styles.body];
const inputContainer = [
  commonStyles.flexRow,
  appStyles.borderLightGray,
  styles.inputContainer
];
const inputIcon = [
  commonStyles.textVerticalCenter,
  commonStyles.textCenter,
  styles.inputIcon
];
const input = [styles.input];
const btnLogin = [styles.btnLogin];
const s = {
  inputIcon,
  page,
  form,
  header,
  body,
  headerText,
  headerTextApp,
  input,
  inputContainer,
  btnLogin
};

export default s;
