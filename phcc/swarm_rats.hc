vector (entity targ, entity forent)find_random_spot;

vector(vector start) room_origin = {
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
	
	newmis.origin = trace_endpos;
	setmodel (newmis, "models/ghail.mdl");
	newmis = spawn();
	setorigin ( newmis, trace_endpos);
	newmis.solid = SOLID_NOT;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 0.5;
};

void() smoke3d_think = {
	if (self.frame > 4) {
		self.frame = 1;
	} else {
		self.frame = self.frame + 1;
	}
	do_lightning ( self, 3, STREAM_ATTACHED, 1.00000, self.origin, self.origin + '0 0 100', 3.00000);
	self.think = smoke3d_think;
	AdvanceThinkTime(self,0.125000);
};

vector(vector start) find_entrance = {
	newmis = spawn();
	setorigin(newmis, self.origin);
	setmodel(newmis, "models/ghail.mdl");
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1;
	newmis.think = smoke3d_think;
	AdvanceThinkTime(newmis,0.20000);
};

void() swarm_spawn = {
	//find_entrance(self.origin);
	local entity first, noisemaker;
	local float r;
	//r = rint ( random(3.00000,6.00000));
	r = rint(4.00000 * self.spellradiusmod);
	
	noisemaker = spawn_temp();
	noisemaker.thingtype = THINGTYPE_BROWNSTONE;
	setsize(noisemaker, '-12 -12 0', '12 12 12');
	noisemaker.think = chunk_death;
	setorigin(noisemaker, self.origin);
	AdvanceThinkTime(noisemaker, HX_FRAME_TIME);

	while ( (r > 0.00000) ) {
		newmis = spawn ( );
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		newmis.controller = self.owner;
		newmis.owner = self.owner;
		newmis.angles_y = (self.angles_y + (60.00000));
		newmis.scale = (random(1.25000, 1.80000) * (newmis.spelldamage / (spell_damage->31)));
		newmis.flags2 |= FL_SUMMONED;
		setsize ( newmis, '-3.00000 -3.00000 0.00000', '3.00000 3.00000 7.00000');		
		
		if (first == world)
		{
			first = newmis;
			setorigin(newmis, self.origin + '0 0 24');
		}
		else
		{
			newmis.dest = find_random_spot(first, first);
			setorigin(newmis, newmis.dest + '0 0 24');
		}
		sound ( noisemaker, CHAN_AUTO, "misc/hith2o.wav", 1.00000, ATTN_NORM);

		//makevectors ( newmis.angles);
		//setorigin ( newmis, (self.origin + random('-200 -200 0', '200 200 20')));
		newmis.think = monster_rat;
		AdvanceThinkTime(newmis,HX_FRAME_TIME);
		r -= 1.00000;
	}
	
};

void() launch_swarm = {
	swarm_spawn();
};
