import { G } from "$global";

function authFetch(inp, init = {}) {
  if (!init.headers) init.headers = {};
  if (G.tokenModel)
    init.headers["Authorization"] = "Bearer " + G.tokenModel.access_token;
  return fetch(inp, init);
}

export default {
  authFetch
};

function toQuery(obj) {
  let str = [];
  for (let k in obj) str.push(k + "=" + obj[k]);
  return str.join("&");
}

export { authFetch, toQuery };
