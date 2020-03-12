import React, { useState, useContext } from "react";
import { View, Text, Picker, TouchableOpacity } from "react-native";
import Modal from "react-native-modal";
import { ListTaskContext } from "$app-contexts";
import s from "./style";
import {
  AppButton,
  AppDateTimePicker,
  AppInput,
  ScannerModal
} from "$components";
import { HookHelper } from "@trannamtrung1st/t-components";
import Icon from "react-native-vector-icons/FontAwesome5";

function FilterModal(props) {
  const listTaskContext = useContext(ListTaskContext);
  const forceUpdate = HookHelper.useForceUpdate();
  const [filterOpen, setFilterOpen] = useState(false);
  listTaskContext.setFilterOpen = setFilterOpen;

  const [filter, setFilter] = useState({
    renew: true,
    status: null,
    from_date: null,
    to_date: null,
    employee_code: null
  });

  if (filter.renew) {
    filter.renew = false;
    filter.status = listTaskContext.filter.status;
    filter.from_date = listTaskContext.filter.from_date;
    filter.to_date = listTaskContext.filter.to_date;
    filter.employee_code = listTaskContext.filter.employee_code;
  }
  if (!filterOpen) filter.renew = true;

  function _changeData(name, val) {
    filter[name] = val;
    forceUpdate();
  }

  function _onFromDateChanged(ev, itemValue) {
    if (itemValue) filter.from_date = itemValue;
  }

  function _onToDateChanged(ev, itemValue) {
    if (itemValue) filter.to_date = itemValue;
  }

  function onSuccess(user) {
    _changeData("employee_code", user.employee_code);
  }
  return (
    <>
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
        <View style={s.filterModalContainer}>
          <View style={s.formItemContainer}>
            <Text>Status</Text>
            <View style={s.inputContainer}>
              <Picker
                mode="dropdown"
                selectedValue={filter.status}
                style={s.inputContainer}
                onValueChange={v => _changeData("status", v)}
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
              initDate={filter.from_date}
              onDateChanged={_onFromDateChanged}
            />
          </View>
          <View style={s.formItemContainer}>
            <Text>To date</Text>
            <AppDateTimePicker
              initDate={filter.to_date}
              onDateChanged={_onToDateChanged}
            />
          </View>
          <View style={s.formItemContainer}>
            <Text>User</Text>
            <View style={s.flexRow}>
              <View style={s.empCodeInp}>
                <AppInput
                  placeholder="Employee code"
                  onChangeText={v => _changeData("employee_code", v)}
                  value={filter.employee_code}
                />
              </View>
              <Icon
                name="camera"
                style={s.icon}
                onPress={() => listTaskContext.setScannerOpen(true)}
              />
            </View>
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
                const newFilter = {
                  status: filter.status,
                  from_date: filter.from_date,
                  to_date: filter.to_date,
                  employee_code: filter.employee_code
                };
                console.log(newFilter);
                listTaskContext.setFilter(newFilter);
                setFilterOpen(false);
              }}
            />
          </View>
        </View>
      </Modal>
      <ScannerModal context={listTaskContext} onSuccess={onSuccess} />
    </>
  );
}
export default FilterModal;
