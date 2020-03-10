import React from "react";
import s from "./style";
import { View } from "react-native";

function Hr(props) {
  const { style } = props;
  let finalStyle = s.hr;
  if (style) finalStyle = finalStyle.concat(style);
  return <View style={finalStyle}></View>;
}

export default Hr;
