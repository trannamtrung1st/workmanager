import React from "react";
import s from "./style";
import { TextButton } from "@trannamtrung1st/t-components";

function AppButton(props) {
  const { type, text, onPress, btnStyle, textStyle } = props;
  let finalBtnStyle, finalTextStyle;
  switch (type) {
    case "danger":
      finalBtnStyle = s.btnDanger;
      finalTextStyle = s.textDanger;
      break;
    case "outline-primary":
      finalBtnStyle = s.btnOutlinePrimary;
      finalTextStyle = s.textOutlinePrimary;
      break;
    case "primary":
    default:
      finalBtnStyle = s.btnPrimary;
      finalTextStyle = s.textPrimary;
      break;
  }
  if (btnStyle) finalBtnStyle = finalBtnStyle.concat(btnStyle);
  if (textStyle) finalTextStyle = finalTextStyle.concat(textStyle);

  return (
    <TextButton
      btnStyle={finalBtnStyle}
      onPress={onPress}
      text={text}
      textStyle={finalTextStyle}
    />
  );
}
export default AppButton;
