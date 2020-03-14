import React, { useState, useContext } from "react";
import { View, Text, FlatList, TouchableOpacity } from "react-native";
import {
  AppLayout,
  AppButton,
  AppInput,
  ScannerModal,
  HistoryBox
} from "$components";
import { Database } from "$services";
import { ViewGroupContext, AuthContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import ActionModal from "./ActionModal";
import { GroupApi } from "$api";

function ViewGroup(props) {
  const authContext = useContext(AuthContext);
  const { navigation, route } = props;
  const groupId = route.params.id;
  const forceUpdate = HookHelper.useForceUpdate();
  const [viewGroupContext] = useState({
    reload,
    data: null,
    historyBox: null
  });
  const data = viewGroupContext.data;
  if (data == null) {
    reload();
    return null;
  }

  function reload() {
    if (viewGroupContext.historyBox) viewGroupContext.historyBox.reload();
    GroupApi.get(
      {
        fields: ["info", "created_user", "group_users"],
        ids: groupId
      },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        const data = await resp.json();
        if (resp.ok) {
          const group = data.data.results[0];
          if (!group) {
            alert("Not found");
            return;
          }
          viewGroupContext.data = group;
          forceUpdate();
        } else {
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
  }

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

  function _onUpdate() {
    GroupApi.edit(
      data,
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Update successfully");
          reload();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
  }

  function onSuccess(user) {
    GroupApi.addUserToGroup(
      {
        user_id: user.id,
        group_id: viewGroupContext.data.id
      },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Add " + user.username + " successfully");
          reload();
        } else {
          const data = await resp.json();
          alert(data.message);
        }
      },
      err => {
        console.log(err);
        alert("Something's wrong");
      }
    );
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
                <Text style={s.link}> {data.created_user.username}</Text>
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

            {authContext.role != "Admin" ? null : (
              <View style={s.btnInputContainer}>
                <AppButton text="UPDATE" onPress={_onUpdate} />
              </View>
            )}
          </View>

          <View style={s.tblUser}>
            <Text style={s.formHeader}>GROUP'S USERS</Text>

            {authContext.role != "Admin" ? null : (
              <View style={s.btnInputContainer}>
                <AppButton
                  text="ADD"
                  onPress={() => viewGroupContext.setScannerOpen(true)}
                />
              </View>
            )}
            
            {viewGroupContext.data.group_users.length ? (
              viewGroupContext.data.group_users.map(item => (
                <View style={s.formItemContainer}>
                  <TouchableOpacity
                    style={s.tblRow}
                    onPress={() => _onUserPress(item)}
                  >
                    <Text>
                      {item.user.full_name + ": " + item.user.username + " "}
                      {item.role == "Manager" ? (
                        <Text style={s.bold}>{"(Manager)"}</Text>
                      ) : (
                        ""
                      )}
                    </Text>
                  </TouchableOpacity>
                </View>
              ))
            ) : (
              <Text>This group doesn't have any member</Text>
            )}
          </View>

          <HistoryBox
            funcRef={ref => (viewGroupContext.historyBox = ref)}
            queryObj={{
              group_id: data.id,
              sorts: "dtime"
            }}
          />
        </View>
        <ActionModal />
        <ScannerModal context={viewGroupContext} onSuccess={onSuccess} />
      </AppLayout>
    </ViewGroupContext.Provider>
  );
}

export default ViewGroup;
