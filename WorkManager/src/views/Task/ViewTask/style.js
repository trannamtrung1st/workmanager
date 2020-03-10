import React from "react";
import { StyleSheet } from "react-native";
import { appStyles } from "$styles";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  form: {
    paddingHorizontal: 17,
    paddingVertical: 10,
    marginVertical: 10,
    marginBottom: 100
  },
  link: {
    color: COLOR.primaryBlue
  },
  italic: {
    fontStyle: "italic"
  },
  formHeader: {},
  actionIcon: {
    paddingVertical: 10,
    paddingHorizontal: 10
  },
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
const form = [appStyles.borderLightGray, styles.form];
const formItemContainer = [appStyles.formItemContainer];
const formRowItemContainer = formItemContainer.concat(commonStyles.flexRow);
const inputContainer = [appStyles.inputContainer];
const inactiveInputContainer = [appStyles.inactiveInputContainer];
const btnInputContainer = formItemContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const btnOp = [commonStyles.alignSelfFlexEnd];
const link = [styles.link];
const italic = [styles.italic];
const formHeader = [commonStyles.fontWeightBold, styles.formHeader];
const image = [
  appStyles.bgLightGray,
  commonStyles.w100,
  commonStyles.resizeContain,
  commonStyles.aspect1
];
const actionIcon = [appStyles.bottomIcon, styles.actionIcon];

const s = {
  actionModal,
  actionIcon,
  image,
  formRowItemContainer,
  form,
  inputContainer,
  inactiveInputContainer,
  formItemContainer,
  btnInputContainer,
  btnOp,
  link,
  italic,
  formHeader
};

export default s;
