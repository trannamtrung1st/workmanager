import React, { useState, useContext } from "react";
import { View, Text, TextInput } from "react-native";
import Icon from "react-native-vector-icons/FontAwesome5";
import s from "./style";
import { AuthContext } from "$app-contexts";
import { AppButton, AppInput } from "$components";
import { UserApi } from "$api";
import { G } from "$global";

function Login(props) {
  const authContext = useContext(AuthContext);
  const [username, setUsername] = useState(null);
  const [password, setPassword] = useState(null);

  function _login() {
    UserApi.login(
      {
        username,
        password,
        fcm_token: G.currentFCMToken
      },
      async resp => {
        const data = await resp.json();
        if (resp.ok) {
          authContext.login(data);
        } else {
          alert(data.message);
        }
      },
      err => {
        alert("Something's wrong");
      }
    );
  }

  function _onUsernameChanged(v) {
    setUsername(v);
  }

  function _onPassChanged(v) {
    setPassword(v);
  }

  return (
    <View style={s.page}>
      <View style={s.form}>
        <View style={s.header}>
          <Text style={s.headerText}>
            <Text style={s.headerTextApp}>WM</Text> APP
          </Text>
        </View>
        <View style={s.body}>
          <View style={s.inputContainer}>
            <Icon name="user" style={s.inputIcon} />
            <AppInput
              autoCapitalize={"none"}
              textContentType="username"
              onChangeText={_onUsernameChanged}
              style={s.input}
              placeholder="Username"
              value={username}
            />
          </View>
          <View style={s.inputContainer}>
            <Icon name="key" style={s.inputIcon} />
            <AppInput
              autoCapitalize={"none"}
              secureTextEntry={true}
              onChangeText={_onPassChanged}
              textContentType={"password"}
              style={s.input}
              placeholder="Password"
              value={password}
            />
          </View>
          <AppButton onPress={_login} text="LOGIN" btnStyle={s.btnLogin} />
        </View>
      </View>
    </View>
  );
}

export default Login;
