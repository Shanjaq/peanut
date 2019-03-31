void() supernova_shaft_think =
{
	if (time < self.splash_time)
	{
		if (self.controller != world)
			setorigin(self, self.controller.origin);
		
		self.think = supernova_shaft_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}	
};

void() supernova_shaft =
{
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.controller = self.controller;
	setorigin(newmis, self.origin);
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER | SCALE_ORIGIN_BOTTOM);
	newmis.effects = EF_DIMLIGHT;
	newmis.abslight = 1.0;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.avelocity = RandomVector('360.00000 360.00000 360.00000');
	setmodel(newmis, "models/boss/shaft.mdl");
	newmis.hull = HULL_POINT;
	newmis.scale = random(0.93625, 1.25000);
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.lifetime = random(1.00000, 2.00000);
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = supernova_shaft_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};

void() supernova_starfield_think =
{
	local float len;
	local vector dir;
	
	if (time < self.splash_time)
	{
		if (self.controller != world)
			setorigin(self, self.controller.origin);
		
		dir = RandomVector('360.00000 360.00000 360.00000');
		makevectors(dir);
		traceline (self.origin, (self.origin + (v_forward * (random(128.00000, 320.00000) * self.controller.scale))) , TRUE , self);
		len = vlen(trace_endpos - self.origin);
		if (self.goalentity != world)
			setorigin(self.goalentity, trace_endpos);
		
		//particle2 ( trace_endpos, (v_forward * random((len * -1.00000), -64.00000)) + '-12 -12 -12', (v_forward * random((len * -1.00000), -64.00000)) + '12 12 12', random(25, 31), PARTICLETYPE_BLOB, random(15.00000, 37.00000));
		//particle2 ( trace_endpos, (v_forward * random((len * -1.00000), -64.00000)) + '-12 -12 -12', (v_forward * random((len * -1.00000), -64.00000)) + '12 12 12', random(25, 31), PARTICLETYPE_BLOB, random(15.00000, 37.00000));
		if (self.attack_finished < time)
		{
			supernova_shaft();
			self.attack_finished = (time + random(0.63750, 1.12500));
		}
		
		self.think = supernova_starfield_think;
		AdvanceThinkTime(self, random((HX_FRAME_TIME * 2.00000), (HX_FRAME_TIME * 6.00000)));
	}
	else
	{
		if (self.goalentity != world)
			remove(self.goalentity);
		
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void () supernova_star_think =
{
	local float len;
	local vector dir;
	if (self.controller != world)
	{
		dir = normalize(self.origin - self.controller.origin);
		len = vlen(self.origin - self.controller.origin);
		//particle2 ( self.origin, (dir * random((len * -1.00000), -64.00000)) + '-12 -12 -12', (dir * random((len * -1.00000), -64.00000)) + '12 12 12', random(25, 31), PARTICLETYPE_BLOB, random(15.00000, 37.00000));
		particle2 ( self.origin, (dir * (len / -4)) + '-4 -4 -4', (dir * (len / -2)) + '4 4 4', random(25, 31), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
	}
	self.think = supernova_star_think;
	AdvanceThinkTime(self, HX_FRAME_TIME * 2.00000);
};

void() supernova_starfield =
{
	local entity starfield;
	
	starfield = spawn();
	starfield.spelldamage = self.spelldamage;
	starfield.spellradiusmod = self.spellradiusmod;
	starfield.owner = self.owner;
	starfield.controller = self.controller;
	starfield.lifetime = 5.00000;
	starfield.splash_time = (time + starfield.lifetime);
	setorigin(starfield, self.origin);
	starfield.solid = SOLID_NOT;
	starfield.movetype = MOVETYPE_NOCLIP;
	starfield.hull = HULL_POINT;
	setsize(starfield, '0 0 0', '0 0 0');
	AdvanceThinkTime(starfield, 0.1);
	starfield.think = supernova_starfield_think;
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.controller = self.controller;
	starfield.goalentity = newmis;
	setorigin(newmis, self.origin);
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER);
	newmis.effects = EF_DIMLIGHT;
	newmis.abslight = 1.0;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.avelocity = RandomVector('360.00000 360.00000 360.00000');
	setmodel(newmis, "models/boss/star.mdl");
	newmis.hull = HULL_POINT;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.think = supernova_star_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};

void() supernova_think =
{
	local vector dir;
	local entity found;
	local float i;
	
	if (time < self.splash_time)
	{
		if (self.origin_z > self.auraV)
		{
			self.velocity = '0 0 0';
			self.dest = self.origin;
			self.dest_z = self.auraV;
			setorigin(self, self.dest);
		}
	
		if (self.type_index == 0)
		{
			if (self.attack_finished < time)
			{
				//dprintf("BARF100: %s\n", framecount);
				found = T_RadiusDamageFlat(self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500)), (480.00000 * self.scale), self.owner, 3);
				//dprintf("BARF101: %s\n", framecount);

				while(found != world)
				{
					dir = normalize((found.origin + ((found.mins + found.maxs)*0.5)) - self.origin);
					
					self.dest = random(found.absmin, found.absmax);
					
					if (found.halted == 0)
					{
						if ((found.flags & FL_MONSTER) && ((!(found.flags2 & FL_ALIVE)) || found.health <= self.spelldamage * 1.12500))
						{
							//dprint("BARF98: ");
							//dprint(found.classname);
							//dprint("\n");
							found.halted = 1;
							//Killed(found, self.owner, self);
							
							newmis = spawn();
							newmis.solid = SOLID_NOT;
							newmis.movetype = MOVETYPE_NOCLIP;
							newmis.takedamage = DAMAGE_NO;
							setorigin(newmis, found.origin);
							setmodel(newmis, found.model);
							newmis.angles = found.angles;
							newmis.frame = found.frame;
							newmis.skin = GLOBAL_SKIN_STONE;
							//newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_TORCH | MLS_FIREFLICKER);
							newmis.drawflags |= (MLS_ABSLIGHT);
							newmis.abslight = 1;
							newmis.scale = found.scale;
							newmis.think = SUB_Remove;
							AdvanceThinkTime(newmis, 0.23625);
							
							
							newmis = spawn();
							newmis.controller = self;
							newmis.solid = SOLID_NOT;
							newmis.movetype = MOVETYPE_NOCLIP;
							setorigin(newmis, self.origin);
							setmodel(newmis, "models/boss/shaft.mdl");
							//newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_TORCH | MLS_FIREFLICKER);
							newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER | SCALE_ORIGIN_BOTTOM);
							newmis.angles = vectoangles(dir);
							newmis.angles = newmis.angles_x = ((90.00000 - newmis.angles_x) * -1.00000);
							newmis.abslight = 1;
							newmis.scale = self.scale;
							newmis.lifetime = 0.75;
							newmis.splash_time = (time + newmis.lifetime);
							newmis.think = ChunkShrink;
							AdvanceThinkTime(newmis, HX_FRAME_TIME);
							
							//sound ( found, CHAN_AUTO, "raven/inlava.wav", 1.00000, ATTN_NORM);
							sound ( found, CHAN_AUTO, "golem/awaken.wav", 1.00000, ATTN_NORM);
							i = random(8, 15);
							while(i > 0)
							{
								self.dest = random(found.absmin, found.absmax);
								self.delay = vlen(self.dest - self.origin);
								dir = normalize(self.dest - self.origin);
								particle2 ( self.dest, (dir * (self.delay * -0.25)) + '-2 -2 -2', (dir * (self.delay * -0.5)) + '2 2 2', random(25, 31), PARTICLETYPE_BLOB, random(24.00000, 58.00000));
								i -= 1;
							}
							
							if (self.owner != world)
								AwardExperience ( self.owner, found, found.experience_value);
							
							found.think = SUB_NullDeath;
							AdvanceThinkTime(found, HX_FRAME_TIME);
							//remove(found);
						}
						else if ((!(found.flags & FL_MONSTER)) && (found.health <= (self.spelldamage * 1.12500)) && (found.classname != "player") && (found.solid != SOLID_BSP) && (found.health > -1.00000))
						{
							//dprint("BARF97: ");
							//dprint(found.classname);
							//dprint("\n");
							
							found.halted = 1;
							newmis = spawn();
							newmis.controller = self;
							newmis.solid = SOLID_NOT;
							newmis.movetype = MOVETYPE_NOCLIP;
							newmis.takedamage = DAMAGE_NO;
							setorigin(newmis, found.origin);
							setmodel(newmis, found.model);
							newmis.angles = found.angles;
							newmis.frame = found.frame;
							newmis.skin = GLOBAL_SKIN_STONE;
							//newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_TORCH | MLS_FIREFLICKER);
							newmis.drawflags |= (MLS_ABSLIGHT);
							newmis.abslight = 1;
							newmis.scale = found.scale;
							newmis.think = SUB_Remove;
							AdvanceThinkTime(newmis, 0.23625);
							
							sound ( found, CHAN_AUTO, "golem/awaken.wav", 1.00000, ATTN_NORM);
							i = random(8, 15);
							while(i > 0)
							{
								self.dest = random(found.absmin, found.absmax);
								self.delay = vlen(found.origin - self.origin);
								dir = normalize(self.dest - self.origin);
								particle2 ( self.dest, (dir * (self.delay * -0.25)) + '-2 -2 -2', (dir * (self.delay * -0.5)) + '2 2 2', random(25, 31), PARTICLETYPE_BLOB, random(24.00000, 58.00000));
								i -= 1;
							}
							
							found.think = SUB_NullDeath;
							AdvanceThinkTime(found, HX_FRAME_TIME);
							/*
							if (found.th_die)
							{
								found.hull = HULL_POINT;
								setsize(found, VEC_ORIGIN, VEC_ORIGIN);
								found.think = found.th_die;
								AdvanceThinkTime(found, HX_FRAME_TIME);
							}
							else
								remove(found);
							*/
						}
						else
						{
							//dprint("BARF95: ");
							//dprint(found.classname);
							//dprint("\n");
							//particle2 ( self.dest, '-12 -12 -12', '12 12 12', random(25, 31), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
							particle2 ( self.dest, (dir * random(32, 64)) + '32 32 32', (dir * random(32, 64)) + '-32 -32 -32', 255, PARTICLETYPE_C_EXPLODE2, random(5.00000, 21.00000));
							if (random() < 0.12500)
								sound ( found, CHAN_AUTO, "crusader/sunhit.wav", 1.00000, ATTN_NORM);
						}
					}
					
					found = found.chain2;
				}
				self.attack_finished = (time + 0.12500);
			}
			
			if (self.magic_finished < time)
			{
				sound ( self, CHAN_AUTO, "rw15ele5.wav", 1.00000, ATTN_NORM);	
				self.magic_finished = (time + 1.40000);
			}
		}
		
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * (1.60000 * self.spellradiusmod));
		self.think = supernova_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		if (time < (self.splash_time + 0.63750))
		{
			if ((self.type_index == 0) && (self.cnt == 0))
			{
				sound ( self, CHAN_AUTO, "antichkn.wav", 1.00000, ATTN_NORM);
				self.cnt = 1;
			}
			particle2 ( self.origin, '-360 -360 -360', '360 360 360', 255, PARTICLETYPE_C_EXPLODE2, random(96.00000, 128.00000));
			particle2 ( self.origin + (RandomVector('128 128 128') * self.scale), '32 32 32', '-32 -32 -32', 255, PARTICLETYPE_BLOB, random(5.00000, 21.00000));
			self.abslight = (((self.splash_time + 0.63750) - time) / 0.63750);
			self.think = supernova_think;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		else
		{
			self.think = SUB_Remove;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
	}	
};

void() spawn_supernova =
{
	local entity found;
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	self.controller = newmis;
	setorigin(newmis, self.origin);
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER);
	newmis.effects = EF_DIMLIGHT;
	newmis.abslight = 1.0;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.avelocity = RandomVector('360.00000 360.00000 360.00000');
	newmis.velocity = ('0 0 1' * (self.auraV / 3));
	newmis.auraV = self.origin_z + self.auraV;
	setmodel(newmis, "models/boss/circle.mdl");
	newmis.hull = HULL_POINT;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.lifetime = 7.00000;
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = supernova_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);

	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.type_index = 1;
	setorigin(newmis, self.origin);
	newmis.drawflags |= (MLS_ABSLIGHT);
	//newmis.effects = EF_BRIGHTLIGHT;
	newmis.abslight = 1.0;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.avelocity = RandomVector('360.00000 360.00000 360.00000');
	setmodel(newmis, "models/boss/star.mdl");
	newmis.hull = HULL_POINT;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.velocity = ('0 0 1' * (self.auraV / 3));
	newmis.auraV = self.origin_z + self.auraV;
	newmis.lifetime = 7.00000;
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = supernova_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	
	supernova_starfield();
	supernova_starfield();
	supernova_starfield();
	found = find(world, classname, "player");
	while (found)
	{
		if ((vlen(found.origin - self.origin) < (512.00000 * self.spellradiusmod)) && visible2ent(found, self))
		{
			found.artifact_active |= ARTFLAG_DIVINE_INTERVENTION;
			found.divine_time = (time + 0.63750);
		}
		found = find(found, classname, "player");
	}
	
	particle2 ( self.origin - '0 0 64', '-12 -12 10', '12 12 300', 255, PARTICLETYPE_BLOB, random(84.00000, 128.00000));
	particle2 ( self.origin - '0 0 64', '-12 -12 10', '12 12 300', 255, PARTICLETYPE_BLOB, random(84.00000, 128.00000));
	sound ( self, CHAN_AUTO, "rw14nova.wav", 1.00000, ATTN_NORM);
};

void() supernova_init_think =
{
	if (time < self.splash_time)
	{
		if (self.auraV == 0)
		{
			pitch_roll_for_slope ( '0.00000 0.00000 0.00000');
			sound ( self, CHAN_AUTO, "effm03a.wav", 1.00000, ATTN_NORM);
			traceline (self.origin+('0 0 20') , (self.origin+('0 0 128')) , TRUE , self);
			//self.auraV = (vlen(self.origin - trace_endpos) / 3.00000);
			if (trace_fraction < 1.00000)
				self.auraV = (vlen(self.origin - trace_endpos) / 2.00000);
			else
				self.auraV = 128;
		}
		self.scale = (((self.splash_time - time) / self.lifetime) * 1.50000);
		self.think = supernova_init_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		spawn_supernova();
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}	
};

void() supernova_init =
{
	newmis = spawn();
	//newmis.spelldamage = self.spelldamage;
	newmis.spelldamage = 8;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	traceline (self.origin+('0 0 20') , (self.origin-('0 0 600')) , TRUE , self);
	setorigin(newmis, trace_endpos + '0 0 2');
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER);
	newmis.effects = EF_DIMLIGHT;
	newmis.abslight = 1.0;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setmodel(newmis, "models/expring.mdl");
	newmis.skin = 2;
	newmis.hull = HULL_POINT;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.scale = 1.00000;
	newmis.lifetime = 1.36250;
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = supernova_init_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};