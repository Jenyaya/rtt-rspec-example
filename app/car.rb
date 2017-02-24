class Car
  attr_accessor :brand, :model

  def initialize()
    @brand = 'toyota'
    @model = 'corolla'
  end

  def is_brand?(brand)
    brand.eql? @brand
  end

end
