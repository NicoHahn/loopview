class User < ApplicationRecord

  has_secure_password

  validates :email,
            format: { with: /(.+)@(.+)/, message: "Email invalid" },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }

  def full_name
    self.firstname + " " + self.lastname
  end

  def self.generate_password
    value = ""
    8.times{value  << (65 + rand(25)).chr}
    value
  end

end
