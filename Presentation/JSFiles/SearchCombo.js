var selectedOption = 0;
var KeyPressEnabled = false;
//var KeyPressEnabled = true;
var selectValue = "";
var popup = null;
var divId = "";
function SelectChange(anchorname)
{
   // We use this function to disable any dynamic selecting of the
   // combo-box when the user uses the mouse to select items.
	
   if (KeyPressEnabled)
   {
      document.getElementById(anchorname).selectedIndex = selectedOption;
	  if(popup != null)
	  {
        popup.populate(selectValue);
	    popup.refresh();
	  }
   }
}

function Select()
{
	selectValue = "";
	if(popup != null)
	{
		popup.populate(selectValue);
		popup.refresh();
		popup.hidePopup();
	}
}

function ArrowKeyPress(anchorname)
{
   var control = document.getElementById(anchorname);

//alert(event.keyCode);
   // Keycode 38 and 40 are the up and down arrow buttons, in case the user
   // uses the arrow keys to select items. We reset the value of what they
   // have typed and change the global selected item value.
   if (event.keyCode == 38)
   {
      selectedOption = control.selectedIndex - 1;
   }

   else if (event.keyCode == 40)
   {
      selectedOption = control.selectedIndex + 1;
   }
   // Kyecode 8 is back space
   if (event.keyCode == 8)
   {
      selectValue = selectValue.substring(0,selectValue.length -1);
      popup.populate(selectValue);
 	  popup.refresh();
      popup.showPopup(anchorname);
      if(selectValue.length == 0)
      {
	      selectValue = "";
  	      popup.refresh();
	      popup.hidePopup();
      }
      window.event.returnValue=false;
      return;
   }

   else
   {
   		return;
   }
	if(popup != null)
	{
      selectValue = "";
      popup.populate(selectValue);
      popup.refresh();
      popup.showPopup(anchorname);

		if(control.selectedIndex > 0)
		{
		    selectedOption = control.selectedIndex - 1;
	    }
//		return;
	}
}

function KeyPress(anchorname, div)
{

	if(popup == null)
	{
		popup = new PopupWindow(div);
		divId = div;
		popup.offsetY = 20;
		popup.offsetX = 5;
		popup.autoHide();
	}
	if(divId != div)
	{
		popup = new PopupWindow(div);
		divId = div;
		popup.offsetY = 20;
		popup.offsetX = 5;
		popup.autoHide();

	}


   KeyPressEnabled = true;
   var Drop1 = document.getElementById(anchorname);

   // Keycode 38 and 40 are the up and down arrow buttons, in case the user
   // uses the arrow keys to select items. We reset the value of what they
   // have typed and change the global selected item value.
   if (event.keyCode == 38)
   {
      selectValue = "";
      popup.populate(selectValue);
      popup.refresh();
      popup.showPopup(anchorname);
      selectedOption = Drop1.selectedIndex - 1;
      return;
   }

   if (event.keyCode == 40)
   {
      selectValue = "";
      popup.populate(selectValue);
 	  popup.refresh();
      popup.showPopup(anchorname);
      selectedOption = Drop1.selectedIndex + 1;
      return;
   }


   // Keycode 27 is escape, so the user can clear out what
   // they have typed so far
   if (event.keyCode == 27)
   {
      Drop1.selectedIndex = 0;
      selectValue = "";
      popup.populate(selectValue);
 	  popup.refresh();
      popup.showPopup(anchorname);
      return;
   }

   // Kyecode 8 is back space
   if (event.keyCode == 8)
   {
      alert("bc " );
      selectValue = selectValue.substring(0,selectValue.length -1);
      popup.populate(selectValue);
 	  popup.refresh();
      popup.showPopup(anchorname);
      if(selectValue.length == 0)
      {
	      selectValue = "";
  	      popup.refresh();
	      popup.hidePopup();
      }
      return;
   }


   // Convert the ASCII keycode value to a character and add the key
   // entered to a "buffer". Normally, this would be a hidden field.

	  selectValue += String.fromCharCode(event.keyCode).toLowerCase();
      popup.populate(selectValue);
      popup.showPopup(anchorname);


   // Loop through the select list to find any matches
  // for (x = 0; x < main.Drop1.length; x++)
   for (x = 0; x < Drop1.length; x++)
   {
      var OptionText = Drop1.options[x].text;
      var tmpOptionText = "";

      // Loop through the value of each select item, and if there is a
      // match on what they have typed in, set the global variable for that value.
       // The browser will run the onChange event since you typed a key. We'll. '
      // run SelectChange() in the onChangeEvent just to be sure.
      for (y = 0; y < OptionText.length; y ++)
      {
         tmpOptionText += OptionText.charAt(y).toLowerCase();

//         if (tmpOptionText == main.Typed.value)
         if (tmpOptionText == selectValue)
         {
            Drop1.selectedIndex = x;
            selectedOption = x;
            return;
         }
      }
   }
}
function setTextBoxPosition() {
	var docForm=document.myForm;
}

function setKeyPressEnabled()
{
	KeyPressEnabled = false;
}


/* SOURCE FILE: AnchorPosition.js */
function getAnchorPosition(anchorname){var useWindow=false;var coordinates=new Object();var x=0,y=0;var use_gebi=false, use_css=false, use_layers=false;if(document.getElementById){use_gebi=true;}else if(document.all){use_css=true;}else if(document.layers){use_layers=true;}if(use_gebi && document.all){x=AnchorPosition_getPageOffsetLeft(document.all[anchorname]);y=AnchorPosition_getPageOffsetTop(document.all[anchorname]);}else if(use_gebi){var o=document.getElementById(anchorname);x=AnchorPosition_getPageOffsetLeft(o);y=AnchorPosition_getPageOffsetTop(o);}else if(use_css){x=AnchorPosition_getPageOffsetLeft(document.all[anchorname]);y=AnchorPosition_getPageOffsetTop(document.all[anchorname]);}else if(use_layers){var found=0;for(var i=0;i<document.anchors.length;i++){if(document.anchors[i].name==anchorname){found=1;break;}}if(found==0){coordinates.x=0;coordinates.y=0;return coordinates;}x=document.anchors[i].x;y=document.anchors[i].y;}else{coordinates.x=0;coordinates.y=0;return coordinates;}coordinates.x=x;coordinates.y=y;return coordinates;}
function getAnchorWindowPosition(anchorname){var coordinates=getAnchorPosition(anchorname);var x=0;var y=0;if(document.getElementById){if(isNaN(window.screenX)){x=coordinates.x-document.body.scrollLeft+window.screenLeft;y=coordinates.y-document.body.scrollTop+window.screenTop;}else{x=coordinates.x+window.screenX+(window.outerWidth-window.innerWidth)-window.pageXOffset;y=coordinates.y+window.screenY+(window.outerHeight-24-window.innerHeight)-window.pageYOffset;}}else if(document.all){x=coordinates.x-document.body.scrollLeft+window.screenLeft;y=coordinates.y-document.body.scrollTop+window.screenTop;}else if(document.layers){x=coordinates.x+window.screenX+(window.outerWidth-window.innerWidth)-window.pageXOffset;y=coordinates.y+window.screenY+(window.outerHeight-24-window.innerHeight)-window.pageYOffset;}coordinates.x=x;coordinates.y=y;return coordinates;}
function AnchorPosition_getPageOffsetLeft(el){var ol=el.offsetLeft;while((el=el.offsetParent) != null){ol += el.offsetLeft;}return ol;}
function AnchorPosition_getWindowOffsetLeft(el){return AnchorPosition_getPageOffsetLeft(el)-document.body.scrollLeft;}
function AnchorPosition_getPageOffsetTop(el){var ot=el.offsetTop;while((el=el.offsetParent) != null){ot += el.offsetTop;}return ot;}
function AnchorPosition_getWindowOffsetTop(el){return AnchorPosition_getPageOffsetTop(el)-document.body.scrollTop;}


/* SOURCE FILE: PopupWindow.js */

function PopupWindow_getXYPosition(anchorname){var coordinates;if(this.type == "WINDOW"){coordinates = getAnchorWindowPosition(anchorname);}else{coordinates = getAnchorPosition(anchorname);}this.x = coordinates.x;this.y = coordinates.y;}
function PopupWindow_setSize(width,height){this.width = width;this.height = height;}
function PopupWindow_populate(contents){this.contents = contents;this.populated = false;}
function PopupWindow_setUrl(url){this.url = url;}
function PopupWindow_setWindowProperties(props){this.windowProperties = props;}
function PopupWindow_refresh(){if(this.divName != null){if(this.use_gebi){document.getElementById(this.divName).innerHTML = this.contents;}else if(this.use_css){document.all[this.divName].innerHTML = this.contents;}else if(this.use_layers){var d = document.layers[this.divName];d.document.open();d.document.writeln(this.contents);d.document.close();}}else{if(this.popupWindow != null && !this.popupWindow.closed){if(this.url!=""){this.popupWindow.location.href=this.url;}else{this.popupWindow.document.open();this.popupWindow.document.writeln(this.contents);this.popupWindow.document.close();}this.popupWindow.focus();}}}
function PopupWindow_showPopup(anchorname){this.getXYPosition(anchorname);this.x += this.offsetX;this.y += this.offsetY;if(!this.populated &&(this.contents != "")){this.populated = true;this.refresh();}if(this.divName != null){if(this.use_gebi){document.getElementById(this.divName).style.left = this.x;document.getElementById(this.divName).style.top = this.y;
document.getElementById(this.divName).style.visibility = "hidden";
//document.getElementById(this.divName).style.visibility = "visible";
}else if(this.use_css){document.all[this.divName].style.left = this.x;document.all[this.divName].style.top = this.y;
document.all[this.divName].style.visibility = "hidden";
//document.all[this.divName].style.visibility = "visible";
}else if(this.use_layers){document.layers[this.divName].left = this.x;document.layers[this.divName].top = this.y;
document.layers[this.divName].visibility = "hidden";
//document.layers[this.divName].visibility = "visible";
}}else{if(this.popupWindow == null || this.popupWindow.closed){if(this.x<0){this.x=0;}if(this.y<0){this.y=0;}if(screen && screen.availHeight){if((this.y + this.height) > screen.availHeight){this.y = screen.availHeight - this.height;}}if(screen && screen.availWidth){if((this.x + this.width) > screen.availWidth){this.x = screen.availWidth - this.width;}}this.popupWindow = window.open("about:blank","window_"+anchorname,this.windowProperties+",width="+this.width+",height="+this.height+",screenX="+this.x+",left="+this.x+",screenY="+this.y+",top="+this.y+"");}this.refresh();}}
function PopupWindow_hidePopup(){if(this.divName != null){if(this.use_gebi){
document.getElementById(this.divName).style.visibility = "hidden";
}else if(this.use_css){document.all[this.divName].style.visibility = "hidden";}else if(this.use_layers){document.layers[this.divName].visibility = "hidden";}}else{if(this.popupWindow && !this.popupWindow.closed){this.popupWindow.close();this.popupWindow = null;}}}
function PopupWindow_isClicked(e){if(this.divName != null){if(this.use_layers){var clickX = e.pageX;var clickY = e.pageY;var t = document.layers[this.divName];if((clickX > t.left) &&(clickX < t.left+t.clip.width) &&(clickY > t.top) &&(clickY < t.top+t.clip.height)){return true;}else{return false;}}else if(document.all){var t = window.event.srcElement;while(t.parentElement != null){if(t.id==this.divName){return true;}t = t.parentElement;}return false;}else if(this.use_gebi){var t = e.originalTarget;while(t.parentNode != null){if(t.id==this.divName){return true;}t = t.parentNode;}return false;}return false;}return false;}
function PopupWindow_hideIfNotClicked(e){if(this.autoHideEnabled && !this.isClicked(e)){this.hidePopup();}}
function PopupWindow_autoHide(){this.autoHideEnabled = true;}
function PopupWindow_hidePopupWindows(e){for(var i=0;i<popupWindowObjects.length;i++){if(popupWindowObjects[i] != null){var p = popupWindowObjects[i];p.hideIfNotClicked(e);}}}
function PopupWindow_attachListener(){if(document.layers){document.captureEvents(Event.MOUSEUP);}window.popupWindowOldEventListener = document.onmouseup;if(window.popupWindowOldEventListener != null){document.onmouseup = new Function("window.popupWindowOldEventListener();PopupWindow_hidePopupWindows();");}else{document.onmouseup = PopupWindow_hidePopupWindows;}}
function PopupWindow(){if(!window.popupWindowIndex){window.popupWindowIndex = 0;}if(!window.popupWindowObjects){window.popupWindowObjects = new Array();}if(!window.listenerAttached){window.listenerAttached = true;PopupWindow_attachListener();}this.index = popupWindowIndex++;popupWindowObjects[this.index] = this;this.divName = null;this.popupWindow = null;this.width=0;this.height=0;this.populated = false;this.visible = false;this.autoHideEnabled = false;this.contents = "";this.url="";this.windowProperties="toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,resizable,alwaysRaised,dependent,titlebar=no";if(arguments.length>0){this.type="DIV";this.divName = arguments[0];}else{this.type="WINDOW";}this.use_gebi = false;this.use_css = false;this.use_layers = false;if(document.getElementById){this.use_gebi = true;}else if(document.all){this.use_css = true;}else if(document.layers){this.use_layers = true;}else{this.type = "WINDOW";}this.offsetX = 0;this.offsetY = 0;this.getXYPosition = PopupWindow_getXYPosition;this.populate = PopupWindow_populate;this.setUrl = PopupWindow_setUrl;this.setWindowProperties = PopupWindow_setWindowProperties;this.refresh = PopupWindow_refresh;this.showPopup = PopupWindow_showPopup;this.hidePopup = PopupWindow_hidePopup;this.setSize = PopupWindow_setSize;this.isClicked = PopupWindow_isClicked;this.autoHide = PopupWindow_autoHide;this.hideIfNotClicked = PopupWindow_hideIfNotClicked;}

