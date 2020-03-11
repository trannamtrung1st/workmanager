import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { COLOR } from "$constants";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btn: {
    paddingVertical: 7,
    paddingHorizontal: 14,
    borderRadius: 7
  },
  btnPrimary: {
    backgroundColor: COLOR.primaryGreen
  },
  btnDanger: {
    backgroundColor: COLOR.lightRed
  },
  btnOutlinePrimary: {
    borderWidth: 2
  },
  textOutlinePrimary: {
    color: COLOR.primaryGreen
  }
});
const btn = [commonStyles.centerInside, styles.btn];
const btnPrimary = btn.concat(styles.btnPrimary);
const textPrimary = [commonStyles.textWhite];
const btnDanger = btn.concat(styles.btnDanger);
const textDanger = [commonStyles.textWhite];
const btnOutlinePrimary = btn.concat([
  appStyles.borderPrimaryGreen,
  appStyles.bgWhite,
  styles.btnOutlinePrimary
]);
const textOutlinePrimary = [styles.textOutlinePrimary];

const s = {
  btnOutlinePrimary,
  textOutlinePrimary,
  btnPrimary,
  btnDanger,
  textPrimary,
  textDanger
};

export default s;
