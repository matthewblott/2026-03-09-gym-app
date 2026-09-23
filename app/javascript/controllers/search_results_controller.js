import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static outlets = ['search-field']
  static targets = ['container']

  select(event) {
    event.preventDefault()

    const item = {
      text: event.target.innerText,
      value: event.target.querySelector('#item_id').value,
      type: event.target.querySelector('#item_type').value
    }

    this.searchFieldOutlet.display(item)
    this.containerTarget.innerText = ''
  }
}
