import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="data-layer"
export default class extends Controller {
  initialize() {
    window.dataLayer = window.dataLayer || [];
  }

  buildYourCommunityClick() {
    const eventData = {
      event: "build_your_community_click"
    };

    window.dataLayer.push(eventData);
  }

  seeDemoClick() {
    const eventData = {
      event: "see_demo_click",
    };

    window.dataLayer.push(eventData);
  }
}
