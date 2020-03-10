import React from "react";
import { TextInput } from "react-native";
import s from "./style";

function AppInput(props) {
  const finalProps = { ...props };
  if (!finalProps.style) finalProps.style = [];
  if (finalProps.editable == false)
    finalProps.style = s.inactiveInput.concat(finalProps.style);
  return <TextInput {...finalProps} />;
}

export default AppInput;
