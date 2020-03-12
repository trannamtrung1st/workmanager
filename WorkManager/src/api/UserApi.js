import { API } from "$constants";
import AsyncStorage from "@react-native-community/async-storage";
import { authFetch, toQuery } from "$app-helpers";

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
    .then(success)
    .catch(error);
}

function logout(success, error) {
  AsyncStorage.removeItem("token", success, error);
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

export default {
  getUsers,
  register,
  getTokenThen,
  logout,
  login,
  saveToken,
  getToken
};
