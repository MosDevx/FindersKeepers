// app/javascript/controllers/search_box_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.timeout = null;


  }

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value;
      fetch(`/search_articles?query=${query}`, {
        headers: {
          'Turbo-Frame': 'search-results'
        }
      })
      .then(response => response.text())
      .then(html => {
        document.getElementById('search-results').innerHTML = html;
      });
    }, 800); // Delay to wait for user to stop typing
  }
}
