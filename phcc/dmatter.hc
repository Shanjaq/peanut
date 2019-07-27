
void() baddie_bomb_think = {
	if (self.scale < (self.auraV + 1.3)) {
		self.scale += 0.08;
		self.think = baddie_bomb_think;
	} else {
		remove(self);
	}
	AdvanceThinkTime(self, 0.02);
};

void() baddie_bomb = {
	if (self.classname != "player") {
		if (self.classname == "Chaos") {
			AdvanceThinkTime(self, 0.02);
			self.think = chaos_sphere_death;
		} else {
			self.think = SUB_NullDeath;
			AdvanceThinkTime(self, HX_FRAME_TIME);
			//remove(self);
		}
	} else {
		T_Damage ( self, self, world, 50);
		
		self.halted = 0;
	}
	
	
	newmis = spawn();
	setorigin(newmis, self.origin + ('0 0 1' * (self.size_z / 2)));
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.scale = 0.05;
	newmis.skin = 1;
	setmodel(newmis, "models/star2.mdl");
	sound ( newmis, CHAN_AUTO, "darkblast.wav", 1.00000, ATTN_NORM);
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 2;
	newmis.avelocity = random('-200 -200 -200', '200 200 200');
	newmis.owner = self;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = baddie_bomb_think;
};


void() dark_matter_annihilate = {
	sound ( self, CHAN_AUTO, "darkblast.wav", 1.00000, ATTN_NORM);
	remove(self);
};


void() dark_matter_effects_think = {
	if (time < self.splash_time)
	{
		if (random(1, 20) < 7) {
			sound ( self, CHAN_AUTO, "darkburst.wav", 1.00000, ATTN_NORM);
		}
		self.velocity += random('-80 -80 0', '80 80 0');
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * self.auraV);
		
		local entity head;
		head = findradius(self.origin, 100.00000*self.spellradiusmod);
		while(head) {
			if (head.takedamage == DAMAGE_YES) {
				self.dmg = self.spelldamage + random(self.spelldamage*(-0.30000), self.spelldamage*0.30000);
				if ((head.halted == 1) && (head.health > self.dmg)) {
					head.halted = 0;
					AdvanceThinkTime(head, 0.02);
				}
				
				if ((head.health > (self.dmg - 1)) || (head.health <= -1.00000)) {
					if ((head != self.owner) && (head.halted == 0))
					{
						if (head.classname == "lshield")
						{
							newmis = spawn();
							setorigin(newmis, head.origin);
							newmis.solid = SOLID_NOT;
							newmis.movetype = MOVETYPE_NOCLIP;
							newmis.scale = 0.75;
							newmis.auraV = 1.1;
							setmodel(newmis, "models/boss/star.mdl");
							sound ( newmis, CHAN_AUTO, "darkblast.wav", 1.00000, ATTN_NORM);
							newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							newmis.abslight = 2;
							newmis.angles = RandomVector('360 360 360');
							AdvanceThinkTime(newmis, HX_FRAME_TIME);
							newmis.think = baddie_bomb_think;
							
							head.health = 0.00000;
							particle2 ( head.origin, '-96 -96 -96', '96 96 96', random(25, 31), PARTICLETYPE_BLOB, random(64.00000, 96.00000));
							particle2 ( head.origin, '-4 -4 -4', '4 4 256', random(25, 31), PARTICLETYPE_BLOB, random(32.00000, 64.00000));
							T_RadiusDamageFlat (self, self.owner, (self.spelldamage * 4) + random(self.spelldamage*(2.00000), self.spelldamage*4.00000), 128.00000, self.owner, FALSE);
							head.think = head.th_die;
							AdvanceThinkTime(head, HX_FRAME_TIME);
						}
						else
							T_Damage ( head, self, self.owner, self.dmg);
					}
				} else {
					if (head != self.owner)
					{
						if (head.solid != SOLID_BSP) {
							head.drawflags |= MLS_ABSLIGHT;
							head.abslight = 0.06;
							if ((head.classname == "player") && (head.halted == 0) && (time > head.invincible_time)) {
								if (head.cnt_sh_boost == 0)
								{
									newmis = spawn();
									newmis.takedamage = DAMAGE_YES;
									newmis.health = 10;
									newmis.th_die = baddie_bomb;
									newmis.halted = 1;
									setorigin(newmis, head.origin);
									newmis.solid = SOLID_BBOX;
									newmis.movetype = MOVETYPE_NOCLIP;
									setmodel(newmis, head.model);
									newmis.frame = head.frame;
									newmis.angles = head.angles;
									newmis.drawflags |= MLS_ABSLIGHT;
									newmis.abslight = 0.06;
									AdvanceThinkTime(newmis, 6);
									newmis.think = baddie_bomb;
									head.movetype = MOVETYPE_NOCLIP;
									head.solid = SOLID_NOT;
									AdvanceThinkTime(head, 0.02);
									head.think = squelch;
								}
								else
								{
									T_Damage ( head, self, self.owner, self.dmg);
								}
							} else {
								if (head.halted == 0)
								{
									head.halted = 1;
									head.th_die = baddie_bomb;
									head.effects |= EF_DARKLIGHT;
									AdvanceThinkTime(head, 7);
									head.think = baddie_bomb;
								}
							}
							head.halted = 1;
						} else {
							T_Damage ( head, self, self.owner, self.dmg);
						}
					}
				}
			}
			head = head.chain;
		}
		
		AdvanceThinkTime(self, 0.1);
		self.think = dark_matter_effects_think;
	}
	else
	{
		remove(self);
	}
};

void() dark_matter_effects = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin(newmis, (self.origin + (random('-200 -200 -20', '200 200 10') * newmis.spellradiusmod)));
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 0.06;
	setmodel(newmis, "models/ghail.mdl");
	sound ( newmis, CHAN_AUTO, "darkburst.wav", 1.00000, ATTN_NORM);
	newmis.velocity_z = (-100 * newmis.spellradiusmod);
	newmis.avelocity = random('-400.00000 -400.00000 -400.00000','400.00000 400.00000 400.00000');
	newmis.auraV = (random(0.53000, 1.46000)*self.spellradiusmod);
	newmis.scale = 0.00200;
	newmis.lifetime = random(0.2, 0.8);
	newmis.splash_time = (time + newmis.lifetime);
	newmis.effects = EF_DARKLIGHT;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = dark_matter_effects_think;
};

void() energy_field_think = {
	if (time < self.splash_time) {
		if (self.scale < 0.7)
		{
			self.scale += 0.2;
			self.goalentity.scale += 0.2;
		}
		AdvanceThinkTime(self, 0.1);
	} else {
		self.effects ^= EF_NODRAW;
		self.goalentity.effects ^= EF_NODRAW;

		if (self.halted == 0) {
			self.halted = 1;
			local entity head;
			head = findradius(self.origin, 2000);
			
			while(head) {
				if (head.classname == "player") {
					sound ( head, CHAN_AUTO, "crusader/lghtn1.wav", 1.00000, ATTN_NORM);
					//					sound ( self.enemy, CHAN_AUTO, "crusader/lghtn1.wav", 1.00000, ATTN_NORM);
				}
				if (head.halted == 1) {
					if (head.classname == "player") {
						if (head.owner != self.owner)
						{
							T_Damage ( head, self, world, self.spelldamage + random(self.spelldamage*(-0.30000), self.spelldamage*0.30000));
							head.halted = 0;
							head.hasted = 1;
						}
					} else {
						//shan lightning effect
						WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
						WriteByte ( MSG_BROADCAST, TE_STREAM_LIGHTNING);
						WriteEntity ( MSG_BROADCAST, head);
						WriteByte ( MSG_BROADCAST, (6 + STREAM_ATTACHED));
						WriteByte ( MSG_BROADCAST, 2.00000);
						WriteCoord ( MSG_BROADCAST, head.origin_x);
						WriteCoord ( MSG_BROADCAST, head.origin_y);
						WriteCoord ( MSG_BROADCAST, head.origin_z + (head.size_z / 2));
						WriteCoord ( MSG_BROADCAST, self.origin_x);
						WriteCoord ( MSG_BROADCAST, self.origin_y);
						WriteCoord ( MSG_BROADCAST, self.origin_z);
						//shan lightning effect end
						
						starteffect ( CE_MAGIC_MISSILE_EXPLOSION, ((head.absmin + head.absmax) * 0.50000), 0.06250);
						head.skin = GLOBAL_SKIN_ICE;
						head.abslight = 2;
						
						AwardExperience ( self.owner, head, head.experience_value);
						AdvanceThinkTime(head, 0.1);
						T_Damage ( head, self, world, (head.health + 1));
						//head.think = head.th_die;
					}
				}
				head = head.chain;
			}
		}
		
		if (self.scale < (1.65000*self.spellradiusmod)) 
		{
			self.scale += 0.125;
			self.goalentity.scale += 0.125;
		} else {
			remove(self.goalentity);
			remove(self);
		}
		AdvanceThinkTime(self, 0.02);
	}
	self.think = energy_field_think;
};

void() energy_field = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.lifetime = 5.00000;
	newmis.splash_time = time + newmis.lifetime;
	setorigin(newmis, (self.origin + '0 0 50'));
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	newmis.scale = 0.1;
	newmis.avelocity = random('-400 -400 -400', '400 400 400');
	setmodel(newmis, "models/glowball2.mdl");
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.effects = EF_NODRAW;
	newmis.frags = random(16, 25)/10;
	newmis.abslight = 1;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = energy_field_think;

	trace_ent = newmis;
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	setorigin(newmis, (self.origin + '0 0 50'));
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	newmis.scale = trace_ent.scale - 0.05;
	newmis.avelocity = random('-400 -400 -400', '400 400 400');
	setmodel(newmis, "models/glowball2.mdl");
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.effects = EF_NODRAW;
	newmis.abslight = 1;
	
	trace_ent.goalentity = newmis;
	
};

void() dark_matter_spread = {
	if (time < self.splash_time) {
		dark_matter_effects();
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(1, 6), 17, 80.00000);
		particle2 ( (self.origin + random('-300 -300 -30', '300 300 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(1, 6), 2, 80.00000);
		AdvanceThinkTime(self, 0.1);
		self.think = dark_matter_spread;
	} else {
		AdvanceThinkTime(self, 0.1);
		self.think = dark_matter_annihilate;
	}
};

void() dark_matter_fall = {
	if (self.origin_z > self.auraV) {
		//if ((self.origin_z - 40) < self.auraV) {
		//self.velocity_z *= 0.8;
		//}
		if (self.angles_z != 180) {
			self.angles_z = 180;
			self.avelocity_y = 100;
			self.scale = 0.1;
			setmodel(self, "models/dmatter.mdl");
			self.velocity_z = self.auraV - self.origin_z;
		}
		
		self.scale = ((1.6 * self.spellradiusmod) * (1.00000 - ((self.origin_z - self.auraV) / (self.auraT - self.auraV))));
		
		AdvanceThinkTime(self, 0.1);
		self.think = dark_matter_fall;
	} else {
		self.velocity_z = 0;
		self.dest = self.origin;
		self.dest_z = self.auraV;
		self.scale = (1.6 * self.spellradiusmod);
		setorigin(self, self.dest);
		self.abslight = 1;
		energy_field();
		AdvanceThinkTime(self, 0.1);
		self.think = dark_matter_spread;
	}
};

void() light_matter_rise_think = {
	if (self.origin_z < self.auraV) {
		T_RadiusDamageFlat (self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500), 75.00000 * self.spellradiusmod, self.owner, FALSE);
	} else {
		self.velocity_z = 0;
		self.dest = self.origin;
		self.dest_z = self.auraV;
		setorigin(self, self.dest);
		if (time > self.splash_time) {
			remove(self);
		}

	}
	AdvanceThinkTime(self, 0.1);
	self.think = light_matter_rise_think;
};

void() light_matter_rise = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.lifetime = 7.00000;
	newmis.splash_time = time + newmis.lifetime;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	setorigin(newmis, (self.origin - '0 0 40'));
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	setmodel(newmis, "models/lmatter.mdl");
	newmis.abslight = 1;
	newmis.scale = ((1.6 * self.spellradiusmod) * 0.36250);
	//newmis.auraV = (self.origin_z + (200 - (self.spellradiusmod * 12)));
	newmis.auraV = (self.origin_z + (128 * self.spellradiusmod));
	newmis.avelocity_y = -100;
	newmis.velocity_z = (newmis.auraV - newmis.origin_z);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = light_matter_rise_think;
};

void() dark_matter_init = {
	traceline(self.origin+'0 0 30', (self.origin-('0 0 600')) , TRUE , self);
	setorigin(self, trace_endpos);
	light_matter_rise();
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.lifetime = 7.00000;
	newmis.splash_time = time + newmis.lifetime;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	//newmis.auraV = trace_endpos_z + (190 - (self.spellradiusmod * 12));
	newmis.auraV = (trace_endpos_z + (128 * self.spellradiusmod));
	traceline (self.origin , (self.origin+('0 0 600')) , TRUE , self);
	setorigin(newmis, trace_endpos);
	newmis.velocity = '0 0 0';
	newmis.auraT = newmis.origin_z;
	newmis.drawflags = MLS_ABSLIGHT;
	AdvanceThinkTime(newmis, 1);
	newmis.think = dark_matter_fall;
};

//		particle2 ( (self.origin + random('-30 -30 -30', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(1, 6), 2, 80.00000);
