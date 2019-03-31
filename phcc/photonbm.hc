
void  ()photon_splash_think =  {
	if ( (self.scale == 0.05000) ) {

		pitch_roll_for_slope (VEC_ORIGIN);
		if ( ((self.angles_x != 0.00000) || (self.angles_z != 0.00000)) ) {

			self.avelocity_y = 0.00000;

		}

	}
	
	self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * (2.00000 * self.spellradiusmod));
	
	if ( (self.splash_time - time) < (self.lifetime / 2.00000) ) {

		self.origin_z -= 2.00000;

	}
	
	if ( (self.splash_time - time) < (self.lifetime * 0.100000) )
	{
		remove ( self);
	}
	else
	{
		self.think = photon_splash_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};


void  (vector a)photon_splash =  {
	newmis = spawn ( );
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.solid = SOLID_NOT;
	//   newmis.skin = 0;
	newmis.skin = 1;
	newmis.scale = 0.05000;
	newmis.frame = 1;
	//   setorigin ( newmis, (a + random('-40.00000 -40.00000 30.00000','40.00000 40.00000 30.00000')));
	setorigin ( newmis, a);
	traceline ( newmis.origin, (newmis.origin - '0.00000 0.00000 60.00000'), FALSE, self);
	setorigin ( newmis, trace_endpos);
	newmis.avelocity_y = MAX_HEALTH;
	setmodel ( newmis, "models/suck.mdl");
	newmis.effects = EF_BRIGHTLIGHT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.50000;
	newmis.lifetime = 0.50000;
	newmis.splash_time = (time + newmis.lifetime);
	AdvanceThinkTime(newmis,HX_FRAME_TIME);
	newmis.think = photon_splash_think;
};


void  ()photon_beam_think =  {
	if ( (self.cnt < 95.00000) ) {

		self.cnt += TRUE;
		photon_splash ( self.dest);
		self.wisdom = (vlen ( (self.dest - self.origin)) / MLS_CRYSTALGOLEM);
		if ( (self.jones.origin_z > self.dest_z) ) {
			setorigin ( self.jones, (self.jones.origin + (normalize ( (self.dest - self.origin)) * self.wisdom)));
		} else {
			setorigin ( self.jones, self.origin);
		}
		
		T_RadiusDamageFlat (self.jones, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.50000, 164.00000 * self.spellradiusmod, self.owner, FALSE);
		
		AdvanceThinkTime(self,HX_FRAME_TIME);
		self.think = photon_beam_think;
	} else {

		if (self.cnt == 95) {
			if (self.jones != world)
			{
				AdvanceThinkTime(self.jones,0.02000);
				self.jones.think = SUB_Remove;
				remove ( self.jones);
			}
		}
		if ( (self.abslight > 1.10000) ) {

			if (self.skin == 4) {
				self.scale -= 0.02;
			}
			self.abslight -= 0.01000;
			AdvanceThinkTime(self,0.04000);
			self.think = photon_beam_think;
		} else {

			remove ( self);

		}

	}
};


void  (entity targ)photon_hurter =  {
	newmis = spawn ( );
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin ( newmis, self.origin);
	targ.jones = newmis;
};


void  ()photon_beam =  {
	newmis = spawn ( );
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.skin = MLS_CRYSTALGOLEM;
	newmis.scale = 1.50000;
	setorigin ( newmis, self.origin);
	newmis.dest = self.dest2;
	newmis.angles = vectoangles ( (self.origin - newmis.dest));
	newmis.avelocity_z = MAX_HEALTH;
	setmodel ( newmis, "models/tail.mdl");
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.50000;
	AdvanceThinkTime(newmis,0.10000);
	newmis.think = photon_beam_think;
	remove ( self);
	photon_hurter ( newmis);
};


void  ()photon_ball_think =  {
	local vector pull = '0.00000 0.00000 0.00000';
	local float pull_speed = 0.00000;
	pull = (self.origin - self.dest);
	if ( (vlen ( (self.dest - self.origin)) < 1000.00000) ) {

		pull_speed = FL_SWIM;

	}
	if ( (vlen ( (self.dest - self.origin)) < 700.00000) ) {

		pull_speed = TRUE;

	}
	if ( (vlen ( (self.dest - self.origin)) < 500.00000) ) {

		pull_speed = 0.50000;

	}
	normalize ( pull);
	pull_x *= pull_speed;
	self.velocity -= pull;
	if ( (vlen ( (self.dest - self.origin)) < 300.00000) ) {

		self.velocity = VEC_ORIGIN;
		setorigin ( self, (self.origin + (normalize ( (self.dest - self.origin)) * HX_FPS)));
		if ( (vlen ( (self.dest - self.origin)) < PARTICLETYPE_SPELL) ) {

			AdvanceThinkTime(self,0.02000);
			self.think = photon_beam;
		} else {

			AdvanceThinkTime(self,0.06000);
			self.think = photon_ball_think;

		}
	} else {

		AdvanceThinkTime(self,0.06000);
		self.think = photon_ball_think;

	}
	particle2 ( (self.origin + random('-30.00000 -30.00000 -30.00000','30.00000 30.00000 30.00000')), '-200.00000 -200.00000 -20.00000', '200.00000 200.00000 200.00000', 255.00000, 0.00000, 80.00000);
};


void  ()photon_ball =  {
	self.magic_finished = (time + MLS_CRYSTALGOLEM);
	newmis = spawn ( );
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.owner = self.owner;
	newmis.skin = TRUE;
	makevectors ( self.angles);
	traceline ( self.origin, (self.origin - '0.00000 0.00000 800.00000'), TRUE, newmis);
	setorigin ( newmis, trace_endpos);
	traceline ( newmis.origin, (newmis.origin + '0.00000 0.00000 500.00000'), TRUE, newmis);
	newmis.dest = trace_endpos;
	traceline ( newmis.dest, (newmis.dest + '0.00000 200.00000 0.00000'), TRUE, newmis);
	newmis.dest = random(newmis.dest,trace_endpos);
	traceline ( newmis.dest, (newmis.dest - '0.00000 200.00000 0.00000'), TRUE, newmis);
	newmis.dest = random(newmis.dest,trace_endpos);
	traceline ( newmis.dest, (newmis.dest + '200.00000 0.00000 0.00000'), TRUE, newmis);
	newmis.dest = random(newmis.dest,trace_endpos);
	traceline ( newmis.dest, (newmis.dest - '200.00000 0.00000 0.00000'), TRUE, newmis);
	newmis.dest = random(newmis.dest,trace_endpos);
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = FL_SWIM;
	newmis.avelocity = random('-400.00000 -400.00000 -400.00000','400.00000 400.00000 400.00000');
	newmis.scale = 2.50000;
	newmis.dest2 = newmis.origin;
	sound ( newmis, CHAN_AUTO, "beamhit4.wav", TRUE, ATTN_NORM);
	sound ( newmis, CHAN_AUTO, "beamhit4.wav", TRUE, ATTN_NORM);
	newmis.velocity = random('-300.00000 -300.00000 -500.00000','300.00000 300.00000 0.00000');
	setmodel ( newmis, "models/star2.mdl");
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = photon_ball_think;
};

