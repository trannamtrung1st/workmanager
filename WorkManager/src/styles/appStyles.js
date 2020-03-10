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
  bgLightGray: {
    backgroundColor: COLOR.lightgray
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
  formItemContainer: {
    marginVertical: 5
  },
  inputContainer: {
    paddingHorizontal: 5
  },
  inactiveInputContainer: {
    backgroundColor: COLOR.lightgray
  }
});

const inputContainer = [styles.borderGray, styles.inputContainer];
const appStyles = {
  bgSecGreen: styles.bgSecGreen,
  bgPrimaryGreen: styles.bgPrimaryGreen,
  bgLightGray: styles.bgLightGray,
  bgWhite: styles.bgWhite,
  borderLightGray: styles.borderLightGray,
  borderPrimaryGreen: styles.borderPrimaryGreen,
  borderGray: styles.borderGray,
  inputContainer,
  inactiveInputContainer: inputContainer.concat(styles.inactiveInputContainer),
  formItemContainer: [styles.formItemContainer]
};

export default appStyles;
