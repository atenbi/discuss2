import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "arrowIcon"];
  static values = {
    shouldHideOnOutsideClick: { type: Boolean, default: true },
    shouldSaveState: { type: Boolean, default: false },
    shouldUpdateArrowIcon: { type: Boolean, default: true },
    openByDefault: { type: Boolean, default: false },
    uniqueKey: { type: String, default: "dropdownState" },
  };

  connect() {
    if (this.openByDefaultValue && sessionStorage.getItem(this.uniqueKeyValue) === null) {
      sessionStorage.setItem(this.uniqueKeyValue, true);
    }

    this.isOpen = this.shouldSaveStateValue ? sessionStorage.getItem(this.uniqueKeyValue) === "true" : false;
    this.menuTarget.classList.toggle("hidden", !this.isOpen);
    this._toggleArrowIcon();

    if (this.shouldHideOnOutsideClickValue) {
      this.clickOutsideHandler = this._hideIfClickedOutside.bind(this);
      document.addEventListener("click", this.clickOutsideHandler);
    }
  }

  disconnect() {
    if (this.shouldHideOnOutsideClickValue) {
      document.removeEventListener("click", this.clickOutsideHandler);
    }
  }

  toggle(event) {
    event.stopPropagation();
    this.isOpen = !this.isOpen;
    this.menuTarget.classList.toggle("hidden", !this.isOpen);

    if (this.shouldSaveStateValue) {
      sessionStorage.setItem(this.uniqueKeyValue, this.isOpen);
    }

    this._toggleArrowIcon();
  }

  _toggleArrowIcon() {
    if (this.hasArrowIconTarget && this.shouldUpdateArrowIconValue) {
      this.arrowIconTarget.innerText = this.isOpen ? "keyboard_arrow_down" : "keyboard_arrow_right";
    }
  }

  _hideIfClickedOutside(event) {
    if (!this.element.contains(event.target)) {
      this.isOpen = false;
      this.menuTarget.classList.add("hidden");

      if (this.shouldSaveStateValue) {
        sessionStorage.setItem(this.uniqueKeyValue, false);
      }

      this._toggleArrowIcon();
    }
  }
}
