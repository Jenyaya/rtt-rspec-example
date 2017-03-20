require 'faker'

class UserManagementData

  attr_accessor :data

  def initialize

    @data = {
        :id => generate_uuidv4,
        :first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :address => {
            :state => Faker::Address.state,
            :street_name => Faker::Address.street_name,
            :secondary_address => Faker::Address.secondary_address
        }
    }
  end


  def first_name(first_name)
    @data[:first_name] ||= first_name
  end

  def last_name=(last_name)
    @data[:last_name] ||= last_name
  end

  def address=(address)
    @data[:address] ||= address
  end


end