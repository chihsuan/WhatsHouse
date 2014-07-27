# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  string   "name"
#  string   "email"
#  datetime "created_at"
#  datetime "updated_at"
#  integer  "rent_houses_count",      default: 0
#  string   "encrypted_password",     default: "", null: false
#  string   "reset_password_token"
#  datetime "reset_password_sent_at"
#  datetime "remember_created_at"
#  integer  "sign_in_count",          default: 0,  null: false
#  datetime "current_sign_in_at"
#  datetime "last_sign_in_at"
#  string   "current_sign_in_ip"
#  string   "last_sign_in_ip"
#  string   "confirmation_token"
#  datetime "confirmed_at"
#  datetime "confirmation_sent_at"
#  string   "unconfirmed_email"
#  string   "provider"
#  string   "uid"



class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :sale_houses, dependent: :destroy
  has_many :rent_houses, dependent: :destroy
  has_many :authorizations, dependent: :destroy


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  private
end
