import React, { useState, useContext } from "react";
import { View, Text, Picker, TouchableOpacity } from "react-native";
import Modal from "react-native-modal";
import { ListTaskContext } from "$app-contexts";
import s from "./style";
import { AppButton, AppDateTimePicker } from "$components";

function FilterModal(props) {
  const listTaskContext = useContext(ListTaskContext);
  const [filterOpen, setFilterOpen] = useState(false);
  listTaskContext.setFilterOpen = setFilterOpen;
  const [statusFilter, setStatusFilter] = useState(null);
  const [fromDate, setFromDate] = useState(new Date());
  const [toDate, setToDate] = useState(new Date());

  function _onStatusFilterChanged(itemValue) {
    setStatusFilter(itemValue);
  }

  function _onFromDateChanged(ev, itemValue) {
    if (itemValue) setFromDate(itemValue);
  }

  function _onToDateChanged(ev, itemValue) {
    if (itemValue) setToDate(itemValue);
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
      <View style={s.formItemContainer}>
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
      <View style={s.formItemContainer}>
        <Text>From date</Text>
        <AppDateTimePicker
          initDate={fromDate}
          onDateChanged={_onFromDateChanged}
        />
      </View>
      <View style={s.formItemContainer}>
        <Text>To date</Text>
        <AppDateTimePicker initDate={toDate} onDateChanged={_onToDateChanged} />
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
