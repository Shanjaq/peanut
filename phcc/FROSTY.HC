void ()frost_ice_touch =
{
	if ((other.flags2 & FL_ALIVE) && (other.flags & FL_ONGROUND) && (random() < 0.75))
	{
		other.velocity += (other.velocity * 0.5);
		other.flags ^= FL_ONGROUND;
	}
	
};

void ()frost_ice_sheet = {
	local float pc;
	if (time < self.splash_time)
	{
		pc = pointcontents(self.origin);
		if ( !(((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) || (pc == CONTENT_LAVA)) )
		{
			self.velocity_z = 0;
			self.think = ChunkShrink;
			AdvanceThinkTime(self, (self.splash_time - time));
		}
		else
		{
			self.think = frost_ice_sheet;
			AdvanceThinkTime(self, 0.1);
		}
	}
	else
	{
		self.think = ChunkShrink;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void ()frost_timer = {
	local float pc;
	local vector move_angle;
	
	self.dmg = self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500);
	if (time < self.splash_time) {
		self.scale = (1.00000 - ((self.splash_time - time) / self.lifetime)) + 0.50000;
		pc = pointcontents(self.origin);
		if ( ((((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) || (pc == CONTENT_LAVA))) && (chunk_cnt < CHUNK_MAX) ) {
			chunk_cnt += 1;
			//setmodel ( self, "models/dwarf.mdl");
			self.owner = world;
			self.velocity = '0 0 3';
			self.friction = 0;
			self.angles_x = 0;
			setsize(self, '-128 -128 -3', '128 128 3');
			self.mass = 9999;
			self.scale = 2.00000;
			self.cnt = 1;
			self.movetype = MOVETYPE_FLYMISSILE;
			self.solid = SOLID_BBOX;
			self.th_die = chunk_death;
			sound ( self, CHAN_BODY, "crusader/frozen.wav", 1.00000, ATTN_NORM);
			if (pc == CONTENT_LAVA)
			{
				self.drawflags ^= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.skin = GLOBAL_SKIN_STONE;
				self.thingtype = THINGTYPE_GREYSTONE;
			}
			else
			{
				self.skin = GLOBAL_SKIN_ICE;
				self.thingtype = THINGTYPE_ICE;
			}
			self.health = 90;
			self.takedamage = DAMAGE_YES;
			self.lifetime = 5.00000;
			self.splash_time = (time + self.lifetime);
			
			self.touch = frost_ice_touch;
			self.think = frost_ice_sheet;
			AdvanceThinkTime(self, 0.1);
		}
		else
		{
			local entity head;
			head = findradius ( self.origin, 100);
			
			while (head)
			{
				if ((head.takedamage == DAMAGE_YES) && (head != self.owner))
				{
					if (head.status_effects & STATUS_WET)
						self.dmg *= 2.00000;
					
					if ( ((((((head.health <= self.dmg) || (((head.classname == "player") && (head.frozen <= -5.00000)) && (head.health < 200.00000))) && (head.solid != SOLID_BSP)) && !(head.artifact_active & ART_INVINCIBILITY)) && (head.thingtype == THINGTYPE_FLESH)) && (head.health < 100.00000)) )
					{
						SnowJob ( head, self.owner);
					}
					else if (head.frozen <= 0)
					{
						T_Damage ( head, self, self.owner, self.dmg);
					}
					
				}
				head = head.chain;
			}
			self.think = frost_timer;
			AdvanceThinkTime(self, 0.1);
		}
		

	} else {
		remove (self);
		return;
	}
};

void ()frost_launch = {
	local entity frost;
	local vector vec;
	if (self.elemana>0) {
		frost = spawn();
		frost.spelldamage = self.spelldamage;
		self.elemana = (self.elemana - 0.5);
		vec = normalize (v_forward); 
		vec_z = 0 - vec_z + (random() - 0.5)*0.1; //well this is easy to understand... 
		self.magic_finished = (time + 0.2);
		particle2 ( (self.origin + '0 0 30'), v_forward, (v_forward * 200), (40 + random(7)), 35, 80);
		//frost.origin = (self.origin + '0 0 20');
		setorigin(frost, self.origin + '0 0 20' + (v_forward * 40));
		sound (frost, CHAN_VOICE, "crusader/tornado.wav", 1, ATTN_NORM);
		frost.lifetime = 0.62500;
		frost.splash_time = (time + frost.lifetime);
		frost.owner = self;
		frost.movetype = MOVETYPE_NOCLIP;
		frost.solid = SOLID_NOT;
		//setmodel ( frost, "models/dwarf.mdl");
		setmodel ( frost, "models/arazor.mdl");
		frost.skin = GLOBAL_SKIN_ICE;
		frost.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		frost.abslight = 1.00000;
		setsize(frost, '-10 -10 -3', '10 10 3');
		frost.velocity = vec * 300; //speed up 
		frost.velocity_x = frost.velocity_x + ((random() - 0.5) * 300); //random spread 
		frost.velocity_y = frost.velocity_y + ((random() - 0.5) * 300); //random spread 
		frost.velocity_z = frost.velocity_z - (2 * frost.velocity_z); //fixes strange bug* 
		frost.angles = vectoangles(frost.velocity);

		frost.scale = 0.5;
		frost.think = frost_timer;
		frost.nextthink = (time + 0.02);
	} else {
		sprint (self, "not enough mana to cast arctic wind!\n");
	}
};
