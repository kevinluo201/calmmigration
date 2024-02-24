import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"];

  openModal() {
    this.modalTarget.classList.add('is-active');
  }

  closeModal() {
    this.modalTarget.classList.remove('is-active');
  }
}
