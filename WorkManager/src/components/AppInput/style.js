import { StyleSheet } from "react-native";
import { COLOR } from "$constants";

const styles = StyleSheet.create({
  inactiveInput: {
    backgroundColor: COLOR.lightgray,
    color: COLOR.black
  }
});

const inactiveInput = [styles.inactiveInput];
const s = { inactiveInput };

export default s;
