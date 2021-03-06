# frozen-string-literal: true

require "down/version"

module Down
  module_function

  def download(*args, &block)
    backend.download(*args, &block)
  end

  def open(*args, &block)
    backend.open(*args, &block)
  end

  def backend(value = nil)
    if value.is_a?(Symbol)
      require "down/#{value}"
      @backend = Down.const_get(value.to_s.split("_").map(&:capitalize).join)
    elsif value
      @backend = value
    else
      backend :net_http if @backend.nil?
      @backend
    end
  end

  def backend=(value)
    @backend = value
  end
end
