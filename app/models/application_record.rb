# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController

  self.abstract_class = true

  def morph
    cable_ready["morph"].morph(
      selector: "#" + ActionView::RecordIdentifier.dom_id(self),
      html: render(self)
    )
    cable_ready.broadcast
  end
end
