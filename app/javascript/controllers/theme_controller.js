// app/javascript/controllers/theme_controller.js
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["icon"]

  connect() {
    if (this.shouldUseDarkTheme()) {
      this.enableDarkMode();
      this.updateToggleUI(true);
    } else {
      this.updateToggleUI(false);
    }
  }

  toggle(event) {
    if (event) event.preventDefault();
    
    const isDarkMode = document.documentElement.classList.contains('dark');
    
    if (isDarkMode) {
      this.light(event);
      this.updateToggleUI(false);
    } else {
      this.dark(event);
      this.updateToggleUI(true);
    }
  }

  updateToggleUI(isDarkMode) {
    if (this.hasIconTarget) {
      if (isDarkMode) {
        this.iconTarget.textContent = "dark_mode";
      } else {
        this.iconTarget.textContent = "light_mode";
      }
    }
  }

  dark(event) {
    if (event) event.preventDefault();
    this.setThemeStorage("dark");
    this.enableDarkMode();
    this.updateToggleUI(true);
  }

  light(event) {
    if (event) event.preventDefault();
    this.setThemeStorage("light");
    this.disableDarkMode();
    this.updateToggleUI(false);
  }

  shouldUseDarkTheme() {
    const storedTheme = localStorage.getItem("theme");
    const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
    return storedTheme === "dark" || (!storedTheme && prefersDark);
  }

  enableDarkMode() {
    document.documentElement.classList.add("dark");
  }

  disableDarkMode() {
    document.documentElement.classList.remove("dark");
  }

  setThemeStorage(value) {
    localStorage.setItem("theme", value);
  }
}
