# $Id: couriers_helper.rb 23 2008-06-01 12:26:36Z davep $

module CouriersHelper

  def tel_desc( desc, alt )
    desc.empty? ? alt : desc
  end
  
end
