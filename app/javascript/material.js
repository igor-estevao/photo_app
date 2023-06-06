
export function autoinitMaterial() { // M.AutoInit() is breaking toasts, sice it auto inits all twice
  initDropdowns()
  initNavbars()
  initFloatingButtonn()
  initCollaplsables()
  initSelects()
  M.updateTextFields()
}
export function initDropdowns() {
  var elems = document.querySelectorAll('.dropdown-trigger')
  M.Dropdown.init(elems)
}
export function initNavbars() {
  var elems = document.querySelectorAll('.sidenav')
  M.Sidenav.init(elems)
}

export function initFloatingButtonn() {
  var elems = document.querySelectorAll('.fixed-action-btn')
  M.FloatingActionButton.init(elems)
}

export function initCollaplsables() {
  var elems = document.querySelectorAll('.collapsible')
  M.Collapsible.init(elems)
}

export function initSelects() {
  var elems = document.querySelectorAll('select')
    M.FormSelect.init(elems)
}