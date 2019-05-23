module Services
  module Data
    def self.call(input)
      vehicle_input = VehicleInput.new(input)
      normalizer = VehicleInputNormalizer.new(
        vehicle_input,
        makers: ['Chevrolet', 'Ford'],
        models: ['Focus', 'Impala'],
        trims: ['ST', 'SE']
      )
      normalizer.perform
    end
  end
end

class VehicleInput
  attr_reader :year, :make, :model

  def initialize(input)
    @year = input[:year]
    @make = input[:make]
    @model = VehicleModelInput.new(input[:model], input[:trim])
  end
end

class VehicleModelInput
  attr_reader :name, :trim

  def initialize(name, trim)
    @name = name
    @trim = trim
  end
end

class VehicleInputNormalizer
  def initialize(vehicle_input, makers:, models:, trims:)
    @vehicle_input = vehicle_input
    @makers = makers
    @models = models
    @trims = trims
  end

  def perform
    {
      year: InputYear.new(@vehicle_input.year),
      make: InputMake.new(@vehicle_input.make, @makers),
      model: InputModel.new(@vehicle_input.model.name, @models),
      trim: InputTrim.new(@vehicle_input.model, @trims)
    }.transform_values!(&:normalized_value)
  end
end

class VehicleInputAttribute
  attr_reader :value, :normalized_value

  def initialize(value, options = [])
    @value = value
    @options = options
    @normalized_value = normalize
  end

  def normalize
    return nil if @value == 'blank'
    transform_attribute
    return @normalized_value unless @normalized_value.nil?
    @value
  end

  def transform_attribute;end
end

class InputYear < VehicleInputAttribute
  MIN_YEAR = 1_900
  YEARS_FROM_NOW = 2

  def transform_attribute
    year = @value.to_i
    @normalized_value = year if year > MIN_YEAR && year < Time.now.year + YEARS_FROM_NOW
  end
end

class InputMake < VehicleInputAttribute
  def transform_attribute
    @normalized_value = @options.detect { |maker| maker =~ /#{@value}/i }
  end
end

class InputModel < VehicleInputAttribute
  def transform_attribute
    @normalized_value = @options.detect { |model| @value =~ /#{model}/i }
  end
end

class InputTrim < VehicleInputAttribute
  def initialize(model, options = [])
    @model = model.name
    super(model.trim, options)
  end

  def transform_attribute
    trim_input = @value.empty? ? @model : @value
    @normalized_value = @options.detect { |trim| trim_input =~ /#{trim}/i }
  end
end
