import React, { useState, useContext } from "react";
import { View, Text, Picker, TouchableOpacity } from "react-native";
import Modal from "react-native-modal";
import { ListTaskContext } from "$app-contexts";
import s from "./style";
import { AppButton, AppDateTimePicker } from "$components";
import { HookHelper } from "@trannamtrung1st/t-components";

function FilterModal(props) {
  const listTaskContext = useContext(ListTaskContext);
  const forceUpdate = HookHelper.useForceUpdate();
  const [filterOpen, setFilterOpen] = useState(false);
  listTaskContext.setFilterOpen = setFilterOpen;

  const [filter, setFilter] = useState({
    renew: true,
    status: null,
    fromDate: null,
    toDate: null
  });

  if (filter.renew) {
    filter.renew = false;
    filter.status = listTaskContext.filter.status;
    filter.fromDate = listTaskContext.filter.fromDate;
    filter.toDate = listTaskContext.filter.toDate;
  }
  if (!filterOpen) filter.renew = true;

  function _onStatusFilterChanged(itemValue) {
    filter.status = itemValue;
    forceUpdate();
  }

  function _onFromDateChanged(ev, itemValue) {
    if (itemValue) filter.fromDate = itemValue;
  }

  function _onToDateChanged(ev, itemValue) {
    if (itemValue) filter.toDate = itemValue;
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
            selectedValue={filter.status}
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
          initDate={filter.fromDate}
          onDateChanged={_onFromDateChanged}
        />
      </View>
      <View style={s.formItemContainer}>
        <Text>To date</Text>
        <AppDateTimePicker
          initDate={filter.toDate}
          onDateChanged={_onToDateChanged}
        />
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
            listTaskContext.setFilter({
              status: filter.status,
              fromDate: filter.fromDate,
              toDate: filter.toDate
            });
            setFilterOpen(false);
          }}
        />
      </View>
    </Modal>
  );
}
export default FilterModal;