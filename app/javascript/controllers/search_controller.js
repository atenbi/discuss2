import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";

// Connects to data-controller="search"
export default class extends Controller {
  static debounces = ["performSearch"];

  connect() {
    useDebounce(this, { wait: 300 });
  }

  performSearch(event) {
    event.target.form.requestSubmit();
  }
}
