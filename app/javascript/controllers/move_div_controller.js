import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.chatrooms = document.getElementById("chatrooms")
    this.resizeCallback = this.resize.bind(this)
    window.addEventListener("resize", this.resizeCallback)
    this.resize()
  }

  disconnect() {
    this.element.removeEventListener("resize", this.resizeCallback)
    window.removeEventListener("resize", this.resizeCallback)
  }

  resize = debounce(() => {
    if (window.innerWidth < 992) { // Medium screens and smaller
      document.getElementById("mobile-sidenav").appendChild(this.chatrooms);
    } else { // Large screens
      this.element.appendChild(this.chatrooms);
    }
    console.log("resized")
  })
}
function debounce(func, wait = 1, immediate = true) {
  let timeout;
  return function() {
    const context = this, args = arguments;
    const later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    const callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}