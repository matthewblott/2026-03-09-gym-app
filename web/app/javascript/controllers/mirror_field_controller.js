import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['source', 'hidden']

  sync() {
    this.hiddenTarget.value = this.sourceTarget.value
  }

  connect() {
    // sync initial value in case source is pre-filled
    this.sync()
  }
}
