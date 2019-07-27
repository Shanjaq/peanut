void  ()LightningStrike =  {
	sound ( self, CHAN_WEAPON, "crusader/sunhum.wav", 1.00000, ATTN_NORM);
	self.effects |= EF_BRIGHTLIGHT;
	
	self.dest2 = (self.origin + random('-256 -256 1024', '256 256 1024'));
	traceline(self.origin, self.dest2, TRUE, self);
	
	//shan lightning effect
	WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte ( MSG_BROADCAST, TE_STREAM_LIGHTNING);
	WriteEntity ( MSG_BROADCAST, self);
	WriteByte ( MSG_BROADCAST, 1);
	WriteByte ( MSG_BROADCAST, 3);
	WriteCoord ( MSG_BROADCAST, self.origin_x);
	WriteCoord ( MSG_BROADCAST, self.origin_y);
	WriteCoord ( MSG_BROADCAST, self.origin_z);
	WriteCoord ( MSG_BROADCAST, trace_endpos_x);
	WriteCoord ( MSG_BROADCAST, trace_endpos_y);
	WriteCoord ( MSG_BROADCAST, trace_endpos_z);
	//shan lightning effect end
	
};





void  ()TouchRing4 =  {
	if ((other == self.owner) || (other.movetype == MOVETYPE_FLYMISSILE) || (other.movetype == MOVETYPE_BOUNCEMISSILE)) {
		return;
	}
	if ((other.thingtype == THINGTYPE_GREYSTONE) || (other.thingtype == THINGTYPE_CLAY) || (other.thingtype == THINGTYPE_BROWNSTONE)) {
		centerprint(self.owner, "Stone is not a conductive material!");
		remove(self);
	} else {
		// local entity head;
		//   head = findradius ( self.origin, 500.00000);
		//   while ( head ) {
		//
		//      if ( (head.owner == self) ) {

		//   head.think = SUB_Null;


		//      }
		//      head = head.chain;

		//   }
		if ( other.takedamage ) {

			self.dmg = (self.spelldamage*0.75000) + random(self.spelldamage*(-0.50000), self.spelldamage*0.50000);
			if (other.status_effects & STATUS_WET)
				self.dmg *= 3.62500;

			T_Damage ( other, self, self.owner, self.dmg);


			WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte ( MSG_BROADCAST, TE_EXPLOSION);
			WriteCoord ( MSG_BROADCAST, self.origin_x);
			WriteCoord ( MSG_BROADCAST, self.origin_y);
			WriteCoord ( MSG_BROADCAST, self.origin_z);
			LightningStrike();
		}
		remove(self);
	}
};


void  ()yellowM1B =  {
	local entity targ;
	local float rnd, i;
	if (time < self.splash_time) {
		particle2 ( (self.origin + random('-60 -60 -30', '60 60 30')), '-30.00000 -30.00000 490.00000', '30.00000 30.00000 -490.00000', random(168, 175), 0, 1.00000);
		particle2 ( (self.origin + random('-60 -60 -30', '60 60 30')), '-30.00000 -30.00000 490.00000', '30.00000 30.00000 -490.00000', random(168, 175), 0, 1.00000);

		if (random() < 0.12500) {
			self.effects = (self.effects | EF_MUZZLEFLASH);
			self.velocity += random('-16 -16 -8', '16 16 8');
			
			targ = findNearestHurtable(self.origin, (96.00000*self.spellradiusmod), 1, 0, TRUE);
			
			if (targ != world)
			{
				self.dmg = (self.spelldamage*0.75000) + random(self.spelldamage*(-0.50000), self.spelldamage*0.50000);
				if (targ.status_effects & STATUS_WET)
					self.dmg *= 3.62500;
				
				do_lightning ( self, 3, STREAM_ATTACHED, 0.50000, self.origin, ((targ.absmin + targ.absmax) * 0.50000), self.dmg);
			}
			else
			{
				rnd = floor(random(self.count));
				targ = self;
				i = 0.00000;
				while (i < rnd)
				{
					targ = targ.goalentity;
					i += 1;
				}
				
				if (targ != self)
				{
					//shan lightning effect
					WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
					WriteByte ( MSG_BROADCAST, TE_STREAM_LIGHTNING);
					WriteEntity ( MSG_BROADCAST, targ);
					WriteByte ( MSG_BROADCAST, (6 + STREAM_ATTACHED));
					WriteByte ( MSG_BROADCAST, 0.50000);
					WriteCoord ( MSG_BROADCAST, targ.origin_x);
					WriteCoord ( MSG_BROADCAST, targ.origin_y);
					WriteCoord ( MSG_BROADCAST, targ.origin_z);
					WriteCoord ( MSG_BROADCAST, self.origin_x);
					WriteCoord ( MSG_BROADCAST, self.origin_y);
					WriteCoord ( MSG_BROADCAST, self.origin_z);
					//shan lightning effect end
				}
				
				if (random() < 0.5)
					sound ( self, CHAN_WEAPON, "rw11lici.wav", 1.00000, ATTN_NORM);
				else
					sound ( self, CHAN_WEAPON, "rw11thuf.wav", 1.00000, ATTN_NORM);
			}
		}
		
		self.think = yellowM1B;
		AdvanceThinkTime(self, random(0.1, 0.3));
	} else {
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};


void  ()obj_yellowM1 =  {
	local float num_shots, total_shots;
	local entity firstmissile, missile, lastmissile;

	total_shots = floor(random(4, 6));
	num_shots = total_shots;


	while (num_shots > 0) {
		local vector org = '0.00000 0.00000 0.00000';
		makevectors(self.angles);


		org = (self.origin + '0.00000 0.00000 30.00000');
		missile = spawn ( );
		missile.spelldamage = self.spelldamage;
		missile.spellradiusmod = self.spellradiusmod;
		missile.owner = self.owner;
		
		missile.movetype = MOVETYPE_FLYMISSILE;
		missile.solid = SOLID_TRIGGER;
		missile.angles = vectoangles ( VEC_ORIGIN);
		missile.avelocity = RandomVector('360 360 360');
		missile.classname = "SpikeRing2";
		setmodel ( missile, "models/glowball.mdl");
		//setsize ( missile, '-3 -3 -10', '3 3 20');
		setsize ( missile, '0 0 0', '0 0 0');
		//traceline ((self.origin + '0 0 30') , (self.origin+(v_forward * 50)) , FALSE , self);


		setorigin (missile, self.origin);
		missile.velocity = (v_forward * 196);
		missile.velocity += random((v_right * 125), (v_right * -125));
		missile.velocity += random((v_up * 10), (v_up * -10));
		self.punchangle_x = CONTENT_SOLID;
		
		missile.count = total_shots;
		missile.lifetime = 1.62500;
		missile.splash_time = (time + missile.lifetime);
		
		if (lastmissile != world)
			lastmissile.goalentity = missile;
		else
			firstmissile = missile;

		missile.touch = TouchRing4;
		missile.think = yellowM1B;
		AdvanceThinkTime(missile, random(0.03625, 0.10000));

		lastmissile = missile;
		num_shots -= 1; 
	}
	
	lastmissile.goalentity = firstmissile;
};


