# frozen_string_literal: true

require_relative 'base_destroy'

module Byg
  module Mutations
    # NODOC
    class DestroyUser     < BaseDestroy; end
    class DestroyBlog     < BaseDestroy; end
    class DestroyPost     < BaseDestroy; end
    class DestroyComment  < BaseDestroy; end
    class DestroyReaction < BaseDestroy; end
  end
end
