function handleNotification(notification) {
  if (!notification) return;
  console.log("NOTIFICATION:", notification);
  alert("Go to the entity specified in message to see the detail information");
}

export default {
  handleNotification
};
