import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";

const styles = StyleSheet.create({
  modalContainer: {
    padding: 18
  },
  scanner: {
    marginTop: 56
  },
  camera: {},
  scannerContainer: {
    marginTop: 50
  }
});

const scanner = [styles.scanner];
const scannerContainer = [styles.scannerContainer];
const btnOp = [commonStyles.alignSelfFlexEnd];
const modalContainer = [styles.modalContainer];
const camera = [commonStyles.w100, styles.camera];
const s = {
  camera,
  modalContainer,
  btnOp,
  scanner,
  scannerContainer
};

export default s;
