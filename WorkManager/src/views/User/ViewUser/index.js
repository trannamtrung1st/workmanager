import React, { useState } from "react";
import { View, Text } from "react-native";
import { AppLayout, AppButton, AppInput, HistoryBox } from "$components";
import { Database } from "$services";
import { ViewUserContext } from "$app-contexts";
import s from "./style";

function ViewUser(props) {
  const { navigation, route } = props;
  const user = route.params.user;
  const [viewUserContext] = useState({
    historyBox: null
  });

  return (
    <ViewUserContext.Provider value={viewUserContext}>
      <AppLayout {...props} screenHeader="User information">
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
              <Text>Username</Text>
              <View style={s.inactiveInputContainer}>
                <AppInput editable={false} value={user.username} />
              </View>
            </View>
            <View style={s.formItemContainer}>
              <Text>Email</Text>
              <View style={s.inactiveInputContainer}>
                <AppInput editable={false} value={user.email} />
              </View>
            </View>
            <View style={s.formItemContainer}>
              <Text>Phone</Text>
              <View style={s.inactiveInputContainer}>
                <AppInput editable={false} value={user.phone_number} />
              </View>
            </View>
            <View style={s.formItemContainer}>
              <Text>Full name</Text>
              <View style={s.inactiveInputContainer}>
                <AppInput editable={false} value={user.full_name} />
              </View>
            </View>
            <View style={s.formItemContainer}>
              <Text>Code</Text>
              <View style={s.inactiveInputContainer}>
                <AppInput editable={false} value={user.employee_code} />
              </View>
            </View>

            {/* <View style={s.btnInputContainer}>
                  <AppButton text="UPDATE" onPress={() => {}} />
                </View> */}
          </View>

          <HistoryBox
            funcRef={ref => (viewUserContext.historyBox = ref)}
            queryObj={{
              user_id: user.id,
              sorts: "dtime"
            }}
          />
        </View>
      </AppLayout>
    </ViewUserContext.Provider>
  );
}

export default ViewUser;
