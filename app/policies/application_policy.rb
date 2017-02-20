class ApplicationPolicy
  attr_reader :current_guest, :record

  def initialize(current_guest, record)
    @guest = current_guest
    @record = record
  end
end
