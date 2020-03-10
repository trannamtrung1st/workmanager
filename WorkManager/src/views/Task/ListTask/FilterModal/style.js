import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btnCancel: {
    marginRight: 10
  },
  filterInputContainer: {
    marginVertical: 5
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
const filterInputContainer = [styles.filterInputContainer];
const btnInputContainer = filterInputContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);
const inputContainer = [appStyles.inputContainer];

const s = {
  btnCancel,
  filterModal,
  filterInputContainer,
  btnInputContainer,
  inputContainer
};

export default s;
