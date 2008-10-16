# $Id: courier.rb 8 2008-05-30 08:53:52Z davep $

class Courier < ActiveRecord::Base

  has_many :bookings

  validates_presence_of :name, :account_no, :contact
  validates_uniqueness_of :name

  before_destroy :destroyable?

  def self.find_all
    find( :all, :order => :name )
  end

  def self.name_condition( name )
    [ "name like :name", { :name => "%#{name}%" } ]
  end

  def self.find_by_name( name )
    find( :all, :order => :name, :conditions => Courier.name_condition( name ) )
  end

  def destroyable?
    self.bookings.empty?
  end
  
end
