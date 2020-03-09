import { Dimensions } from "react-native";

const SCREENS = {
  login: "Login",
  dashboard: "Dashboard"
};

const screen = Dimensions.get("screen");
const DIMENSIONS = {
  width: screen.width,
  height: screen.height
};

const COLOR = {
  white: "#FFF",
  primaryGreen: "#5cb85c",
  secondaryGreen: "#d4ffb8"
};

export { SCREENS, COLOR, DIMENSIONS };
