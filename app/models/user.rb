class User < ActiveRecord::Base
	before_save { self.email = email.downcase}
	validates :username, uniqueness: { case_sensitive: false },
			   presence: true,  length: {minimum: 5, maximum: 20}
	VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, uniqueness: { case_sensitive: false },
			   presence: true, length: { maximum: 100 },
			   format: { with: VALID_EMAIL_REGEX }
	has_secure_password


  has_attached_file :user_avatar,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc {|style| "files/#{id}/#{user_avatar.original_filename}"}},styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :user_avatar, content_type: /\Aimage\/.*\Z/

	has_many :articles, dependent: :destroy
end
