class Base
  def on_success
    yield if errors.nil? || errors&.empty?
  end

  def on_fail
    yield if errors&.any?
  end
end