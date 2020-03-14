import { authFetch, toQuery } from "$app-helpers";
import { API } from "$constants";

function get(queryObj, response, error) {
  const query = queryObj ? "?" + toQuery(queryObj) : "";
  authFetch(API.endpoint + "events" + query)
    .then(response)
    .catch(error);
}

export default {
  get
};
