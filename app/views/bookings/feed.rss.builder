xml.instruct! :xml, :version=>"1.0" 

xml.rss :version => "2.0" do

  xml.channel do

    xml.title       "PackMan - Expected Pickups"
    xml.description "Expected Pickups"
    xml.language    "en-gb"
    xml.link        bookings_url

    for booking in @bookings
      xml.item do
        xml.title       "Pickup due #{booking.expected_pickup}"
        xml.description %Q{Pickup expected at #{booking.expected_pickup} by
#{booking.courier.name} on package for #{booking.booked_for}.}
        xml.author      "PackMan"
        xml.pubDate     booking.updated_at.to_s
        xml.link        booking_url( booking )
        xml.guid        booking_url( booking )
      end
    end
    
  end
  
end
