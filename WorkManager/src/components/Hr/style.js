import { StyleSheet } from "react-native";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  hr: {
    marginVertical: 17
  }
});

const hr = [appStyles.borderLightGray, styles.hr];
const s = { hr };

export default s;
