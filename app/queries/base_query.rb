class BaseQuery
  def initialize(**args)
    @id = args[:id]&.to_i
  end

  def self.call(**args)
    new(**args).call
  end

  def call
    run
  end
end
