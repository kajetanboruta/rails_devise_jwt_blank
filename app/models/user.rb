class User < ApplicationRecord
  enum role: [:enduser, :admin]

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :orders
end
