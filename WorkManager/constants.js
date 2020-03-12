import { Dimensions } from "react-native";

const API = {
  endpoint: "http://192.168.1.125:45457/api/"
};

const SCREENS = {
  dashboard: "Dashboard",
  task: "Task",
  listTask: "List Task",
  createTask: "Create Task",
  viewTask: "View Task",
  user: "User",
  group: "Group",
  listUser: "List User",
  viewUser: "View User",
  createUser: "Create User",
  createGroup: "Create Group",
  viewGroup: "View Group",
  listGroup: "List Group",
  logout: "Logout"
};

const screen = Dimensions.get("screen");
const DIMENSIONS = {
  width: screen.width,
  height: screen.height
};

const COLOR = {
  lightRed: "#fc583f",
  darkorange: "darkorange",
  lightBlue: "lightblue",
  primaryBlue: "#053bf2",
  dark: "#343a40",
  darkBlue: "darkblue",
  cyan: "cyan",
  white: "#FFF",
  black: "#000",
  lightgray: "#EEE",
  gray: "#AAA",
  darkGreen: "#135c06",
  primaryGreen: "#5cb85c",
  secondaryGreen: "#d4ffb8"
};

export { SCREENS, COLOR, DIMENSIONS, API };
