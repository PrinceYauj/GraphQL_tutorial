# frozen_string_literal: true

module Byg
  module Helper
    def class_name(klass)
      name = klass.name.split('::').last
      name[0].downcase + name[1..-1]
    end

    def hash_to_str(hash)
      hash.map { |k, v| "#{k}: #{v.inspect}" }.join(', ')
    end

    def generate_mutation(klass, hash)
      "mutation { #{class_name(klass)} ( #{hash_to_str(hash)} ) { id } }"
    end

    # def to_camel(hash)
    #  hash.transform_keys! do |k|
    #    k.to_s.gsub(/_./) { |m| m[-1].upcase! }.to_sym
    #  end
    # end

    def to_snake(hash)
      hash.transform_keys do |k|
        k.to_s.gsub(/[A-Z]/) { |m| "_#{m.downcase}" }.to_sym
      end
    end
  end
end
