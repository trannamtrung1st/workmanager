import React, { useState } from "react";
import { TouchableOpacity, Text } from "react-native";
import s from "./style";
import DateTimePicker from "@react-native-community/datetimepicker";

function AppDateTimePicker(props) {
  const { onPress, onDateChanged, show, initDate, mode, style } = props;
  const [date, setDate] = useState({
    value: initDate ?? new Date(),
    show: show == true
  });

  function _onPress() {
    if (onPress) {
      const suppress = onPress();
      if (suppress) return;
    }
    setDate({
      value: date.value,
      show: true
    });
  }

  function _onDateChanged(ev, v) {
    setDate({
      value: v ?? date.value,
      show: false
    });
    if (onDateChanged) onDateChanged(ev, v);
  }

  let finalStyle = s.inputContainer;
  if (style) finalStyle = finalStyle.concat(style);

  return (
    <TouchableOpacity style={finalStyle} onPress={_onPress}>
      <Text>{date.value.toDateString()}</Text>
      {date.show && (
        <DateTimePicker
          timeZoneOffsetInMinutes={0}
          value={date.value}
          mode={mode ?? "date"}
          display="default"
          onChange={_onDateChanged}
        />
      )}
    </TouchableOpacity>
  );
}

export default AppDateTimePicker;
