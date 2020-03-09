import React from "react";
import { View, Text, StyleSheet, Picker } from "react-native";
import { AppLayout } from "$components";
import { TextInput } from "react-native";
import { commonStyles, TextButton } from "@trannamtrung1st/t-components";
import { DIMENSIONS, COLOR } from "$constants";
import { Database } from "$services";
import ItemStatusBadge from "./ItemStatusBadge";
import { appStyles } from "$styles";

const styles = StyleSheet.create({
  btnFilter: {
    padding: 7,
    borderRadius: 7,
    backgroundColor: COLOR.lightBlue,
    width: "20%"
  },
  activeBtnFilter: {
    backgroundColor: COLOR.darkBlue
  },
  listItem: {
    padding: 10,
    marginVertical: 5,
    borderLeftWidth: 5,
    borderLeftColor: COLOR.primaryGreen,
    borderBottomWidth: 1,
    borderBottomColor: COLOR.gray
  },
  itemCreatedTime: {
    fontStyle: "italic",
    color: COLOR.gray
  }
});
const filterContainer = [];
const btnFilter = [styles.btnFilter];
const statusContainer = [];
const statusPicker = [appStyles.borderGray];
const listContainer = [];
const listItem = [commonStyles.w100, styles.listItem];
const itemNameContainer = [commonStyles.flexRow];
const itemName = [commonStyles.fontWeightBold];
const itemCreatedTime = [commonStyles.textRight, styles.itemCreatedTime];

const s = {
  listContainer,
  statusContainer,
  statusPicker,
  listItem,
  itemNameContainer,
  itemName,
  itemCreatedTime,
  filterContainer,
  btnFilter
};

function ListTask(props) {
  const { tasks } = Database;

  return (
    <AppLayout {...props} screenHeader="List of tasks">
      <View style={s.filterContainer}>
        <TextButton text="Filter" btnStyle={s.btnFilter} />
        {/* <View style={s.statusContainer}>
          <Text>Status</Text>
          <View style={s.statusPicker}>
            <Picker
              selectedValue={null}
              onValueChange={(itemValue, itemIndex) => {}}
            >
              <Picker.Item label="New" value="NEW" />
              <Picker.Item label="Doing" value="DOING" />
              <Picker.Item label="Done" value="DONE" />
              <Picker.Item label="Cancel" value="CANCEL" />
            </Picker>
          </View>
        </View> */}
      </View>

      <View style={s.listContainer}>
        {tasks.map(t => (
          <View key={t.id} style={s.listItem}>
            <View style={s.itemNameContainer}>
              <Text style={s.itemName}>{t.name}&nbsp;&nbsp;&nbsp;</Text>
              <ItemStatusBadge status={t.status} />
            </View>

            <Text>{t.task_content}</Text>
            <Text style={s.itemCreatedTime}>Created: {t.created_time}</Text>
          </View>
        ))}
      </View>
    </AppLayout>
  );
}

export default ListTask;
