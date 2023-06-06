import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
  }
  initialize() {
    M.toast({html: this.element.innerHTML, classes: this.getStyle()})
  }
  onDismessed() {
    // alert('Your toast was dismissed')
  }
  getStyle(){
    var style = ""
    if(this.element.dataset.key.toString() == "error") style = style + "red"
    if(this.element.dataset.key.toString() == "notice") style = style + "blue"
    return style
  }

}
