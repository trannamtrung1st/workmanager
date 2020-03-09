import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btnFilter: {
    padding: 7,
    borderRadius: 7,
    backgroundColor: COLOR.primaryGreen,
    width: 80
  },
  btnCancel: {
    marginRight: 10,
    backgroundColor: COLOR.lightRed
  },
  filterInputContainer: {
    marginVertical: 5
  },
  pickerContainer: {
    paddingHorizontal: 5
  },
  filterModal: {
    marginVertical: 250,
    padding: 15
  }
});

const btnFilter = [commonStyles.centerInside, styles.btnFilter];
const btnCancel = btnFilter.concat(styles.btnCancel);
const filterModal = [
  commonStyles.w80,
  appStyles.bgWhite,
  commonStyles.alignSelfCenter,
  styles.filterModal
];
const pickerContainer = [appStyles.borderGray, styles.pickerContainer];
const filterInputContainer = [styles.filterInputContainer];
const btnInputContainer = filterInputContainer.concat([
  commonStyles.flexRow,
  commonStyles.justifyFlexEnd
]);

const s = {
  pickerContainer,
  btnFilter,
  btnCancel,
  filterModal,
  filterInputContainer,
  btnInputContainer
};

export default s;
