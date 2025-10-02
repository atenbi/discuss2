import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-preservation"
export default class extends Controller {
  static targets = ["scrollable"]
  
  connect() {
    this.restoreScroll();
  }

  preserveScroll() {
    const positions = {};

    this.scrollableTargets.forEach(element => {
      if (element.id) {
        positions[element.id] = element.scrollTop;
      }
    })

    sessionStorage.setItem("scrollPositions", JSON.stringify(positions));
  }

  restoreScroll() {
    const positions = this.getStoredPositions();

    this.scrollableTargets.forEach(element => {
      if (element.id && positions[element.id] !== undefined) {
        element.scrollTop = positions[element.id];
      }
    })
  }

  getStoredPositions() {
    try {
      return JSON.parse(sessionStorage.getItem("scrollPositions") || "{}");
    } catch {
      return {}
    }
  }
}
