import React, { useContext } from "react";
import { AuthContext } from "$app-contexts";

function Logout() {
  const authContext = useContext(AuthContext);
  authContext.logout();
  return null;
}
export default Logout;
