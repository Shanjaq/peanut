void() remove_status_controller =
{
	local entity status;

	if (self == status_head)
	{
		status_head = world;
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		status = status_head;
		while(status)
		{
			if (status.chain2 == self)
			{
				if (self.chain2 != world)
					status.chain2 = self.chain2;
				else
					status.chain2 = world;
				
				self.think = SUB_Remove;
				AdvanceThinkTime(self, HX_FRAME_TIME);
				return;
			}
			
			status = status.chain2;
		}
	}
};


float BURN_MAX_COUNT = 10;
void() burn_status_effect =
{
	local entity nearest;
	local float average_width;
	local float  pc;

	pc = pointcontents (self.goalentity.origin);
	if ((pc == CONTENT_WATER) || (pc == CONTENT_SLIME) || (self.goalentity.status_effects & STATUS_WET))
	{
		self.burn_time = time;
		sound (self, CHAN_WEAPON, "misc/fout.wav", 1, ATTN_NORM);
		return;
	}
	
	if (time > self.burn_next)
	{
		self.burn_next = time + 0.75000;
		self.dmg = ((self.burn_dmg + random(self.burn_dmg*(-0.12500), self.burn_dmg*0.12500)) * (self.burn_cnt * ((self.burn_time - time) / self.burn_duration)));
		if (self.goalentity.health)
		{
			if ((self.goalentity.health <= self.dmg) && (self.goalentity.abslight != 0.05))
			{
				self.goalentity.drawflags = MLS_ABSLIGHT;
				self.goalentity.abslight = 0.05;
				
				if ((self.goalentity.classname == "monster_archer") || (self.goalentity.classname == "monster_archer_lord") || (self.goalentity.classname == "monster_mezzoman") || (self.goalentity.classname == "monster_werepanther") || (self.goalentity.classname == "player"))
					sound ( self, CHAN_VOICE, "burnme.wav", 1.00000, ATTN_NORM);
			}
			
			average_width = (self.goalentity.size_x + self.goalentity.size_y) * 0.50000;
			T_Damage (self.goalentity, self, self.owner, self.dmg);
		}
		else
		{
			T_Damage (self.goalentity, self, self.owner, self.dmg);
		}
	}
	
	if (random() < 0.2)
	{
		if (self.stepy < 3)
		{
			self.stepy += 1;
			burn_flame();
		}
		
		if ((random() < 0.30000) && (self.goalentity.origin != VEC_ORIGIN))
		{
			average_width = (self.goalentity.size_x + self.goalentity.size_y) * 0.5;
			if (average_width < 5)
				average_width = 64;
			
			
			nearest = findNearestHurtable(self.origin, ((average_width*0.50000) + 64.00000) /** self.spellradiusmod*/, 1, 0, TRUE);
			if (nearest != world)
			{
				apply_status(nearest, STATUS_BURNING, self.burn_dmg, 8);
			}
		}
	}
};

float POISON_MAX_COUNT = 10;
void() poison_status_effect =
{
	local vector pos;
	
	if (!(self.goalentity.flags2 & FL_ALIVE))
	{
		self.poison_time = time;
		return;
	}
	
	pos = random(self.goalentity.absmin, self.goalentity.absmax);
	particle2 ( pos, '-5.00000 -5.00000 5.00000', '5.00000 5.00000 15.00000', (96.00000 + random(15.00000)), PARTICLETYPE_BLOB, random(9, 16));

	if (time >= self.poison_next)
	{
		self.poison_next = (time + 1.2);
		
		if (self.goalentity.classname == "player")
			stuffcmd ( self.goalentity, "df\n");
		
		self.dmg = ((self.poison_dmg + random(self.poison_dmg*(-0.12500), self.poison_dmg*0.12500)) * (self.poison_cnt * ((self.poison_time - time) / self.poison_duration)));
		T_Damage ( self.goalentity, self, self.owner, self.dmg );
	}
};

void() toxic_status_effect =
{
	local float pc;
	local entity splode;
	
	pc = pointcontents (self.goalentity.origin);
	if ((pc == CONTENT_WATER) || (self.goalentity.status_effects & STATUS_WET))
	{
		self.toxic_time = time;
		sound (self, CHAN_WEAPON, "misc/fout.wav", 1, ATTN_NORM);
		return;
	}
	
	self.dest = random(self.goalentity.absmin, self.goalentity.absmax);
	particle2 ( self.dest, '-20.00000 -20.00000 -20.00000', '20.00000 20.00000 64.00000', random(185, 191), PARTICLETYPE_FASTGRAV, random(8, 24));
	if (time >= self.toxic_next)
	{
		self.toxic_next = (time + 0.75000);
		self.dmg = (self.toxic_dmg + random(self.toxic_dmg*(-0.12500), self.toxic_dmg*0.12500));
		
		if ((self.goalentity.health > self.dmg) && (self.goalentity.origin != VEC_ORIGIN)) //alive and not removed
		{
			if (random() < 0.12500)
				sound ( self.goalentity, CHAN_AUTO, "crusader/sunhit.wav", 1.00000, ATTN_NORM);
			
			T_Damage ( self.goalentity, self, self.owner, self.dmg );
		}
		else
		{
			if (self.goalentity.origin != VEC_ORIGIN)
			{
				
				if (self.goalentity.deadflag == DEAD_DEAD)
				{
					self.goalentity.th_die = SUB_Remove;
					//self.goalentity.think = SUB_NullDeath;
					self.goalentity.think = SUB_Remove;
					AdvanceThinkTime(self.goalentity, HX_FRAME_TIME);
					
					splode = spawn();
					splode.effects = (EF_NODRAW | EF_DARKLIGHT);
					setmodel ( splode, "models/psbg.spr");
					splode.step4 = 9999;  //green gibs
					splode.thingtype = THINGTYPE_FLESH;
					setsize(splode, self.goalentity.mins * 2.25000, self.goalentity.maxs * 2.25000);
					setorigin(splode, self.origin + '0 0 5');
					splode.think = chunk_death;
					sound ( splode, CHAN_VOICE, "player/megagib.wav", 1.00000, ATTN_NORM);
					sound ( splode, CHAN_VOICE, "player/megagib.wav", 1.00000, ATTN_NORM);
					particle2 ( splode.origin, '-128.00000 -128.00000 30.00000', '128.00000 128.00000 300.00000', random(185, 191), PARTICLETYPE_FASTGRAV, random(128, 196));
					
					WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
					WriteByte ( MSG_BROADCAST, TE_LIGHT_PULSE);
					WriteEntity ( MSG_BROADCAST, splode);
					
					AdvanceThinkTime(splode, 0.25);
					T_RadiusDamageFlat (self.goalentity, self.owner, (self.toxic_dmg + random(self.toxic_dmg*(-0.12500), self.toxic_dmg*0.12500)) * random(7, 10), 128.00000/**self.spellradiusmod*/, self.owner, FALSE);
				}
				else
				{
					if (self.goalentity.flags2 & FL_ALIVE)
						T_Damage ( self.goalentity, self, self.owner, self.dmg );
				}
			}
		}
	}
};



void() status_controller_think =
{
	local entity status;
	local vector pos;
	
	if ((self.goalentity.origin == VEC_ORIGIN) || (self.goalentity == world))
	{
		sound ( self, CHAN_WEAPON, "misc/null.wav", 0.30000, ATTN_NORM);
		self.think = remove_status_controller;
		AdvanceThinkTime(self, HX_FRAME_TIME);
		return;
	}
	else
	{
		if (time >= self.attack_finished)
		{
			self.attack_finished = time + 1.00000;
			setorigin(self, self.goalentity.origin);
		}
		
		if (self.burn_time > time)
		{
			if (!(self.goalentity.status_effects & STATUS_BURNING))
			{
				self.goalentity.status_effects |= STATUS_BURNING;
				if (self.burn_cnt < 6)
					sound ( self, CHAN_WEAPON, "misc/fburn_md.wav", 1.00000, ATTN_NORM);
				else
					sound ( self, CHAN_WEAPON, "misc/fburn_bg.wav", 1.00000, ATTN_NORM);
			}
			
			burn_status_effect();
		}
		else
		{
			if (self.goalentity.origin != VEC_ORIGIN)
			{
				if (self.goalentity.status_effects & STATUS_BURNING)
				{
					self.goalentity.status_effects ^= STATUS_BURNING;
					sound ( self, CHAN_WEAPON, "misc/null.wav", 0.30000, ATTN_NORM);
				}
			}
			else
				sound ( self, CHAN_WEAPON, "misc/null.wav", 0.30000, ATTN_NORM);
		}
		
		if (self.poison_time > time)
		{
			if (!(self.goalentity.status_effects & STATUS_POISON))
				self.goalentity.status_effects |= STATUS_POISON;
			
			poison_status_effect();
		}
		else
		{
			if (self.goalentity.status_effects & STATUS_POISON)
				self.goalentity.status_effects ^= STATUS_POISON;
		}
		
		if (self.wet_time > time)
		{
			if (!(self.goalentity.status_effects & STATUS_WET))
				self.goalentity.status_effects |= STATUS_WET;
			
			pos = random(self.goalentity.absmin, self.goalentity.absmax);
			particle2 ( pos, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (16.00000 + random(15.00000)), PARTICLETYPE_FASTGRAV, random(16, 32));
		}
		else
		{
			if (self.goalentity.status_effects & STATUS_WET)
				self.goalentity.status_effects ^= STATUS_WET;
		}
		
		if (self.toxic_time > time)
		{
			if (!(self.goalentity.status_effects & STATUS_TOXIC))
				self.goalentity.status_effects |= STATUS_TOXIC;
			
			toxic_status_effect();
		}
		else
		{
			if (self.goalentity.status_effects & STATUS_TOXIC)
				self.goalentity.status_effects ^= STATUS_TOXIC;
		}
		
		if (self.goalentity.status_effects == 0.00000)
		{
			self.think = remove_status_controller;
			AdvanceThinkTime(self, HX_FRAME_TIME);
			return;
		}
	}
	
	
	self.think = status_controller_think;
	AdvanceThinkTime(self, 0.12500);
};

float STATUS_GET_CREATE = 1;
float STATUS_GET_AVERAGE = 2;
float STATUS_GET_HIGHEST = 4;
float STATUS_GET_LOWEST = 8;
float STATUS_GET_ANY = 16;

entity(entity forent, float query_flags) status_controller_get =
{
	local entity status, laststatus;
	
	status = status_head;
	while(status)
	{
		if ((status.goalentity == forent) && ((status.owner == self.owner) || (query_flags & STATUS_GET_ANY)))
			return status;
		
		laststatus = status;
		status = status.chain2;
	}
	
	//no status_controller found
	if (query_flags & STATUS_GET_CREATE)
	{
		status = spawn();
		setorigin(status, forent.origin);
		status.attack_finished = (time + 1.00000);
		status.solid = SOLID_NOT;
		status.movetype = MOVETYPE_NOCLIP;
		setmodel(status, "models/null.spr");
		status.hull = HULL_POINT;
		status.takedamage = DAMAGE_NO;
		status.owner = self.owner;
		status.goalentity = forent;
		
		if (status_head == world)
		{
			status_head = status;
		}
		else
		{
			laststatus.chain2 = status;
		}
		status.think = status_controller_think;
		AdvanceThinkTime(status, 1.00000);
	}
	return status;
};

void(entity forent, float status_effect, float damage, float duration) apply_status =
{
	local entity status;
	
	if (forent != world)
	{
		if (status_effect & STATUS_BURNING)
		{
			if ((forent.thingtype != THINGTYPE_GREYSTONE) && (forent.thingtype != THINGTYPE_BROWNSTONE) && (forent.thingtype != THINGTYPE_CLAY) && (forent.thingtype != THINGTYPE_GLASS) && (forent.thingtype != THINGTYPE_ICE) && (forent.thingtype != THINGTYPE_CLEARGLASS) && (!(forent.status_effects & STATUS_WET)))
			{
				status = status_controller_get(forent, (STATUS_GET_CREATE | STATUS_GET_ANY));
				status.burn_duration = duration;
				status.burn_time = (time + duration);
				status.burn_dmg = damage;
				
				if (status.burn_cnt < BURN_MAX_COUNT)
					status.burn_cnt += 1;
			}

		}
		
		if (status_effect & STATUS_POISON)
		{
			if ((forent.flags2 & FL_ALIVE) && (forent.thingtype == THINGTYPE_FLESH))
			{
				status = status_controller_get(forent, STATUS_GET_CREATE);
				status.poison_duration = duration;
				status.poison_time = (time + duration);
				status.poison_dmg = damage;
				
				if (status.poison_cnt < POISON_MAX_COUNT)
					status.poison_cnt += 1;
			}
		}

		if (status_effect & STATUS_WET)
		{
			status = status_controller_get(forent, (STATUS_GET_CREATE | STATUS_GET_ANY));
			status.wet_time = (time + duration);
			status.wet_dmg = damage;
		}

		if (status_effect & STATUS_TOXIC)
		{
			if (!(forent.status_effects & STATUS_WET))
			{
				status = status_controller_get(forent, (STATUS_GET_CREATE | STATUS_GET_ANY));
				status.toxic_time = (time + duration);
				status.toxic_dmg = damage;
			}
		}
	}
};

void(entity forent, float status_effect) remove_status =
{
	local entity status;
	
	status = status_head;
	while(status)
	{
		if (status.goalentity == forent)
		{
			if (status_effect & STATUS_BURNING)
				status.burn_time = time;
			
			if (status_effect & STATUS_POISON)
				status.poison_time = time;

			if (status_effect & STATUS_WET)
				status.wet_time = time;

			if (status_effect & STATUS_TOXIC)
				status.toxic_time = time;
		}
		
		status = status.chain2;
	}
};

void() check_statuses =
{
	local entity status;
	local float i;
	
	status = status_head;
	while(status)
	{
		dprint("BARF1024: ");
		dprint(status.goalentity.classname);
		dprintf(" : %s\n", i);
		i += 1;
		status = status.chain2;
	}
};