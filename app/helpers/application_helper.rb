# $Id: application_helper.rb 8 2008-05-30 08:53:52Z davep $

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Given something that looks like a UK phone number, return a link
  # that will work on a Skype-enabled machine.
  def skypeify( number )
    if number.at( 0 ) == "0"
      link_to( h( number ),
              "callto://+44#{number.from( 1 ).gsub( / /, '' )}",
              :class => :skype,
              :title => "Call this number with Skype" )
    else
      h( number )
    end
  end

  # Like the standard rails pluralize but prefixes the resulting
  # string with "is" or "are" depending on the count.
  def is_are_pluralize( count, singular, plural = nil )
    ( count == 1 ? "is" : "are" ) + " " + pluralize( count, singular, plural )
  end

  # Test if the request came from Pocket IE.
  def pocket_ie?( request )
    request.env[ "HTTP_USER_AGENT" ][ /MSIE.*Windows CE/ ]
  end
  
end
