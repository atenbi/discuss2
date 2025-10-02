import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="custom-select"
export default class extends Controller {
  static targets = ["list", "item", "selected", "input", "arrowIcon"];

  connect() {
    this.clickOutsideHandler = this._hideIfClickedOutside.bind(this);
    document.addEventListener("click", this.clickOutsideHandler);
  }

  toggle() {
    const isHidden = this.listTarget.classList.toggle("hidden");
    this._toggleArrowIcon(isHidden);
  }

  choose(e) {
    this._selectItem(e.currentTarget);
    this._closeDropdown();
  }

  chooseAndSubmit(e) {
    this._selectItem(e.currentTarget);
    this._closeDropdown();
    this._submitForm();
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutsideHandler);
  }

  // Private helper methods
  _selectItem(selectedItem) {
    const id = selectedItem.dataset.id;
    const label = selectedItem.innerText;
    
    this.selectedTarget.innerText = label;
    this.inputTarget.value = id;
  }

  _closeDropdown() {
    this.listTarget.classList.add("hidden");
    this._toggleArrowIcon(true);
  }

  _submitForm() {
    this.inputTarget.closest("form").submit();
  }

  _toggleArrowIcon(isHidden) {
    if (isHidden) {
      const closedIcon = this.arrowIconTarget.dataset.closedIcon || "keyboard_arrow_right";
      this.arrowIconTarget.innerText = closedIcon;
    } else {
      const openIcon = this.arrowIconTarget.dataset.openIcon || "keyboard_arrow_down";
      this.arrowIconTarget.innerText = openIcon;
    }
  }

  _hideIfClickedOutside(event) {
    if (!this.element.contains(event.target)) {
      this.listTarget.classList.add("hidden");
      this._toggleArrowIcon(true);
    }
  }
}
