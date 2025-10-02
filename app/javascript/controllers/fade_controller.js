import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="fade"
export default class extends Controller {
  static values = {
    presenceTimeout: { type: Number, default: 2000 },
    dismissTimeout: { type: Number, default: 1000 }
  }
  connect() {
    this.timeout = setTimeout(() => this.dismiss(), this.presenceTimeoutValue);
  }

  dismiss() {
    this.element.style.transition = `opacity ${this.dismissTimeoutValue / 1000}s`;
    this.element.style.opacity = "0";

    setTimeout(() => this.element.remove(), this.dismissTimeoutValue);
  }

  disconnect() {
    clearTimeout(this.timeout);
  }
}
