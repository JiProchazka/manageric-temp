require 'digest/sha1'

class User
  include Mongoid::Document
  include ActiveModel::Validations

  field :full_name, type: String
  field :email, type: String
  field :password, type: String
  field :user_name, type: String
  field :token, type: String
  field :time_zone, type: String

  validates :full_name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :user_name, presence: true, length: { minimum: 3 }, uniqueness: true

  def self.authenticate(values)
    secured = Digest::SHA1.hexdigest values["password"]
    User.find_by(email: values["email"], password: secured)
  end

  def self.find_by_id(id)
    User.find BSON::ObjectId.from_string(id)
  end

  def self.find_by_full_name_or_user_name(term)
    User.where("$or" => [{full_name: /^#{term}/i}, {user_name: /^#{term}/i}]).only(:full_name, :user_name)
  end

  def create_token
    self.update_attribute(:token, SecureRandom.hex)
  end

  def self.token_exists?(token)
    User.where(token: token).exists?
  end
end
