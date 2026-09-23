import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['submit', 'query', 'text', 'value', 'type']

  display(item) {
    this.queryTarget.value = item.text
    this.textTarget.value = item.text
    this.valueTarget.value = item.value
    this.typeTarget.value = item.type

    // Display only
    // this.textTarget.textContent = item.text
    // this.valueTarget.textContent = item.value
    // this.typeTarget.textContent = item.type
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submitTarget.click()
    }, 500)
  }
}
