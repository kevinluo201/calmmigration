import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  static targets = ["text", "button"];
  static values = {
    vapidPublicKey: String,
    subscribed: Boolean
  }

  connect() {
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager.getSubscription().then((subscription) => {
        if (subscription) {
          this.subscribedValue = true;
        } else {
          this.subscribedValue = false;
        }
        this.updateElements();
      });
    });
  }

  updateElements() {
    if (this.subscribedValue) {
      this.textTarget.textContent = 'You already subscribed to push notifications!';
      this.buttonTarget.textContent = 'Unsubscribe';
    } else {
      this.textTarget.textContent = 'Subscribe to push notifications!';
      this.buttonTarget.textContent = 'Subscribe';
    }
  }

  toggleSubscription() {
    if (this.subscribedValue) {
      this.unsubscribe();
    } else {
      this.subscribe();
    }
  }

  async subscribe() {
    navigator.serviceWorker.register('/service-worker.js')

    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey
      }).then(
        async (pushSubscription) => {
          const response = await post('/webpush_notifications', { body: pushSubscription.toJSON() })
          if (response.ok) {
            this.subscribedValue = true;
            this.updateElements();
          }
        }
      );
    });
  }

  async unsubscribe() {
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager.getSubscription().then((subscription) => {
        if (subscription) {
          subscription.unsubscribe().then(() => {
            this.subscribedValue = false;
            this.updateElements();
          });
        }
      });
    });
  }
}
