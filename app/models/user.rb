# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates(:email,
     {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
     }
  )
  has_secure_password

  # def todos
  #   return Todo.where({ :user_id => self.id })
  # end
end
