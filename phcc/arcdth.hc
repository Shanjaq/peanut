void  ()charge_touch;

void() arc_transit;

void() arc_pulse_touch = {
	self.movetype = MOVETYPE_NONE;
	self.drawflags = MLS_ABSLIGHT;
	self.abslight = 1;
	setmodel(self, "models/vorpshok.mdl");
	setsize (self, '0 0 0', '0 0 0');
	self.velocity = '0 0 0';
	//self.avelocity_z = ((100 + random(1, 400)) * random(-1, 1));
	self.angles = RandomVector ( '360.00000 360.00000 360.00000');
	self.skin = 0.00000;
	self.scale = 1.80000;
	if (other.takedamage == DAMAGE_YES)
	{
		self.dmg = self.spelldamage + random(self.spelldamage*(-0.75000), self.spelldamage*0.75000);
		
		if (other.status_effects & STATUS_WET)
			self.dmg *= 3.62500;

		T_Damage ( other, self, self.owner, self.dmg);
	}

	sound (self, CHAN_AUTO, "baer/gntact1.wav", 1, ATTN_NORM);
	//T_RadiusDamage (self, self.owner, 24, other);
	AdvanceThinkTime(self, random(0.02, 0.12));
	self.think = SUB_Remove;
};



void() arc_pulse_think = {
	local float r = 0.00000;
	if (self.cnt > 0)
	{
		r = rint ( random(0.00000,4.00000));
		if (r > 1.00000)
		{
			newmis = spawn_temp();
			setorigin (newmis, self.origin);
			setmodel ( newmis, "models/vorpshk2.mdl");
			newmis.scale = 2.00000;
			newmis.drawflags = MLS_ABSLIGHT;
			newmis.abslight = 1;
			AdvanceThinkTime(newmis, 0.2);
			newmis.think = SUB_Remove;
			//do_lightning ( self.owner, 1, STREAM_ATTACHED, 1.00000, self.origin, self.origin + random('-150 -150 -100', '150 150 100'), 3.00000);
		}
		
		self.cnt -= 1;
		AdvanceThinkTime(self, 0.1);
		self.think = arc_pulse_think;
	}
	else 
	{
		remove(self);
	}
};

void (float vel) arc_pulse = {
	newmis = spawn();
	newmis.owner = self.owner;
	newmis.spelldamage = self.spelldamage;
	if (vel > 0)
	{
		setorigin (newmis, (self.origin + '0 0 40'));
	} 
	else 
	{
		setorigin (newmis, (self.origin - '0 0 40'));
	}
	newmis.hull = HULL_POINT;
	newmis.velocity = self.velocity;
	newmis.velocity_z = vel;
	//newmis.angles = vectoangles(newmis.velocity); 
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	setmodel(newmis, "models/null.spr");
	setsize ( newmis, '0 0 0', '0 0 0');
	newmis.touch = arc_pulse_touch;  //TEMPORARY
	newmis.cnt = 30;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = arc_pulse_think;
};

void() arc_transit = {
	local entity nearest;
	local vector dir;
	local float test;
	
	if (self.cnt > 40) {
		sound (self, CHAN_AUTO, "fx/quake.wav", 1, ATTN_NORM);
		remove(self);
	} else {
		self.cnt += 1;
		test = fmod(self.cnt, 3);  //lightning frequency
		if (self.classname == "top") {
			if ((pointcontents(self.origin) == CONTENT_SOLID) && (pointcontents(self.enemy.origin) == CONTENT_SOLID))
			{
				self.health -= 1;
				if (self.health > 0)
				{
					self.health -= 1;
				} else {
					self.cnt = 41;
					self.enemy.cnt = 41;
				}
			} else {
				self.health = 4;
			}

			dir = normalize(self.enemy.origin - self.origin);
			nearest = findNearestHurtable((self.origin + (dir * (vlen(self.origin - self.enemy.origin) * 0.50000))), 500.00000, 1, 0, FALSE);
			if (nearest)
			{
				self.dest = nearest.origin;
				self.dest_z = self.origin_z;
				self.dest2 = ((normalize(self.dest - self.origin) * 10.00000));
				self.velocity += self.dest2;
				//self.velocity_z = 0;
				self.enemy.velocity = self.velocity;
			}
			particle2 ( (self.origin + random('-30 -30 -30', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', (144.00000 + random(15.00000)), 2, 80.00000);
			if (test == 0) {
				self.dmg = self.spelldamage*0.50000;
				if (self.enemy.status_effects & STATUS_WET)
					self.dmg *= 3.62500;
				
				do_lightning ( self, 3, STREAM_ATTACHED, 3.00000, self.origin, self.enemy.origin, (self.spelldamage*0.75000) + random(self.spelldamage*(-0.50000), self.dmg));
				arc_pulse(-800);
			}
			traceline (self.origin , (self.origin-('0 0 1024')) , FALSE, self);
		} else {
			particle2 ( (self.origin + random('-30 -30 -30', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(98, 108), 2, 80.00000);
			if (test == 0) {
				arc_pulse(800);
			}
			traceline (self.origin , (self.origin+('0 0 1024')) , FALSE, self);
		}

		setorigin(self.enemy, trace_endpos);
		
		if ((self.lockentity.origin != VEC_ORIGIN) || ((trace_ent.takedamage == DAMAGE_YES) && (trace_ent.solid != SOLID_BSP) && !((trace_ent.thingtype == THINGTYPE_GREYSTONE) || (trace_ent.thingtype == THINGTYPE_CLAY) || (trace_ent.thingtype == THINGTYPE_BROWNSTONE)))) {
			if (self.lockentity.origin == VEC_ORIGIN)
			{
				self.lockentity = trace_ent;
				self.enemy.lockentity = trace_ent;
			}
			
			self.dest = self.lockentity.origin;
			self.dest_z = self.origin_z;
			setorigin(self, (self.dest));
			self.dest = '0 0 0';
			self.velocity = '0 0 0';
			self.enemy.velocity = '0 0 0';
			//self.jones = trace_ent;
			if (self.classname == "top") {
				traceline (self.origin , (self.origin-('0 0 1024')) , TRUE, self);
			} else {
				traceline (self.origin , (self.origin+('0 0 1024')) , TRUE, self);
			}
			trace_endpos_x = self.lockentity.origin_x;
			trace_endpos_y = self.lockentity.origin_y;
			setorigin(self.enemy, trace_endpos);

		}
		AdvanceThinkTime(self, 0.1);
		self.think = arc_transit;

	}
};

void() deatharc_launch = {
	local entity corona;
	self.magic_finished = (time + 4);
	makevectors (self.angles);
	
	newmis = spawn();
	newmis.classname = "top";
	//traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	//setorigin (newmis, trace_endpos);
	setorigin (newmis, self.origin);
	newmis.owner = self.owner;
	newmis.spelldamage = self.spelldamage;
	newmis.velocity = (v_forward * 300);
	newmis.velocity_z = 0;
	newmis.avelocity = RandomVector ( '360.00000 360.00000 360.00000');
	newmis.dest = newmis.velocity;
	newmis.angles = vectoangles(newmis.velocity); 
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.drawflags = MLS_ABSLIGHT;
	newmis.abslight = 1;
	setmodel(newmis, "models/glowball.mdl");




	corona = spawn();
	corona.classname = "bottom";
	//traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	//setorigin (corona, trace_endpos);
	setorigin (corona, self.origin);
	corona.owner = self.owner;
	newmis.spelldamage = self.spelldamage;
	corona.velocity = (v_forward * 300);
	corona.velocity_z = 0;
	corona.avelocity = RandomVector ( '360.00000 360.00000 360.00000');
	corona.angles = vectoangles(corona.velocity); 
	corona.solid = SOLID_NOT;
	corona.movetype = MOVETYPE_NOCLIP;
	corona.drawflags = MLS_ABSLIGHT;
	corona.abslight = 1;
	setmodel(corona, "models/glowball.mdl");

	newmis.enemy = corona;
	corona.enemy = newmis;

	AdvanceThinkTime(newmis, 0.1);
	newmis.think = arc_transit;

	AdvanceThinkTime(corona, 0.1);
	corona.think = arc_transit;

};
