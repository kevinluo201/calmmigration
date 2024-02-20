import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  async subscribe() {
    navigator.serviceWorker.register('/service-worker.js')
    // When serviceWorker is supported, installed, and activated,
    // subscribe the pushManager property with the vapidPublicKey
    const options = {
      userVisibleOnly: true,
      applicationServerKey: window.vapidPublicKey
    };
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager.subscribe(options).then(
        async (pushSubscription) => {
          const response = await post('/webpush_notifications', { body: pushSubscription.toJSON() })
          if (response.ok) {
            console.log('Push subscription created successfully');
          }
        }
      );
    });
  }
}
