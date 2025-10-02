module Forum
  class PostPolicy < ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.all
      end
    end

    def edit?
      update?
    end

    def update?
      destroy?
    end

    def destroy?
      user.has_any_role?(:admin, :moderator) || user == record.user
    end
  end
end
