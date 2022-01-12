import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  connect() {
    this.channel = this.application.consumer.subscriptions.create(
      {
        channel: 'WorkingProjectTasksChannel'
      },
      {
        received (data) { if (data.cableReady) CableReady.perform(data.operations) }
      }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}