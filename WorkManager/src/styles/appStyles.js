import { StyleSheet } from "react-native";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  bgPrimaryGreen: {
    backgroundColor: COLOR.primaryGreen
  },
  bgSecGreen: {
    backgroundColor: COLOR.secondaryGreen
  },
  bgWhite: {
    backgroundColor: COLOR.white
  },
  borderLightGray: {
    borderWidth: 1,
    borderColor: COLOR.lightgray
  },
  borderGray: {
    borderWidth: 1,
    borderColor: COLOR.gray
  },
  borderPrimaryGreen: {
    borderWidth: 1,
    borderColor: COLOR.primaryGreen
  },
  inputContainer: {
    paddingHorizontal: 5
  }
});
const appStyles = {
  bgSecGreen: styles.bgSecGreen,
  bgPrimaryGreen: styles.bgPrimaryGreen,
  bgWhite: styles.bgWhite,
  borderLightGray: styles.borderLightGray,
  borderPrimaryGreen: styles.borderPrimaryGreen,
  borderGray: styles.borderGray,
  inputContainer: [styles.borderGray, styles.inputContainer]
};

export default appStyles;
