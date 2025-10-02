import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    this.ga_defined = (typeof window.dataLayer !== "undefined");

    const cookiesAccepted = localStorage.getItem("cookiesAccepted");
    const deniedAt = localStorage.getItem("deniedAt");
    const time_24_hours = 24 * 60 * 60 * 1000
    const rejectionIntervalDate = deniedAt + time_24_hours;

    if (!cookiesAccepted && (!deniedAt || Date.now() > rejectionIntervalDate)) {
      this.setDefaultStateOfGoogleConsent();
      this.showCookieAcceptance();
    } else {
      this.enableGoogleConsent();
    }
  }

  deny(e) {
    e.preventDefault();

    localStorage.removeItem("cookiesAccepted");
    localStorage.setItem("deniedAt", Date.now());
    this.denyGoogleConsent();
    this.hideCookieAcceptance();
  }

  accept(e) {
    e.preventDefault();

    localStorage.setItem("cookiesAccepted", "true");
    localStorage.removeItem("deniedAt", Date.now());
    this.enableGoogleConsent();
    this.hideCookieAcceptance();
  }

  showCookieAcceptance() {
    this.element.classList.remove("hidden");
  }
  
  hideCookieAcceptance() {
    this.element.classList.add("hidden");
  }

  enableGoogleConsent() {
    const consentMode = {
      "ad_storage": "granted",
      "analytics_storage": "granted",
      "ad_user_data": "granted",
      "ad_personalization": "granted",
      "functionality_storage": "granted",
      "personalization_storage": "granted",
      "security_storage": "granted",
    };

    if (this.ga_defined) {
      window.dataLayer.push("consent", "update", consentMode);
    }

    localStorage.setItem("consentMode", JSON.stringify(consentMode));
  }

  denyGoogleConsent() {
    const consentMode = {
      "ad_storage": "denied",
      "analytics_storage": "denied",
      "ad_user_data": "denied",
      "ad_personalization": "denied",
      "functionality_storage": "denied",
      "personalization_storage": "denied",
      "security_storage": "denied",
    }

    if (this.ga_defined) {
      window.dataLayer.push("consent", "update", consentMode);
    }

    localStorage.setItem("consentMode", JSON.stringify(consentMode));
  }

  setDefaultStateOfGoogleConsent() {
    const consentMode = {
      "ad_storage": "denied",
      "analytics_storage": "denied",
      "ad_user_data": "denied",
      "ad_personalization": "denied",
      "functionality_storage": "denied",
      "personalization_storage": "denied",
      "security_storage": "denied",
    }

    if (this.ga_defined) {
      window.dataLayer.push("consent", "default", consentMode);
    }
  }
}
