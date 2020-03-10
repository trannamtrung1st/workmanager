import React from "react";
import { StyleSheet } from "react-native";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  inputContainer: {
    paddingVertical: 15
  }
});
const inputContainer = [
  commonStyles.justifyCenter,
  appStyles.inputContainer,
  styles.inputContainer
];

const s = {
  inputContainer
};

export default s;
