# ===========================
# Immatriculation by Zakharov
# ===========================

var refresh_immat = func {
    var immat = props.globals.getNode("/sim/model/immat",1).getValue();
    var immat_size = size(immat);
    if (immat_size != 0) immat = string.uc(immat);
    for (var i = 0; i < 6; i += 1) {
	if (i >= immat_size)
	    glyph = -1;
	elsif (string.isupper(immat[i]))
		glyph = immat[i] - `A`;
	elsif (string.isdigit(immat[i]))
	    glyph = immat[i] - `0` + 26;
	else
	   glyph = 36;

  var n = i+1;
	props.globals.getNode("/sim/multiplay/generic/int["~n~"]", 1).setValue(glyph+1);
    }
}

var immat_dialog = gui.Dialog.new("/sim/gui/dialogs/doj/status/dialog",
				  "Aircraft/DO-J-II/Dialogs/immat.xml");

setlistener("/sim/signals/fdm-initialized", func {
  if (props.globals.getNode("/sim/model/immat") == nil) {
    var immat = props.globals.getNode("/sim/model/immat",1);
    var callsign = props.globals.getNode("/sim/multiplay/callsign").getValue();
    if (callsign != "callsign") immat.setValue(callsign);
  else immat.setValue("D-2399");
  }
  refresh_immat();
  setlistener("sim/model/immat", refresh_immat, 0);
},0);

