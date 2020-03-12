import { StyleSheet } from "react-native";
import { COLOR } from "$constants";
import { commonStyles } from "@trannamtrung1st/t-components";

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
  },
  bottomIcon: {
    position: "absolute",
    bottom: 10,
    right: 10,
    fontSize: 30,
    borderWidth: 3,
    borderRadius: 100,
    color: COLOR.darkGreen
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
  formItemContainer: [styles.formItemContainer],
  bottomIcon: [
    commonStyles.aspect1,
    commonStyles.textCenter,
    commonStyles.textVerticalCenter,
    styles.bgSecGreen,
    styles.borderPrimaryGreen,
    styles.bottomIcon
  ]
};

export default appStyles;
