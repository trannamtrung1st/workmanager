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

export default {
  deleteGroup,
  get,
  create
};
