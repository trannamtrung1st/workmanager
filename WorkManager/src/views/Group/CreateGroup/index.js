import React, { useState } from "react";
import { View, Text, TextInput } from "react-native";
import { AppLayout, AppButton, AppInput } from "$components";
import { CreateGroupContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import { Database } from "$services";

function CreateGroup(props) {
  const { navigation } = props;
  const { groups } = Database;
  const forceUpdate = HookHelper.useForceUpdate();
  const [createUserContext] = useState({
    data: {
      name: null,
      description: null
    }
  });
  const data = createUserContext.data;

  function _changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

  return (
    <CreateGroupContext.Provider value={createUserContext}>
      <AppLayout {...props} screenHeader="Create new group">
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
                placeholder="Name"
                onChangeText={t => _changeData("name", t)}
                value={data.name}
              />
            </View>
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
            <AppButton
              text="SUBMIT"
              onPress={() => {
                navigation.goBack();
              }}
            />
          </View>
        </View>
      </AppLayout>
    </CreateGroupContext.Provider>
  );
}

export default CreateGroup;
