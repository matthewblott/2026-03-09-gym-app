// import { Application } from '@hotwired/stimulus'
// import { registerBridgeComponents } from '@joemasilotti/bridge-components'
//
// const application = Application.start()
//
// // Configure Stimulus development experience
// application.debug = false
// window.Stimulus   = application
//
// registerBridgeComponents(application)
//
// export { application }

import { Application } from "@hotwired/stimulus"
import { controllers } from "@joemasilotti/bridge-components"

const application = Application.start()
application.debug = false
window.Stimulus = application

application.load(controllers)

export { application }
