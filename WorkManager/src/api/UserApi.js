import { API } from "$constants";
import AsyncStorage from "@react-native-community/async-storage";
import { authFetch, toQuery } from "$app-helpers";
import messaging from "@react-native-firebase/messaging";
import { G } from "$global";

function login(model, response, error) {
  authFetch(API.endpoint + "users/login", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function saveToken(tokenModel, success, error) {
  AsyncStorage.setItem("token", JSON.stringify(tokenModel))
    .then(v => {
      messaging()
        .subscribeToTopic(tokenModel.user_id)
        .then(v => {
          if (success) success(v);
        });
    })
    .catch(error);
}

function logout(finish, error) {
  authFetch(API.endpoint + "users/logout", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      fcm_token: G.currentFCMToken
    })
  })
    .then(v => {
      AsyncStorage.removeItem("token", err => {
        if (!err) messaging().unsubscribeFromTopic(G.tokenModel.user_id);
        if (finish) finish(err);
      });
    })
    .catch(error);
}

async function getToken() {
  return await AsyncStorage.getItem("token");
}

function getTokenThen(success, error) {
  AsyncStorage.getItem("token")
    .then(success)
    .catch(error);
}

function register(model, response, error) {
  authFetch(API.endpoint + "users", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function getUsers(queryObj, response, error) {
  const query = queryObj ? "?" + toQuery(queryObj) : "";
  authFetch(API.endpoint + "users" + query)
    .then(response)
    .catch(error);
}

function deleteUser(id, response, error) {
  authFetch(API.endpoint + "users/" + id, {
    method: "DELETE"
  })
    .then(response)
    .catch(error);
}

export default {
  deleteUser,
  getUsers,
  register,
  getTokenThen,
  logout,
  login,
  saveToken,
  getToken
};
