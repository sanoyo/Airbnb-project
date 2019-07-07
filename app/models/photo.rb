# frozen_string_literal: true

class Photo < ApplicationRecord
  # reference : https://github.com/thoughtbot/paperclip
  belongs_to :room

  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
