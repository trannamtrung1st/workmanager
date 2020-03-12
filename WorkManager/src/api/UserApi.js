import { API } from "$constants";
import AsyncStorage from "@react-native-community/async-storage";

function login(model, response, error) {
  fetch(API.endpoint + "users/login", {
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
    .then(success)
    .catch(error);
}

function logout() {
  AsyncStorage.removeItem("token");
}

async function getToken() {
  return await AsyncStorage.getItem("token");
}

function getTokenThen(success, error) {
  AsyncStorage.getItem("token")
    .then(success)
    .catch(error);
}

export default {
  getTokenThen,
  logout,
  login,
  saveToken,
  getToken
};
