import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['submit', 'query', 'text', 'value', 'cardio', 'weights']

  display(item) {
    this.queryTarget.value = item.text
    this.textTarget.value = item.text
    this.valueTarget.value = item.value
    
    if(item.type === 'cardio') {
      this.cardioTarget.checked = true
      this.weightsTarget.checked = false
    } else {
      this.cardioTarget.checked = false
      this.weightsTarget.checked = true
    }

  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submitTarget.click()
    }, 500)
  }
}
