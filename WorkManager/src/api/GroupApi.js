import { authFetch, toQuery } from "$app-helpers";
import { API } from "$constants";

function get(queryObj, response, error) {
  const query = queryObj ? "?" + toQuery(queryObj) : "";
  authFetch(API.endpoint + "groups" + query)
    .then(response)
    .catch(error);
}

function create(model, response, error) {
  authFetch(API.endpoint + "groups", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function deleteGroup(id, response, error) {
  authFetch(API.endpoint + "groups/" + id, {
    method: "DELETE"
  })
    .then(response)
    .catch(error);
}

function edit(model, response, error) {
  authFetch(API.endpoint + "groups/" + model.id, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function addUserToGroup(model, response, error) {
  authFetch(API.endpoint + "groups/user", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function removeUserFromGroup(id, response, error) {
  authFetch(API.endpoint + "groups/user", {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ id })
  })
    .then(response)
    .catch(error);
}

function changeUserRoleInGroup(id, response, error) {
  authFetch(API.endpoint + "groups/user", {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ id })
  })
    .then(response)
    .catch(error);
}

export default {
  removeUserFromGroup,
  changeUserRoleInGroup,
  addUserToGroup,
  edit,
  deleteGroup,
  get,
  create
};
