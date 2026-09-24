import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static outlets = ['search-field']
  static targets = ['container']

  select(event) {
    event.preventDefault()

    const link = event.currentTarget

    const item = {
      text: link.innerText,
      value: link.querySelector('#item_id').value,
      type: link.querySelector('#item_type').value
    }

    this.searchFieldOutlet.display(item)
    this.containerTarget.innerText = ''
  }
}
