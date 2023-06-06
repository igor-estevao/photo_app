import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  
  static targets = ['message'];
  
  connect() {
    this.applyMessageStyles();
  }

  applyMessageStyles() {
    // console.log(this.element)
    if(this.element.dataset.current=="true") {
      this.messageTarget.classList.add("right")
      this.element.parentElement.scrollTop = this.element.parentElement.scrollHeight
    }
  }
}
