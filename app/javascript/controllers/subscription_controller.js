import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  static targets = ["button"];
  static values = {
    vapidPublicKey: String,
    subscribed: Boolean
  }

  connect() {
    navigator.serviceWorker.register('/service-worker.js')
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
      this.buttonTarget.textContent = 'Unsubscribe from notifications';
      this.buttonTarget.classList.add('is-danger');
      this.buttonTarget.classList.add('is-outlined');
    } else {
      this.buttonTarget.textContent = 'Subscribe to notifications';
      this.buttonTarget.classList.remove('is-danger');
      this.buttonTarget.classList.remove('is-outlined');
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
