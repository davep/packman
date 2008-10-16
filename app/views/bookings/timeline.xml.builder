xml.instruct! :xml, :version=>"1.0" 

xml.data "date-time-format" => "iso8601" do

  for booking in @bookings
    xml.event( %Q{
&lt;table&gt;
  &lt;tr&gt;
    &lt;th style="text-align: right;"&gt;Expected:&lt;/th&gt;
    &lt;td style="text-align: left;"&gt;#{booking.expected_pickup.to_s( :short )}&lt;/td/&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;th style="text-align: right;"&gt;Courier:&lt;/th&gt;
    &lt;td style="text-align: left;"&gt;#{booking.courier.name}&lt;/td/&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;th style="text-align: right;"&gt;For:&lt;/th&gt;
    &lt;td style="text-align: left;"&gt;#{booking.booked_for}&lt;/td/&gt;
  &lt;/tr&gt;
&lt;/table&gt;},
               :start => booking.expected_pickup.strftime('%Y-%m-%dT%H:%M:%S'),
               :title => "Pickup #{booking.overdue? ? 'overdue' : 'due'}",
               :link  => booking_url( booking ) )
  end
end
