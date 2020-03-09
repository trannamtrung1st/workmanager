import React from "react";
import { TouchableOpacity, ScrollView } from "react-native";
import Icon from "react-native-vector-icons/FontAwesome5";
import { View, Text } from "react-native";
import s from "./style";

function AppLayout(props) {
  const { navigation } = props;
  const { screenHeader } = props;
  function _onBtnMenuClick() {
    navigation.toggleDrawer();
  }

  return (
    <View style={s.layout}>
      <View style={s.header}>
        <Text style={s.headerText}>
          <Text style={s.appName}>WM</Text> APP
        </Text>
        <TouchableOpacity style={s.btnMenuContainer} onPress={_onBtnMenuClick}>
          <Icon name="list-ul" style={s.btnMenuIcon} />
        </TouchableOpacity>
      </View>

      <ScrollView style={s.content}>
        <View style={s.screenHeader}>
          <Text style={s.screenHeaderText}>{screenHeader}</Text>
        </View>
        {props.children}
      </ScrollView>
    </View>
  );
}

export default AppLayout;
