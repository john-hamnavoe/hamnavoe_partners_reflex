import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

/* This is your ApplicationController.
 * All StimulusReflex controllers should inherit from this class.
 *
 * Example:
 *
 *   import ApplicationController from './application_controller'
 *
 *   export default class extends ApplicationController { ... }
 *
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  reload () {
  }

  afterEdit (element) {
    console.log("after edit")
    const input = document.querySelector('input[type="text"]')
    const value = input.value
    input.focus()
    input.value = ''
    input.value = value
  }  

  afterNew (element) {
    console.log("after new")    
    const input = document.querySelector('input[type="text"]')
    const value = input.value
    input.focus()
    input.value = ''
    input.value = value
  }  
}
