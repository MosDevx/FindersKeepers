import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
	connect() {
    this.element.addEventListener('turbo:submit-start', () => {
      console.log("Reset being called")
      this.element.reset()
    })
  }
	reset() {
		console.log("Reset being called")
    this.element.reset()
  }
}
