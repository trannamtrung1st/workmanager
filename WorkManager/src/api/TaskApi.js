import { authFetch, toQuery } from "$app-helpers";
import { API } from "$constants";

function get(queryObj, response, error) {
  const query = queryObj ? "?" + toQuery(queryObj) : "";
  authFetch(API.endpoint + "tasks" + query)
    .then(response)
    .catch(error);
}

function create(model, response, error) {
  authFetch(API.endpoint + "tasks", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function deleteTask(id, response, error) {
  authFetch(API.endpoint + "tasks/" + id, {
    method: "DELETE"
  })
    .then(response)
    .catch(error);
}

function edit(model, response, error) {
  authFetch(API.endpoint + "tasks/" + model.id, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(model)
  })
    .then(response)
    .catch(error);
}

function changeStatus(id, formData, response, error) {
  const init = {
    method: "POST",
    headers: {
      "Content-Type": "multipart/form-data"
    },
    body: formData
  };
  authFetch(API.endpoint + "tasks/" + id + "/status", init)
    .then(response)
    .catch(error);
}

export default {
  changeStatus,
  edit,
  deleteTask,
  get,
  create
};
