class Coupler::Transformation < Sequel::Model
  many_to_one :resource
end
