import React, { useContext } from "react";
import { AuthContext } from "$app-contexts";

function Logout() {
  const authContext = useContext(AuthContext);
  authContext.setAuthContext({
    userToken: null
  });
  return null;
}
export default Logout;
