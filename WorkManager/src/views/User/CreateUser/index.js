import React, { useState } from "react";
import { View, Text, TextInput, Picker } from "react-native";
import { AppLayout, AppButton, AppInput } from "$components";
import { CreateUserContext } from "$app-contexts";
import s from "./style";
import { HookHelper } from "@trannamtrung1st/t-components";
import { Database } from "$services";
import { UserApi } from "$api";

function CreateUser(props) {
  const { navigation } = props;
  const { users } = Database;
  const forceUpdate = HookHelper.useForceUpdate();
  const [createUserContext] = useState({
    data: {
      username: null,
      password: null,
      confirm_password: null,
      email: null,
      phone: null,
      full_name: null,
      employee_code: null,
      role: "User"
    }
  });
  const data = createUserContext.data;

  function _changeData(name, val) {
    data[name] = val;
    forceUpdate();
  }

  function _onSubmit() {
    UserApi.register(
      data,
      async resp => {
        console.log(resp);
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }

        if (resp.ok) {
          alert("Create successfully");
          navigation.goBack();
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
    <CreateUserContext.Provider value={createUserContext}>
      <AppLayout {...props} screenHeader="Create new user">
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
            <Text>Username</Text>
            <View style={s.inputContainer}>
              <AppInput
                autoCapitalize={"none"}
                textContentType="username"
                placeholder="Username"
                onChangeText={t => _changeData("username", t)}
                value={data.username}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Password</Text>
            <View style={s.inputContainer}>
              <AppInput
                autoCapitalize={"none"}
                secureTextEntry={true}
                textContentType="password"
                placeholder="Password"
                onChangeText={t => _changeData("password", t)}
                value={data.password}
              />
            </View>
          </View>
          <View style={s.formItemContainer}>
            <Text>Confirm password</Text>
            <View style={s.inputContainer}>
              <AppInput
                autoCapitalize={"none"}
                secureTextEntry={true}
                textContentType="password"
                placeholder="Confirm password"
                onChangeText={t => _changeData("confirm_password", t)}
                value={data.confirm_password}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Email</Text>
            <View style={s.inputContainer}>
              <AppInput
                keyboardType="email-address"
                textContentType="emailAddress"
                placeholder="Email"
                onChangeText={t => _changeData("email", t)}
                value={data.email}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Phone</Text>
            <View style={s.inputContainer}>
              <AppInput
                keyboardType="phone-pad"
                textContentType="telephoneNumber"
                placeholder="Phone"
                onChangeText={t => _changeData("phone", t)}
                value={data.phone}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Full name</Text>
            <View style={s.inputContainer}>
              <AppInput
                textContentType="name"
                placeholder="Full name"
                onChangeText={t => _changeData("full_name", t)}
                value={data.full_name}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Code</Text>
            <View style={s.inputContainer}>
              <AppInput
                placeholder="Code"
                onChangeText={t => _changeData("employee_code", t)}
                value={data.employee_code}
              />
            </View>
          </View>

          <View style={s.formItemContainer}>
            <Text>Role</Text>
            <View style={s.inputContainer}>
              <Picker
                mode="dropdown"
                style={s.inputContainer}
                onValueChange={v => _changeData("role", v)}
              >
                <Picker.Item label="User" value="User" />
                <Picker.Item label="Manager" value="Manager" />
              </Picker>
            </View>
          </View>

          <View style={s.btnInputContainer}>
            <AppButton text="SUBMIT" onPress={_onSubmit} />
          </View>
        </View>
      </AppLayout>
    </CreateUserContext.Provider>
  );
}

export default CreateUser;
