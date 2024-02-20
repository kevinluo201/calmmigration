self.addEventListener("push", (event) => {
  if (!(self.Notification && self.Notification.permission === "granted")) {
    return;
  }

  const data = event.data?.json() ?? {};
  const title = data.title || "Something Has Happened";

  event.waitUntil(
    self.registration.showNotification(title, data)
  );
});

self.addEventListener("notificationclick", (event) => {
  const notification = event.notification;
  console.log("On notification click: ", notification);
  notification.close();
  event.waitUntil(
    clients.matchAll({ type: "window" }).then((clientList) => {
      for (let client of clientList) {
        if (client.url === notification.data.url && "focus" in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow(notification.data.url);
      }
    })
  );
});