void() toxic_cloud_contamination_think =
{
	local float pc;
	local entity splode;
	
	pc = pointcontents (self.oldenemy.origin);
	if (pc == CONTENT_WATER)
	{
		self.oldenemy.status_effects ^= STATUS_POISON;
		setorigin(self, self.oldenemy.origin);
		sound (self, CHAN_WEAPON, "misc/fout.wav", 1, ATTN_NORM);
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
		return;
	}
	
	if (time < self.splash_time)
	{
		self.dest = random(self.oldenemy.absmin, self.oldenemy.absmax);
		particle2 ( self.dest, '-20.00000 -20.00000 -20.00000', '20.00000 20.00000 64.00000', random(185, 191), PARTICLETYPE_FASTGRAV, random(8, 24));
		if (time > self.attack_finished)
		{
			self.attack_finished = time + 0.75000;
			self.dmg = (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
			
			if ((self.oldenemy.health > self.dmg) && (self.oldenemy.origin != VEC_ORIGIN)) //alive and not removed
			{
				if (random() < 0.12500)
					sound ( self.oldenemy, CHAN_AUTO, "crusader/sunhit.wav", 1.00000, ATTN_NORM);
				
				setorigin(self, self.oldenemy.origin);
				T_Damage ( self.oldenemy, self, self.owner, self.dmg );
			}
			else
			{
				if (self.oldenemy.status_effects & STATUS_POISON)
					self.oldenemy.status_effects ^= STATUS_POISON;
				
				if (self.oldenemy.origin != VEC_ORIGIN)
				{
					
					if (self.oldenemy.deadflag == DEAD_DEAD)
					{
						self.oldenemy.th_die = SUB_Remove;
						//self.oldenemy.think = SUB_NullDeath;
						self.oldenemy.think = SUB_Remove;
						AdvanceThinkTime(self.oldenemy, HX_FRAME_TIME);
						
						splode = spawn();
						splode.effects = (EF_NODRAW | EF_DARKLIGHT);
						//setmodel ( splode, "models/i_gmana.mdl");
						setmodel ( splode, "models/psbg.spr");
						splode.step4 = 9999;  //green gibs
						splode.thingtype = THINGTYPE_FLESH;
						setsize(splode, self.oldenemy.mins * 2.25000, self.oldenemy.maxs * 2.25000);
						setorigin(splode, self.origin + '0 0 5');
						splode.think = chunk_death;
						sound ( splode, CHAN_VOICE, "player/megagib.wav", 1.00000, ATTN_NORM);
						sound ( splode, CHAN_VOICE, "player/megagib.wav", 1.00000, ATTN_NORM);
						particle2 ( splode.origin, '-128.00000 -128.00000 30.00000', '128.00000 128.00000 300.00000', random(185, 191), PARTICLETYPE_FASTGRAV, random(128, 196));
						
						WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
						WriteByte ( MSG_BROADCAST, TE_LIGHT_PULSE);
						WriteEntity ( MSG_BROADCAST, splode);
						
						AdvanceThinkTime(splode, 0.25);
						T_RadiusDamageFlat (self.oldenemy, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500)) * random(7, 10), 128.00000*self.spellradiusmod, self.owner, FALSE);
					}
					else
					{
						if (self.oldenemy.flags2 & FL_ALIVE)
							T_Damage ( self.oldenemy, self, self.owner, self.dmg );
					}
				}
				
				self.think = SUB_Remove;
				AdvanceThinkTime(self, HX_FRAME_TIME);
				return;
			}
		}
		
		self.think = toxic_cloud_contamination_think;
		AdvanceThinkTime(self, 0.12500);
	}
	else
	{
		self.oldenemy.status_effects ^= STATUS_POISON;
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}

};

void() toxic_cloud_part_think =
{
	local vector pos;
	local float rnd;
	if (time < self.splash_time)
	{
		if (self.frame >= 7)
			self.frame = 3;
		else
			self.frame += 1;
		
		pos = self.origin + random('-64 -64 0', '64 64 0');
		//particle2 ( (self.origin + random('-64 -64 -24', '64 64 8')), '-30.00000 -30.00000 -96.00000', '30.00000 30.00000 -128.00000', random(185, 191), 0, 1.00000);
		traceline ((pos+'0 0 20') , (pos-('0 0 600')) , TRUE , self);
		
		if ((trace_fraction < 1.00000) && !trace_allsolid)
		{
			particle2 ( (trace_endpos + random('-64 -64 -24', '64 64 8')), '-30.00000 30.00000 -96.00000', '30.00000 30.00000 128.00000', random(185, 191), 0, 1.00000);
			if (random() < 0.08)
			{
				slime_drop(trace_endpos);
				if (trace_ent.takedamage & DAMAGE_YES)
					T_Damage ( trace_ent, self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500)) );
				
				rnd = random();
				if (rnd < 0.16)
					sound ( self, CHAN_AUTO, "slime1.wav", 1.00000, ATTN_NORM);
				else if (rnd < 0.32)
					sound ( self, CHAN_AUTO, "slime2.wav", 1.00000, ATTN_NORM);
				else if (rnd < 0.48)
					sound ( self, CHAN_AUTO, "slime3.wav", 1.00000, ATTN_NORM);
				else if (rnd < 0.64)
					sound ( self, CHAN_AUTO, "slime4.wav", 1.00000, ATTN_NORM);
				else if (rnd < 0.80)
					sound ( self, CHAN_AUTO, "slime5.wav", 1.00000, ATTN_NORM);
				else
					sound ( self, CHAN_AUTO, "slime6.wav", 1.00000, ATTN_NORM);
			}
		}
		self.think = toxic_cloud_part_think;
		AdvanceThinkTime(self, random(0.16, 0.23));
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void(vector org) toxic_cloud_part = 
{
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.ltime = time;
	newmis.owner = self.owner;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.velocity = '0 0 0';
	//newmis.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	newmis.thingtype = THINGTYPE_FLESH;
	newmis.drawflags |= DRF_TRANSLUCENT;
	setmodel ( newmis, "models/psbg.spr");
	setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( newmis, org);
	sound ( newmis, CHAN_VOICE, "fizzloop.wav", 1.00000, ATTN_NORM);
	newmis.velocity = random('-12 -12 -3', '12 12 3');
	newmis.lifetime = random(6, 9);
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = toxic_cloud_part_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};

void() toxic_cloud_think =
{
	local float i;
	local vector pos;
	if (time < self.splash_time)
	{
		pos = (self.origin + random('-128 -128 -36', '128 128 36') * self.spellradiusmod);
		
		i = 0;
		while ((pointcontents(pos) != CONTENT_EMPTY) && (i < 4))
		{
			pos = (self.origin + random('-128 -128 -36', '128 128 36') * self.spellradiusmod);
			i += 1;
		}
		
		if (i < 4)
		{
				
			toxic_cloud_part(pos);

			self.think = toxic_cloud_think;
			AdvanceThinkTime(self, (random(0.22, 0.41) / self.spellradiusmod));
		}
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void() toxic_cloud =
{
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.lifetime = 10.00000;
	newmis.splash_time = (time + newmis.lifetime);
	traceline ((self.origin+'0 0 20') , (self.origin-('0 0 600')) , TRUE , self);
	setorigin(newmis, trace_endpos + '0 0 64');
	setmodel(newmis, "models/null.spr");
	
	newmis.think = toxic_cloud_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};