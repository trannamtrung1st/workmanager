import { authFetch } from "$app-helpers";
import { API } from "$constants";

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
export default {
  create
};
