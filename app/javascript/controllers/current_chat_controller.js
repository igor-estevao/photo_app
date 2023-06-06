import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="current-chat"
export default class extends Controller {
  
  static targets = ["chatContent", "chatMessages"]

  connect() {
    if(this.hasChatContentTarget) {
      this.scrollBottom()
    }
  }

  scrollBottom() {    
    this.chatContentTarget.scrollTop = this.chatContentTarget.scrollHeight
  }
}
