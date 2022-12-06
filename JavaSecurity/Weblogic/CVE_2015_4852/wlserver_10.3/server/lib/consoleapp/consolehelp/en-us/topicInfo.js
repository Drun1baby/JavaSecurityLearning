
var version = "{wls.RELEASE}";

var new_window=null;
function makeWindow()
{
  if((new_window != null) &&(!new_window.closed))
  {
    new_window.close();
  }
  new_window = open('','feedback_window','resizable=1,scrollbars=yes,menubar=0,toolbar=0,status=0,outerHeight='+screen.availHeight+',outerWidth=720');
}

function getFeedbackURL()
{
  // load the tocAndContent.html page, which will look up the cookie and do the
  // right thing in the TOC and content panes.
  indexLocation = document.links[0].href;
  indexLocation = indexLocation.substring(0,indexLocation.lastIndexOf('/')) + '/feedback.html';
  return(indexLocation);
}

//
// write topic information. this function is called at the bottom of each content page
// to display the topic's real URL, version and feedback link
//
function writeTopicInfo()
{
  document.writeln('<hr size="1">');

  // write the feedback link
  document.write("{wls.FOOTER}");
}
