void ()crushdrop_crash = {
	local entity head;
	head = findradius ( self.origin, (150.00000*self.spellradiusmod));
	particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 248.00000, 17, 80.00000);
	particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 250.00000, 17, 80.00000);
	particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 249.00000, 2, 80.00000);
	particle2 ( self.origin - '0 0 64', '-7.00000 -7.00000 150.00000', '7.00000 7.00000 300.00000', 255.00000, 17, random(128.00000, 240.00000));

	//sound ( self, CHAN_AUTO, "tsunami.wav", 1.00000, ATTN_NORM);
	//raven/inh2o.wav
	//raven/outwater.wav
	//player/h2ojmp.wav
	sound ( self, CHAN_AUTO, "tsunami.wav", 1.00000, ATTN_NORM);
	sound ( self, CHAN_WEAPON, "bombinriver.wav", 1.00000, ATTN_NORM);
	
	while (head)
	{
		if (head.takedamage == DAMAGE_YES) {
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			head.velocity += normalize(head.origin - self.origin) * 1000;
			head.velocity_z = random(250, 300);
			apply_status(head, STATUS_WET, 1, 5);
			
			if (head != self.owner)
				T_Damage (head, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
			
		}
		head = head.chain;
	}
	remove(self);
};

void ()crushdrop_fx_touch = {
	if (self.cnt == 0)
	{
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 248.00000, 17, random(20.00000, 80.00000));
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 250.00000, 17, random(20.00000, 80.00000));
		//self.drawflags ^= SCALE_TYPE_XYONLY;
		self.cnt += 1;
		self.lifetime = 0.5;
		self.splash_time = (time + self.lifetime);
		self.touch = SUB_Null;
	}
	
	if (time < self.splash_time)
	{
		self.velocity_z -= ((time - self.ltime) * 600);
		self.abslight = ((self.splash_time - time) / self.lifetime);
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * (0.80000 * self.spellradiusmod));
		//self.frame = rint(random(2, 11));
		self.frame = 2 + ((1.00000 - ((self.splash_time - time) / self.lifetime)) * 9);
		self.ltime = time;
		
		self.think = crushdrop_fx_touch;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	} else {
		remove(self);
	}
};

void ()crushdrop_fx_think = {
	if (time < self.splash_time)
	{
		if ((self.velocity_z < 0.00000) && (self.origin_z <= self.dest_z))
		{
			self.think = crushdrop_fx_touch;
			self.velocity = random('0 0 240', '0 0 320');
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		else
		{
			self.frame = 2 + (((1.00000 - ((self.splash_time - time) / self.lifetime))) * 7);
			self.velocity_z -= ((time - self.ltime) * 600);
			self.scale = (((1.00000 - ((self.splash_time - time) / self.lifetime)) * 0.5) * self.spellradiusmod) + 0.02000;
			
			self.ltime = time;
			self.think = crushdrop_fx_think;
			AdvanceThinkTime(self, 0.1);
		}
	} else {
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
		
	
};

void (vector start)crushdrop_fx = {
	newmis = spawn ( );
	newmis.solid = SOLID_NOT;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.lifetime = 4.0000;
	newmis.splash_time = (time + newmis.lifetime);
	newmis.ltime = time;
	newmis.dest = self.dest;
	newmis.dest_z += 24;
	if (random() < 0.5)
		newmis.skin = 1;
	else
		newmis.skin = 2;
	
	newmis.scale = 0.02000;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT | SCALE_TYPE_XYONLY);
	newmis.abslight = 1.5;
	setmodel(newmis, "models/splat.mdl");
	newmis.angles = random('0.00000 -360.00000 0.00000','0.00000 360.00000 0.00000');
	newmis.avelocity = random('0.00000 -40.00000 0.00000','0.00000 40.00000 0.00000');
	newmis.velocity_z = (self.origin_z - self.dest_z) * 2.25000;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin ( newmis, self.dest);
	setsize(newmis, '-10 -10 -20', '10 10 10');
	//raven/inh2o.wav
	//raven/outwater.wav
	//player/h2ojmp.wav
	//sound ( newmis, CHAN_AUTO, "tsunami.wav", 1.00000, ATTN_NORM);
	newmis.auraV = random();
	if (newmis.auraV < 0.3)
		sound ( newmis, CHAN_AUTO, "player/h2ojmp.wav", 1.00000, ATTN_NORM);
	else if (newmis.auraV < 0.6)
		sound ( newmis, CHAN_AUTO, "raven/outwater.wav", 1.00000, ATTN_NORM);
	else if (newmis.auraV < 1)
		sound ( newmis, CHAN_AUTO, "raven/inh2o.wav", 1.00000, ATTN_NORM);
	
	newmis.classname = "tsunami";
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = crushdrop_fx_think;
};


void ()crushdrop_think = {
	local entity head;

	if (self.velocity_z > 0) {
		head = findradius ( self.origin - '0 0 128', (135.00000*self.spellradiusmod));
		
		while (head)
		{
			if (head.takedamage == DAMAGE_YES) {
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				if (head != self.owner)
					T_Damage (head, self, self.owner, random(1, 2));
				
				head.velocity_x *= 0.7;
				head.velocity_y *= 0.7;
				head.velocity -= normalize(head.origin - self.origin) * 10;
				head.velocity_z += random(160, 220);
				apply_status(head, STATUS_WET, self.spelldamage, 5);
			}
			head = head.chain;
		}

		self.velocity_z -= 2.5;
		AdvanceThinkTime(self, 0.12500);
		self.think = crushdrop_think;
		
		if (self.cnt == 0)
		{
			self.cnt = 1;
			crushdrop_fx(self.dest);
		}
		else
			self.cnt = 0;
		
	} else {
		self.velocity_z = -240;
		AdvanceThinkTime(self, 1.0);
		self.think = crushdrop_crash;
		//remove(self);
	}

	particle2 ( self.origin, '-30.00000 -30.00000 150.00000', '30.00000 30.00000 200.00000', 248.00000, 17, 80.00000);
	//particle2 ( self.dest, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 250.00000, 17, 80.00000);
	particle2 ( self.dest, '-30.00000 -30.00000 150.00000', '30.00000 30.00000 300.00000', 249.00000, 2, 80.00000);
};


void ()launch_crushdrop = {
	newmis = spawn ( );
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.solid = SOLID_NOT;
	newmis.scale = 1.65;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.5;
	setmodel(newmis, "models/iceboom.mdl");
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.owner = self.owner;
	traceline ( self.origin, (self.origin - '0.00000 0.00000 800.00000'), TRUE, self);
	newmis.dest = trace_endpos;
	setorigin ( newmis, trace_endpos);
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.avelocity = random('0.00000 -400.00000 0.00000','0.00000 400.00000 0.00000');
	//   newmis.dest = newmis.origin;
	//   newmis.dest2 = newmis.origin;
	newmis.velocity_z = 110.00000;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = crushdrop_think;
};
