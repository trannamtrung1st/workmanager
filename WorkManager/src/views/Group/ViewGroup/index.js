import React, { useState } from "react";
import { View, Text, FlatList, TouchableOpacity } from "react-native";
import { AppLayout, AppButton, AppInput, ScannerModal } from "$components";
import { Database } from "$services";
import { ViewGroupContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import ActionModal from "./ActionModal";

function ViewGroup(props) {
  const { navigation, route } = props;
  const group = route.params.group;
  const { users } = Database;
  const forceUpdate = HookHelper.useForceUpdate();
  const [viewGroupContext] = useState({
    reload: forceUpdate,
    data: {
      id: group.id,
      name: group.name,
      description: group.description,
      created_time: group.created_time,
      created_user: group.created_user
    }
  });
  const data = viewGroupContext.data;

  function _changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

  function _onUserPress(item) {
    viewGroupContext.setModalVisible({
      item,
      show: true
    });
  }

  function onSuccess(user) {
    alert("Add " + user.username + " successfully");
    forceUpdate();
  }

  return (
    <ViewGroupContext.Provider value={viewGroupContext}>
      <AppLayout {...props} screenHeader="Group information">
        <View>
          <View>
            <AppButton
              type="danger"
              text="BACK"
              btnStyle={s.btnOp}
              onPress={() => navigation.goBack()}
            />
          </View>

          <View style={s.form}>
            <View style={s.formItemContainer}>
              <Text>Name</Text>
              <View style={s.inputContainer}>
                <AppInput
                  onChangeText={t => _changeData("name", t)}
                  value={data.name}
                />
              </View>
            </View>

            <View style={s.formItemContainer}>
              <Text>Created time: {data.created_time}</Text>
            </View>

            <View style={s.formItemContainer}>
              <Text>
                Created user:
                <Text style={s.link}> {data.created_user}</Text>
              </Text>
            </View>

            <View style={s.formItemContainer}>
              <Text>Description</Text>
              <View style={s.inputContainer}>
                <AppInput
                  textAlignVertical={"top"}
                  multiline={true}
                  placeholder="Description"
                  numberOfLines={5}
                  onChangeText={t => _changeData("description", t)}
                  value={data.description}
                />
              </View>
            </View>

            <View style={s.btnInputContainer}>
              <AppButton text="UPDATE" onPress={() => {}} />
            </View>
          </View>

          <View style={s.tblUser}>
            <Text style={s.formHeader}>GROUP'S USERS</Text>

            <View style={s.btnInputContainer}>
              <AppButton
                text="ADD"
                onPress={() => viewGroupContext.setScannerOpen(true)}
              />
            </View>

            <FlatList
              style={s.formItemContainer}
              data={users}
              renderItem={({ item }) => {
                return (
                  <View style={s.formItemContainer}>
                    <TouchableOpacity
                      style={s.tblRow}
                      onPress={() => _onUserPress(item)}
                    >
                      <Text>
                        {item.full_name + ": " + item.username + " "}
                        {item.username == data.created_user ? (
                          <Text style={s.bold}>{"(Manager)"}</Text>
                        ) : (
                          ""
                        )}
                      </Text>
                    </TouchableOpacity>
                  </View>
                );
              }}
              keyExtractor={item => item.id}
            />
          </View>
        </View>
        <ActionModal />
        <ScannerModal context={viewGroupContext} onSuccess={onSuccess} />
      </AppLayout>
    </ViewGroupContext.Provider>
  );
}

export default ViewGroup;
