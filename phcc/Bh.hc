void() gravwell_think = {
	if (self.cnt == 95) {
		stuffcmd(self.jones, "fov 80\n");
	}
	if (self.cnt == 100) {
		stuffcmd(self.jones, "fov 70\n");
	}
	if (self.cnt == 105) {
		stuffcmd(self.jones, "fov 60\n");
	}
	if (self.cnt == 110) {
		stuffcmd(self.jones, "fov 50\n");
	}
	if (self.cnt == 115) {
		stuffcmd(self.jones, "fov 40\n");
	}
	if (self.cnt == 120) {
		stuffcmd(self.jones, "fov 30\n");
	}
	if (self.cnt == 125) {
		remove(self);
	}
	self.cnt += 5;
	AdvanceThinkTime(self, 0.1);
	self.think = gravwell_think;
};

void(entity found)gravwell = {
	newmis = spawn();
	newmis.jones = found;
	newmis.cnt = 95;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = gravwell_think;
};


void() squelch = {
	self.colormap = 0;
	//setorigin(self, (self.jones.origin - '0 0 3900'));
	setorigin(self, '0 0 -3900');
	if (heresy) {
		self.mage = 0;
	}
	GibPlayer ( );
	self.health = 0;
	stuffcmd(self, "fov 90\n");
	self.halted = 0;
};

void() baddie_fade = {
	if(self.classname != "player") {
		self.phaseout = 1;
	}

	if (self.phaseout == 1) {
		self.phaseout = 2;
		self.dest = vectoangles (self.jones.origin - self.origin);
		self.dest_x -= 90;
	}

	if (self.classname != "player") {
		if (self.colormap < 143) {
			self.colormap += 1;
			self.angles_x += self.dest_x / 15;
			self.angles_y += self.dest_y / 15;
			self.angles_z += self.dest_z / 15;
			self.think = baddie_fade;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		if (self.colormap > 142) {
			if (self.scale < (1.66000 * self.spellradiusmod)) {
				self.scale += 0.1;
				self.colormap = 143;
				self.think = baddie_fade;
				AdvanceThinkTime(self, HX_FRAME_TIME);
			} else {
				self.colormap = 143;
				self.deadflag = TRUE;
				self.think = SUB_NullDeath;
				AdvanceThinkTime(self, HX_FRAME_TIME);
			}
		}

	} else {
		newmis = spawn();
		newmis.jones = self.jones;
		setorigin(newmis, self.origin);
		setmodel(newmis, self.model);
		newmis.colormap = self.colormap;
		//setmodel(self, "models/null.spr");
		self.velocity = '0 0 0';
		if (newmis.colormap < 143) {
			newmis.phaseout = 1;
			newmis.colormap += 1;
			newmis.angles_x += newmis.dest_x / 15;
			newmis.angles_y += newmis.dest_y / 15;
			newmis.angles_z += newmis.dest_z / 15;
		}
		if (newmis.colormap > 142) {
			if (newmis.scale < (1.66000 * self.spellradiusmod)) {
				newmis.scale += 0.1;
				newmis.colormap = 143;
			} else {
				newmis.colormap = 143;
				newmis.deadflag = TRUE;
				remove(newmis);
			}
		}
		AdvanceThinkTime(newmis, 0.05);
		newmis.think = baddie_fade;
		gravwell(self);
		self.scale = 0.06;
		AdvanceThinkTime(self, 0.6);
		self.think = squelch;
	}
};


void() bh_suction = {
	local float grap;
	local vector pull;
	local float  pull_speed;
	local entity head;
	
	grap = (320.00000 * self.spellradiusmod);
	head = findradius ( self.origin, grap);
	
	while (head)
	{
		pull = self.origin - head.origin;
		
//		if((grap>0) && (head != world) && (head.solid != SOLID_BSP) && (head.classname != "info_player_start") && (head.classname != "info_player_coop") && (head.classname != "info_player_deathmatch") && (head.classname != "info_intermission"))

		if((head != world) && (head.solid != SOLID_BSP) && (head.takedamage == DAMAGE_YES) && (head.health > -1.00000))
		{
			//TODO: change 400 to whatever maximum
			//speed you want. Actual speed is inversely proportional
			//to distance. At distace=radius, speed will be 0
			//                      pull_speed = (1-vlen(pull)/grap)*2;
			pull_speed = 9;
			normalize(pull);
			pull *= pull_speed;

			T_Damage ( head, self, self.owner, 13);
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			if (head.phaseout == 0) {
				head.velocity += pull;
			}
			//if ((head.classname != "player") && (vlen(head.origin - self.origin) < 360) && (head.phaseout == 0)) {
			if ((vlen(head.origin - self.origin) < 360) && (head.phaseout == 0)) {
				if (head.classname == "Chaos") {
					AdvanceThinkTime(head, 0.02);
					head.think = head.th_die;
				} else {
					//AdvanceThinkTime(head,0.01);
					//head.think = SUB_Remove;
					head.jones = self;
					head.drawflags |= SCALE_TYPE_ZONLY;
					head.velocity = '0 0 0';
					head.movetype = MOVETYPE_NOCLIP;
					head.solid = SOLID_NOT;
					head.drawflags & MLS_ABSLIGHT;
					head.abslight = 1.5;
					head.colormap = 128;
					AdvanceThinkTime(head, 0.02);
					head.think = baddie_fade;
				}
			}


		}
		//              }
		
		head = head.chain;
	}


	AdvanceThinkTime(self, 0.02);
	self.think = ChunkShrink;
};


void() bh_suckfield = {
	newmis = spawn();
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.classname = "blackhole";
	setorigin(newmis, self.origin);
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	//setsize(newmis, '0 0 0', '0 0 0');
	setmodel(newmis, "models/suck.mdl");
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 0.5;
	newmis.scale = (1.66000 * self.spellradiusmod); 
	newmis.skin = 0;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = bh_suction;
};


void() bh_suction_spawner = {

	remove(self);

};


void() bh_ball_invert = {
	sound (self, CHAN_AUTO, "darkness2.wav", 1, ATTN_NORM);
	bh_suckfield();
	if (self.scale > 0.05) {
		self.scale -= 0.07;
		AdvanceThinkTime(self, 0.1);
		self.think = bh_ball_invert;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = bh_suction_spawner;
	}
};

void() bh_ball_destruct_think = {
	if (self.scale < (1.66000 * self.spellradiusmod)) {
		self.scale += 0.2;
		AdvanceThinkTime(self, 0.05);
		self.think = bh_ball_destruct_think;
	} else {
		AdvanceThinkTime(self, 4);
		//self.think = ChunkShrink;
		self.think = SUB_Remove;
	}
};


void() bh_ball_destruct = {

	local entity found;

	found = nextent (world);

	while ( found ) {

		if ( (found.classname == "player") ) {

			sound (found, CHAN_BODY, "exp3.wav", 1, ATTN_NORM);
			sound (found, CHAN_AUTO, "bh.wav", 1, ATTN_NORM);
			MonsterQuake(200.0, found);
			found.velocity += (normalize(self.origin - found.origin) * 450);
			found.velocity_z += 200;

		}
		found = find ( found, classname, "player");
	}


	found = findradius ( self.origin, (650.00000 * self.spellradiusmod));
	while (found) {
		if ((found.takedamage == DAMAGE_YES) && (found.classname != "player")) {
			if (found.flags & FL_ONGROUND) {
				found.flags ^= FL_ONGROUND;
			}
			found.velocity_z += 200;
			found.velocity += (normalize(self.origin - found.origin) * 450);
			found = found.chain;
		}
		found = found.chain;
	}

	newmis = spawn();
	newmis.spellradiusmod = self.spellradiusmod;
	setorigin(newmis, self.origin);
	setmodel(newmis, "models/bhdestruct.mdl");
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.scale = 0.05; 
	newmis.avelocity = random('-300 -300 -300', '300 300 300');
	newmis.classname = "blackhole";
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = bh_ball_destruct_think;

};

void() bh_ball_think = {
	if (self.origin_z < (self.auraV + 40)) {
		self.velocity_z = 0;
		self.cnt = 0;
		self.effects = EF_DARKLIGHT;
		AdvanceThinkTime(self, 0.05);
		self.think = bh_ball_invert;
		bh_ball_destruct();
		bh_ball_destruct();
	} else {
		AdvanceThinkTime(self, 0.05);
		self.think = bh_ball_think;
	}
};

void() bh_ball_drop = {
	
	newmis = spawn();
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.classname = "blackhole";
	newmis.hull = HULL_POINT;
	traceline (self.origin, (self.origin-('0 0 600')) , TRUE , self);
	traceline (trace_endpos, (self.origin+('0 0 600')) , TRUE , self);
	setorigin(newmis, (trace_endpos - '0 0 30'));
	newmis.auraV = self.origin_z;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.velocity_z -= 350;
	setmodel(newmis, "models/dwarf.mdl");
	newmis.scale = (1.66000 * self.spellradiusmod);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = bh_ball_think;
};
