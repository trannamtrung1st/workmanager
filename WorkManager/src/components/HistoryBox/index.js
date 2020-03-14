import React, { useState } from "react";
import { View, Text, FlatList } from "react-native";
import s from "./style";
import EventApi from "$api/EventApi";

function HistoryBox(props) {
  let [history, setHistory] = useState(null);
  const selfRef = {
    reload
  };
  const { funcRef, queryObj } = props;
  if (funcRef) funcRef(selfRef);

  if (!history) {
    reload();
  }
  history = history ?? [];

  function reload() {
    EventApi.get(
      { fields: ["info", "user"], limit: 1000, ...queryObj },
      async resp => {
        if (resp.status == 401 || resp.status == 403) {
          alert("Unauthorized or access denied");
          return;
        }
        const data = await resp.json();
        if (resp.ok) {
          setHistory(data.data.results);
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

  return (
    <View style={s.tbl}>
      <Text style={s.formHeader}>HISTORY</Text>

      {history.length ? (
        history.map(item => (
          <View key={item.id} style={s.formItemContainer}>
            <View style={s.tblRow}>
              <Text>{item.message}</Text>
              <Text style={s.link}>{item.user.username}</Text>
              <Text style={s.italic}>Time: {item.time}</Text>
            </View>
          </View>
        ))
      ) : (
        <Text>Nothing</Text>
      )}
    </View>
  );
}

export default HistoryBox;
