import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  static values = { id: Number }
  static targets = [ "editor" ] 

  connect() {
    super.connect();
    this.subscribe()
  }

  editorTargetConnected() {
    this.channel.unsubscribe()
  }

  editorTargetDisconnected() {
    this.subscribe()
  }  

  disconnect() {
    this.channel.unsubscribe()
  }

  subscribe() {
    this.channel = this.application.consumer.subscriptions.create(
      {
        channel: 'IssueCommentsChannel',
        id: this.idValue
      },
      {
        received (data) { if (data.cableReady) CableReady.perform(data.operations)  }
      }
    )
  }
}