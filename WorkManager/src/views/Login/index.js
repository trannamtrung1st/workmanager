import React, { useState, useContext } from "react";
import { View, Text } from "react-native";
import { TextButton } from "@trannamtrung1st/t-components";
import { TextInput } from "react-native-gesture-handler";
import Icon from "react-native-vector-icons/FontAwesome5";
import s from "./style";
import { AuthContext } from "$app-contexts";

function Login(props) {
  const authContext = useContext(AuthContext);
  const [username, setUsername] = useState(null);
  const [password, setPassword] = useState(null);

  function _login() {
    console.log(username + "-" + password);
    authContext.setAuthContext({
      userToken: "token"
    });
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
            <TextInput
              onChangeText={_onUsernameChanged}
              style={s.input}
              placeholder="Username"
              value={username}
            />
          </View>
          <View style={s.inputContainer}>
            <Icon name="key" style={s.inputIcon} />
            <TextInput
              secureTextEntry={true}
              onChangeText={_onPassChanged}
              textContentType={"password"}
              style={s.input}
              placeholder="Password"
              value={password}
            />
          </View>
          <TextButton
            onPress={_login}
            text="LOGIN"
            btnStyle={s.btnLogin}
            textStyle={s.btnLoginText}
          />
        </View>
      </View>
    </View>
  );
}

export default Login;
