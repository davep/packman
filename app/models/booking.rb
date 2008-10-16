# $Id: booking.rb 8 2008-05-30 08:53:52Z davep $

class Booking < ActiveRecord::Base

  belongs_to :courier
  belongs_to :booking_user,  :class_name => "User", :foreign_key => "booked_by"
  belongs_to :despatch_user, :class_name => "User", :foreign_key => "despatched_by"

  validates_presence_of :booked_when
  validates_presence_of :booked_by
  validates_presence_of :booked_for
  validates_presence_of :destination
  validates_presence_of :booking_ref
  validates_presence_of :matter_number
  validates_presence_of :expected_pickup
  validates_presence_of :despatched_ref, :if => Proc.new {|b| b.despatched? }

  # Returns the condition for bookings that are waiting for pickup.
  def self.waiting_pickup_condition
    "despatched_when is null"
  end

  # Find all bookings waiting for pickup.
  def self.find_waiting_pickup
    find( :all, :order => :expected_pickup, :conditions => Booking.waiting_pickup_condition )
  end

  # Find the next booking awaiting for pickup.
  def self.find_next_pickup
    find( :first, :order => :expected_pickup, :conditions => Booking.waiting_pickup_condition )
  end

  # Count the number of bookings waiting for pickup.
  def self.count_waiting_pickup
    count( :conditions => Booking.waiting_pickup_condition )
  end

  # Returns the condition for all overdue bookings.
  def self.overdue_condition
    [ "expected_pickup < :now and despatched_when is null", { :now => Time.now } ]
  end

  # Find all overdue bookings.
  def self.find_overdue
    find( :all, :order => :expected_pickup, :conditions => Booking.overdue_condition )
  end

  # Returns a count of all overdue bookings.
  def self.count_overdue
    count( :conditions => Booking.overdue_condition )
  end

  # Returns the condition for all bookings with a given courier.
  def self.booked_with( courier )
    [ "courier_id = :courier_id", { :courier_id => courier } ]
  end

  # Returns the condition for all despacted bookings.
  def self.despatched_condition
    "despatched_when is not null"
  end

  # Find all despacted bookings.
  def self.find_despatched
    find( :all, :order => :despatched_when, :conditions => Booking.despatched_condition )
  end

  # Is this booking waiting to be picked up?
  def waiting_pickup?
    self.despatched_when.blank?
  end

  # Has this booking been despacted?
  def despatched?
    not waiting_pickup?
  end

  # Is this booking overdue a pickup?
  def overdue?( compared_to = Time.now )
    waiting_pickup? and self.expected_pickup < compared_to
  end

end
