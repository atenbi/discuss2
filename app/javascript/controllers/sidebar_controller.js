import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["sidebar"];

  connect() {
    this._initializeState();
    this._setupOutsideClickHandler();
  }

  toggle() {
    this.sidebarTarget.classList.toggle("hidden");
    this._saveState();
  }

  _initializeState() {
    const isOpen = sessionStorage.getItem("sidebarOpen") === "true";
    if (isOpen) {
      this.sidebarTarget.classList.remove("hidden");
    } else {
      this.sidebarTarget.classList.add("hidden");
    }
  }

  _saveState() {
    const isOpen = !this.sidebarTarget.classList.contains("hidden");
    sessionStorage.setItem("sidebarOpen", isOpen);
  }

  _setupOutsideClickHandler() {
    this.outsideClickHandler = (event) => {
      if (window.innerWidth >= 1024) return;
      
      if (!this.sidebarTarget.contains(event.target) && 
          !event.target.closest('[data-action="click->sidebar#toggle"]')) {
        if (!this.sidebarTarget.classList.contains("hidden")) {
          this.sidebarTarget.classList.add("hidden");
          this._saveState();
        }
      }
    };
    
    document.addEventListener("click", this.outsideClickHandler);
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClickHandler);
  }
}
