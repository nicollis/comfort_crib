class ProfilePolicy < ApplicationPolicy

  def index?
    @guest
  end

  def show?
    @guest
  end

  def new?
    @guest
  end

  def create?
    @guest
  end

  def update?
    @guest && @guest.profile == @record
  end

  def edit?
    @guest && @guest.profile == @record
  end

  def destroy?
    @guest && @guest.profile == @record
  end

end