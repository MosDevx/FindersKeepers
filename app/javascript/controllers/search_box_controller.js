// app/javascript/controllers/search_box_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"];

  connect() {
    this.timeout = null;
    
    // focus the input box
    this.inputTarget.focus();
    //set cursor at end of input
    this.inputTarget.setSelectionRange(this.inputTarget.value.length, this.inputTarget.value.length);


  }

  search(event) {
    event.preventDefault();
    console.log("seacrh called")
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value;
      document.getElementById("query-source").value = "autocomplete"
      fetch(`/autocomplete_search?query=${query}&source=autocomplete`, {
        headers: {
          'Turbo-Frame': 'search-results'
        }
      })
      .then(response => response.text())
      .then(html => {
        document.getElementById('search-results').innerHTML = html;
        // this.reset()
      });
    }, 800); // Delay to wait for user to stop typing
  }
  reset(event) {
    console.log("form reset")

    // Store the input field's value
    const inputValue = this.inputTarget.value;

    // Reset the form
    this.formTarget.reset();

    // Set the input field's value to its previous value
    this.inputTarget.value = inputValue;
    clearTimeout(this.timeout);
  }
  submit() {
    console.log("submit being called")
    clearTimeout(this.timeout);
  }

}
