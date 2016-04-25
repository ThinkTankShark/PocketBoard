class User < ActiveRecord::Base
  include BCrypt

  has_many :portfolios
  has_many :stocks_users
  has_many :stocks, through: :stocks_users


  # users.password_hash in the database is a :string

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


end

