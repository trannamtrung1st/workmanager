import React, { useState, useContext } from "react";
import { View, Text, Picker, TouchableOpacity } from "react-native";
import Modal from "react-native-modal";
import { TextInput } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ListTaskContext } from "$app-contexts";
import s from "./style";
import { AppButton } from "$components";

function FilterModal(props) {
  const listTaskContext = useContext(ListTaskContext);
  const [filterOpen, setFilterOpen] = useState(false);
  listTaskContext.setFilterOpen = setFilterOpen;
  const [statusFilter, setStatusFilter] = useState(null);
  const [fromDate, setFromDate] = useState({
    value: new Date(),
    showPicker: false
  });
  const [toDate, setToDate] = useState({
    value: new Date(),
    showPicker: false
  });

  function _onStatusFilterChanged(itemValue) {
    setStatusFilter(itemValue);
  }

  function _onFromDateChanged(ev, itemValue) {
    if (itemValue)
      setFromDate({
        value: itemValue,
        showPicker: false
      });
  }

  function _onToDateChanged(ev, itemValue) {
    if (itemValue)
      setToDate({
        value: itemValue,
        showPicker: false
      });
  }

  return (
    <Modal
      animationIn="zoomIn"
      animationOut="fadeOut"
      animationInTiming={-1}
      animationOutTiming={-1}
      backdropTransitionInTiming={-1}
      backdropTransitionOutTiming={-1}
      style={s.filterModal}
      isVisible={filterOpen}
    >
      <View style={s.filterInputContainer}>
        <Text>Status</Text>
        <View style={s.inputContainer}>
          <Picker
            mode="dropdown"
            selectedValue={statusFilter}
            style={s.inputContainer}
            onValueChange={_onStatusFilterChanged}
          >
            <Picker.Item label="-- All --" value={null} />
            <Picker.Item label="New" value="NEW" />
            <Picker.Item label="Doing" value="DOING" />
            <Picker.Item label="Done" value="DONE" />
          </Picker>
        </View>
      </View>
      <View style={s.filterInputContainer}>
        <Text>From date</Text>
        <TouchableOpacity
          style={s.inputContainer}
          onPress={() =>
            setFromDate({
              value: fromDate.value,
              showPicker: true
            })
          }
        >
          <TextInput editable={false} value={fromDate.value?.toDateString()} />
          {fromDate.showPicker && (
            <DateTimePicker
              timeZoneOffsetInMinutes={0}
              value={fromDate.value}
              mode="date"
              display="default"
              onChange={_onFromDateChanged}
            />
          )}
        </TouchableOpacity>
      </View>
      <View style={s.filterInputContainer}>
        <Text>To date</Text>
        <TouchableOpacity
          style={s.inputContainer}
          onPress={() =>
            setToDate({
              value: toDate.value,
              showPicker: true
            })
          }
        >
          <TextInput editable={false} value={toDate.value?.toDateString()} />
          {toDate.showPicker && (
            <DateTimePicker
              timeZoneOffsetInMinutes={0}
              value={toDate.value}
              mode="date"
              display="default"
              onChange={_onToDateChanged}
            />
          )}
        </TouchableOpacity>
      </View>
      <View style={s.btnInputContainer}>
        <AppButton
          type="danger"
          btnStyle={s.btnCancel}
          text="CANCEL"
          onPress={() => setFilterOpen(false)}
        />
        <AppButton
          text="FILTER"
          onPress={() => {
            setFilterOpen(false);
            listTaskContext.setFilter({
              status: statusFilter,
              fromDate: fromDate.value,
              toDate: toDate.value
            });
          }}
        />
      </View>
    </Modal>
  );
}
export default FilterModal;
