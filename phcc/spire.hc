
void() hold_timer = {
	local float thrust_height, spike_height;
	if (self.hasted == 0)
	{
		if (time < self.splash_time)
		{
			self.frame = floor((1.00000 - ((self.splash_time - time) / self.lifetime)) * 8);
			spike_height = (200.00000 * ((1.00000 - ((self.splash_time - time) / self.lifetime)) * self.spellradiusmod));
			setsize(self, '-12 -12 0', '12 12 12' + ('0 0 1' * spike_height));
			
			thrust_height = 0.00000;
			while (thrust_height < spike_height)
			{
				traceline (self.origin + ('0 0 1' * thrust_height), (self.origin+('0 0 1' * spike_height)), FALSE, self);
				
				if (trace_ent.origin != VEC_ORIGIN)
				{
					if ((trace_ent.takedamage == DAMAGE_YES) && (trace_ent != self.owner))
					{
						sound ( self, CHAN_AUTO, "golem/stomp.wav", 1.00000, ATTN_NORM);
						SpawnPuff ( trace_endpos, '360.00000 360.00000 360.00000', 5.00000, trace_ent);
						T_Damage ( trace_ent, self, self.owner, self.dmg);
					}
				}
				
				thrust_height += 32.00000;
			}

			self.think = hold_timer;
			AdvanceThinkTime(self, 0.06250);
		}
		else
		{
			self.hasted = 1;
			self.frame = 7;
			self.think = hold_timer;
			AdvanceThinkTime(self, 1.00000);
		}
		
	}
	else if (self.hasted == 1)
	{
		self.hasted = 2;
		self.lifetime *= 2.00000;
		self.splash_time = (time + self.lifetime);
		self.think = hold_timer;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else if (self.hasted == 2)
	{
		if (time < self.splash_time)
		{
			self.frame = floor(((self.splash_time - time) / self.lifetime) * 8);
			
			self.think = hold_timer;
			AdvanceThinkTime(self, 0.06250);
		}
		else
		{
			self.think = SUB_Remove;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
	}
};

void (entity holdee) hold = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_FLY;
	newmis.hasted = 0;
	newmis.mass = 8000;
	traceline (holdee.origin + '0 0 30', (holdee.origin-('0 0 600')) , TRUE , self);
	setorigin(newmis, trace_endpos);
	
	if (self.classname == "flare")
	{
		sound ( newmis, CHAN_AUTO, "golem/stomp.wav", 1.00000, ATTN_NORM);
		T_Damage ( holdee, newmis, self.owner, (newmis.spelldamage + random(newmis.spelldamage*(-0.12500), newmis.spelldamage*0.12500)));
		newmis.skin = 0;
		newmis.hasted = 2;
	}
	else
	{
		newmis.dmg = newmis.spelldamage + random(newmis.spelldamage*(-0.12500), newmis.spelldamage*0.12500);
		if (holdee.thingtype == THINGTYPE_FLESH) {
			bloodymess();
			newmis.skin = 1;
		} else {
			newmis.skin = 0;
		}
	}

	newmis.enemy = holdee;
	setsize(newmis, '-12 -12 0' * self.spellradiusmod, '12 12 80' * self.spellradiusmod);
	newmis.scale = self.spellradiusmod;
	// newmis.velocity = ('0 0 500');
	// newmis.speed = 10;
	// newmis.angles = vectoangles(newmis.velocity);
	newmis.ltime = 10;
	//newmis.lifetime = 0.36250;
	newmis.lifetime = 0.36250;
	newmis.splash_time = (time + newmis.lifetime);
	// newmis.touch = rise_touch;
	if (self.classname != "flare") {
		setmodel (newmis, "models/spire.mdl");
		newmis.drawflags |= (SCALE_TYPE_ZONLY | SCALE_ORIGIN_BOTTOM);
	}
	newmis.think = hold_timer;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};





void() spire_touch = {
	if ((other.takedamage == DAMAGE_YES) && (other.solid != SOLID_BSP)) {
		if (other.flags & FL_ONGROUND) {
			setorigin(self, other.origin);
		} else {
			traceline (self.origin + '0 0 30', (self.origin-('0 0 600')) , TRUE , self);
			setorigin(self, trace_endpos);
		}
		self.velocity = '0 0 0';
		setsize(self, '-20 -20 0', '20 20 60');
		hold(other);
	}
	remove(self);
};


void() spire_rubble_think = {
	if(self.scale > self.cscale) {
		AdvanceThinkTime(self, 0.3);
		self.think = ChunkShrink;
	} else {
		self.scale += 0.1;
		AdvanceThinkTime(self, 0.05);
		self.think = spire_rubble_think;
	}
};

void(vector org) spire_rubble = {
	local float flak;
	local vector random_vector;

	
	if ((chunk_cnt < CHUNK_MAX) && (random() < 0.36250))
	{
		random_vector_x = random(-10,10);
		random_vector_y = random(-10,10);
		random_vector_z = random(0,5);
		local entity rock;
		flak = random();
		rock = spawn_temp();
		chunk_cnt += 1;
		setorigin (rock, org + random_vector);
		rock.angles = random('-360.00000 -360.00000 -360.00000','360.00000 360.00000 360.00000');

		rock.cnt = 7;
		rock.ltime = 10;
		rock.owner = self.owner;
		rock.movetype = MOVETYPE_FLY;
		rock.solid = SOLID_NOT;
		rock.scale = 0.1;
		rock.cscale = random(0.30000,1.40000);
		if (flak<0.8) {
			setmodel ( rock, "models/schunk1.mdl");
		} else {
			if (flak<0.6) {
				setmodel ( rock, "models/schunk2.mdl");
			}
			if (flak<0.4) {
				setmodel ( rock, "models/schunk3.mdl");
			}
			if (flak<0.2) {
				setmodel ( rock, "models/schunk4.mdl");
			} else {
				setmodel ( rock, "models/schunk2.mdl");
			}
		}
		rock.think = spire_rubble_think;
		AdvanceThinkTime(rock, HX_FRAME_TIME);
	}
};


void() spire_trail = {
	traceline ( self.origin, (self.origin - '0.00000 0.00000 120.00000'), FALSE, self);
	spire_rubble(trace_endpos);
	spire_rubble(trace_endpos);
	if(random(1, 20)<7) {
		sound ( self, CHAN_AUTO, "fx/quake.wav", 1, ATTN_NORM);
	}
	particle2 ( (trace_endpos + random('-5 -5 -5', '5 5 5')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(160, 175), 2, 10.00000);
	if (trace_fraction == 1.00000) {
		remove(self);
	}
	traceline ( trace_endpos, (trace_endpos + '0.00000 0.00000 40.00000'), FALSE, self);

	setorigin(self, trace_endpos);
	AdvanceThinkTime(self, 0.1);
	self.think = spire_trail;
};

void() spire_drop = {
	self.angles_x = 0.00000;
	makevectors (self.angles);
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	//traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	setorigin (newmis, self.origin + '0 0 20');
	sound ( newmis, CHAN_AUTO, "fx/quake.wav", 1, ATTN_NORM);
	setsize(newmis, '0 0 -10', '0 0 10');
	newmis.owner = self.owner;
	newmis.velocity = (v_forward * 300);
	newmis.angles = vectoangles(newmis.velocity); 
	newmis.cnt = random(3, 10);
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags = MLS_ABSLIGHT;
	newmis.abslight = 1;
	newmis.classname = "spire_trap";
	AdvanceThinkTime(newmis, 0.1);
	newmis.touch = spire_touch;
	newmis.think = spire_trail;
};

