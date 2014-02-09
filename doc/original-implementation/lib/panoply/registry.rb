module Panoply
  class Registry
    attr_reader :recipes

    def register &block
      instance_eval &block
    end

    def map klass, options = Hash.new
      @recipes ||= {}
      @recipes[klass] = options.fetch :to, nil
    end

    def self.register &block
      @repository = new
      @repository.register &block
    end

    def self.recipe klass
      @repository.recipes.fetch klass, nil
    end

    def self.product klass
      @repository.recipes.invert.fetch klass, nil
    end

  end
end