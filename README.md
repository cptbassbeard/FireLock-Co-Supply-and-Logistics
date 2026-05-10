<h1>FIRELOCK CO. SUPPLY AND LOGISTICS</h1>
<p>Property of FIRELOCK CO. shareholders and CEO Cpt Bassbeard /j</p>
<h2>train mod for arma 3</h2>
<h3>USAGE OF THE MISSION FILE</h3>
Inside the file trainmove.sqf is a spline array, this is your track. 
Add to this the variable names of your "track" that the train will move along.
This will not be cleaned up as it is not intended to remain forever.
Use the spline mod to create your own track for ease https://steamcommunity.com/sharedfiles/filedetails/?id=3687041036
CBA settings are added for customising speed, reverse speed etc. 
Adjust at your own preference and even change the sliders in the CBA_keybinds file.
CBA Control are also added for driving the train.

to initialise the train - this is run by the server
[train_0,[train_1,train_2,train_3,train_4,train_5,train_6,train_7]] call FLCSL_fnc_init;
train_0 is the engine, the rest of the array is the order in which the carriages are. the train is driven from the engine driver seat.
You can replace carriages with eg tanks if you so wished, bounding boxes solve the distances

<h3>Requirements</h3>
<ul>
  <li>CBA A3</li>
</ul>
<h3>Feature list</h3>
Functional Train support for FireLock Co. Supply and Logistic train pack
<h3>Known issues</h3>
<h3>Planned features</h3>
Sound Queues through a custom system based on train actions
Derailment
attaching carriages mid mission
