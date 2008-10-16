/*
*/

var tl;
var eventSource;

function displayTimeline()
{
   eventSource = new Timeline.DefaultEventSource();
   
   var theme = Timeline.ClassicTheme.create();
   
   var bandInfos = [
      Timeline.createBandInfo( {
                                  eventSource:    eventSource,
                                  width:          "80%", 
                                  intervalUnit:   Timeline.DateTime.HOUR, 
                                  intervalPixels: 50,
                                  theme:          theme
                               } ),
      Timeline.createBandInfo( {
                                  showEventText:  false,
                                  trackHeight:    0.5,
                                  trackGap:       0.2,
                                  eventSource:    eventSource,
                                  width:          "20%", 
                                  intervalUnit:   Timeline.DateTime.DAY, 
                                  intervalPixels: 200,
                                  theme:          theme
                               } )
   ];

   bandInfos[ 1 ].syncWith  = 0;
   bandInfos[ 1 ].highlight = true;
   
   tl = Timeline.create( document.getElementById( "timeline" ),
                         bandInfos, Timeline.HORIZONTAL );

   Timeline.loadXML( "/bookings/timeline", function( xml, url ) {
                        eventSource.loadXML( xml, url );
                     } );
}

function refreshTimeline()
{
   eventSource.clear();
   Timeline.loadXML( "/bookings/timeline", function( xml, url ) {
                        eventSource.loadXML( xml, url );
                     } );
   tl.getBand( 0 ).setCenterVisibleDate( new Date() );
}