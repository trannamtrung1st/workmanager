import { StyleSheet } from "react-native";
import { DIMENSIONS, COLOR } from "$constants";
import { commonStyles } from "@trannamtrung1st/t-components";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  layout: {},
  header: {
    height: 0.05 * DIMENSIONS.height
  },
  btnMenuContainer: {
    position: "absolute",
    top: 0,
    left: 0,
    width: 0.1 * DIMENSIONS.width
  },
  btnMenuIcon: {
    fontSize: 30,
    color: COLOR.secondaryGreen
  },
  headerText: {
    fontSize: 25
  },
  content: {
    padding: 18
  },
  contentContainer: {
    paddingBottom: 100
  },
  screenHeaderText: {
    fontSize: 18,
    textTransform: "uppercase"
  }
});
const layout = [commonStyles.flex1, appStyles.bgWhite, styles.layout];
const header = [commonStyles.flexRow, appStyles.bgPrimaryGreen, styles.header];
const btnMenuContainer = [
  commonStyles.h100,
  commonStyles.centerInside,
  styles.btnMenuContainer
];
const btnMenuIcon = [styles.btnMenuIcon];
const headerText = [
  commonStyles.textCenter,
  commonStyles.textVerticalCenter,
  commonStyles.flex1,
  commonStyles.textWhite,
  styles.headerText
];
const appName = [commonStyles.textBlack, commonStyles.fontWeightBold];
const content = [commonStyles.flex1, styles.content];
const screenHeader = [styles.screenHeader];
const screenHeaderText = [commonStyles.fontWeightBold, styles.screenHeaderText];
const contentContainer = [styles.contentContainer];
const s = {
  contentContainer,
  layout,
  header,
  btnMenuIcon,
  screenHeader,
  screenHeaderText,
  content,
  btnMenuContainer,
  headerText,
  appName
};

export default s;
