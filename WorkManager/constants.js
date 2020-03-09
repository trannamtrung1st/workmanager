import { Dimensions } from "react-native";

const SCREENS = {
  dashboard: "Dashboard",
  task: "Task",
  logout: "Logout"
};

const screen = Dimensions.get("screen");
const DIMENSIONS = {
  width: screen.width,
  height: screen.height
};

const COLOR = {
  white: "#FFF",
  black: "#000",
  gray: "#EEE",
  primaryGreen: "#5cb85c",
  secondaryGreen: "#d4ffb8"
};

export { SCREENS, COLOR, DIMENSIONS };
