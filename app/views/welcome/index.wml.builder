xml.instruct! :xml, :version => "1.0"

xml.declare! :DOCTYPE, :wml, :PUBLIC, "-//WAPFORUM//DTD WML 1.1//EN", "http://www.wap.net/DTD/wml.xml"

xml.wml "xml:lang" => "en-gb" do
  
  xml.card :title => "Welcome to PackMan" do
    
    xml.p "There #{is_are_pluralize( Booking.count_waiting_pickup, 'booking' )} waiting to be despatched."
    xml.p "There #{is_are_pluralize( Booking.count_overdue, 'booking' )} overdue for despatch."

    if ( next_pickup = Booking.find_next_pickup )

      xml.p( if next_pickup.overdue?
               "Next pickup was due #{distance_of_time_in_words( Time.now, next_pickup.expected_pickup )} ago."
             else
               "Next pickup due in #{distance_of_time_in_words( Time.now, next_pickup.expected_pickup )}."
             end + " (#{next_pickup.expected_pickup.to_s( :short )})" )
    end
    
  end
  
end
