class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :name, :email, :role_id, :client_id

	belongs_to :role
  belongs_to :client
  has_many :service_orders

  validates :name, :email, :role_id, presence: true
  validates :password, presence: true, on: :creation
  validates :email, uniqueness: true

  scope :colaborators, -> { joins(:role).where("roles.name in (?)",["Colaborador","Admin"]) }
  scope :as_clients, -> { joins(:role).where("roles.name = ?", "Cliente") }

  def total_time
    worked_times = self.service_orders.map(&:total_time)
    StringTime.new(worked_times).total_time
  end

  def admin?
    role.admin?
  end

  def colaborator?
    role.colaborator?
  end

  def client?
    role.client?
  end

  def client_name
    client.name if client.present? 
  end
end
