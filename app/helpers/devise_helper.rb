# frozen_string_literal: true

BOOTSTRAP_FLASH_TYPES = {
  'alert' => 'warning',
  'error' => 'danger',
  'notice' => 'success'
}.freeze
module DeviseHelper
  def bootstrap_alert(key)
    BOOTSTRAP_FLASH_TYPES[key]
  end
end
