/*
entity(vector start) room_origin = {
	newmis = spawn();
	

	local vector temp;
	local vector spot0;  //center of the room
	local vector spot1;  //west side of the room
	local vector spot2;  //east side of the room
	local vector spot3;  //south side of the room
	local vector spot4;  //north side of the room
	local vector spot5;  //bottom of the room
	local vector spot6;  //top of the room

	//horizontal-bias due to gravitys influence on architecture  =P

	traceline(self.origin,( self.origin - '1024 0 0'),TRUE,self); // check if I can see
	spot1 = trace_endpos;
	traceline(spot2,( spot2 + '2048 0 0'),TRUE,self); // check if I can see
	spot2 = trace_endpos;

	//nudge to the center
	temp = normalize(spot2 - spot1);
	spot0 = (spot1 + (temp * (vlen(spot2 - spot1) / 2)));

	traceline(self.origin,( self.origin - '0 1024 0'),TRUE,self); // check if I can see
	spot3 = trace_endpos;
	traceline(spot3,( spot3 + '0 2048 0'),TRUE,self); // check if I can see
	spot4 = trace_endpos;


	//nudge to the center
	temp = normalize(spot4 - spot3);
	spot0 = (spot3 + (temp * (vlen(spot4 - spot3) / 2)));

	traceline(trace_endpos,( trace_endpos - '2048 0 0'),TRUE,self); // check if I can see
};
*/

float (vector pos, float radius)tracevolume =
{
	local float hit, pc;
/*	local entity found;
	
	hit = 0;
	found = findradius (pos, radius);
	while (found)
	{
		if (found.takedamage == DAMAGE_YES)
		{
			hit = 1;
			found = world;
		}
		else
			found = found.chain;
	}
	
	
	
	pc = pointcontents(pos );
	dprintf ( "PointContents is: %s\n", pc);
	*/
	
	//tracearea ( pos, pos, self.mins, self.maxs, FALSE, self);
	tracearea ( pos + '0 0 12', pos + '0 0 2', '-16 -16 0', '16 16 56', FALSE, self);
	if ( (trace_fraction < 1.00000) ) {
		hit = 1;
	}

	dprintf ( "traced volume: %s\n", hit);
	dprintf ( "self.mins: %s\n", self.maxs_z);
	dprint ( "classname: ");
	dprint(trace_ent.classname);
	dprint("\n");
	
	return hit;
};
