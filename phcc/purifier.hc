void (float rich_radius, float duration, float extremity)SilentQuake; // BAER needs to be here, or somewhere before the normal earthquake definitions because that file is too late in the compile..


void  ()purifier_ready;

void  ()pmissile_gone =  {
	sound ( self, CHAN_VOICE, "misc/null.wav", 1, ATTN_NORM);
	sound ( self, CHAN_WEAPON, "misc/null.wav", 1, ATTN_NORM);
	remove ( self);
};


void  ()pmissile_touch =  {
	local float damg = 0;
	if ( (other == self.owner) ) {

		return ;

	}
	if ( (pointcontents ( self.origin) == CONTENT_SKY) ) {

		pmissile_gone ( );
		return ;

	}
	damg = random(15,25);
	if ( other.health ) {

		T_Damage ( other, self, self.owner, damg);

	}
	sound ( self, CHAN_BODY, "weapons/expsmall.wav", 1, ATTN_NORM);
	self.origin = (self.origin - (8 * normalize ( self.velocity)));
	CreateFireCircle ( (self.origin - (v_forward * 8)));
	self.effects = EF_NODRAW;
	self.solid = SOLID_NOT;
	self.nextthink = (time + 0.50000);
	self.think = pmissile_gone;
};


void  ()smokering_run =  
{
	if (self.scale < 2.38)
	self.scale += 0.12000;
	self.nextthink = ((time + HX_FRAME_TIME) + random(HX_FRAME_TIME));
	self.think = smokering_run;
	if ( ((self.lifetime - time) < 0.30000) ) {

		self.skin = 4;
	} else {

		if ( ((self.lifetime - time) < 0.60000) ) {

			self.skin = 3;
		} else {

			if ( ((self.lifetime - time) < 0.90000) ) {

				self.skin = 2;
			} else {

				if ( ((self.lifetime - time) < 1.20000) ) {

					self.skin = 1;
				} else {

					self.skin = 0;

				}

			}

		}

	}
	if ( (self.lifetime < time) ) {

		remove ( self);

	}
};
void() flare_blast;
void() flare_rings;
// BAER. All new code.
void ()GasserThink = 
{
	if (self.classname == "flare") {
		sound (self, CHAN_AUTO, "weapons/r_exp3.wav", 1, ATTN_NORM);
	}

	self.count += 1;
	//      if (self.scale <= 2.3)
	//		self.scale += 0.2;
	//	else
	//	{
	//		self.frame = 0;
	//		setmodel(self, "models/null.spr");
	//	}

	if (self.count >= self.cnt)
	{
		if (self.classname == "flare") {
			flare_blast();
			flare_rings();
		}
 		remove(self);
		return;
	}
	local vector random_vector;

	random_vector_x = random(-50,50);
	random_vector_y = random(-50,50);
	random_vector_z = random(-50,50);

	if (random() > 0.8)
		CreateExplosion29 (self.origin + random_vector);
	else
		CreateFireCircle (self.origin + random_vector);

	if (self.count == (self.cnt - 1)) {
		AdvanceThinkTime(self, 2);
		self.think = GasserThink;
	} else {
		self.nextthink = HX_FRAME_TIME;
		self.think = GasserThink;
	}
};
// End BAER All new code.

void  ()pmissile2_touch =  {
	local float damg = 0;
	if ( (other == self.owner) ) {

		return ;

	}
	if ( (pointcontents ( self.origin) == CONTENT_SKY) ) {

		pmissile_gone ( );
		return ;

	}
	damg = random(150,200);
	if ( other.health ) {

		T_Damage ( other, self, self.owner, damg);

	}
	damg = random(120,160);
	T_RadiusDamage ( self, self.owner, damg, other);
	sound ( self, CHAN_BODY, "weapons/exphuge.wav", 1, ATTN_NORM);
	self.origin = (self.origin - (8 * normalize ( self.velocity)));
	self.effects = EF_NODRAW;
	self.solid = SOLID_NOT;
	//CreateExplosion29 ( (self.origin - (v_forward * 8)));
	// BAER
	local entity gasser;
	local float gasscount;
	gasser = spawn();
	setmodel(gasser, "models/mring.mdl");
	gasser.angles = self.angles;
	gasser.skin = 1;
	gasser.frame = 1;
	gasser.scale = 0.1;
	setorigin(gasser, self.origin - (v_forward * 8));
	gasser.think = GasserThink;
	gasser.effects = EF_BRIGHTLIGHT;
	gasser.nextthink = time + HX_FRAME_TIME;
	gasscount = random(15,20);
	gasser.cnt = gasscount;

	SilentQuake(500, gasscount / 20, 3);
	// End BAER
	self.nextthink = (time + 0.50000);
	self.think = pmissile_gone;
};


void  ()pmissile2_puff =  {
	local entity smokering;

	// BAER
	if (random() > 0.6)
	{
		smokering = spawn ( );
		smokering.owner = self;
		smokering.movetype = MOVETYPE_FLYMISSILE;
		smokering.solid = SOLID_BBOX;
		smokering.classname = "puffring";
		smokering.angles = (self.angles + '0 0 90');
		setmodel ( smokering, "models/ring.mdl");
		setsize ( smokering, '0 0 0', '0 0 0');
		smokering.drawflags |= DRF_TRANSLUCENT;
		smokering.origin = self.origin;
		smokering.velocity_z = 15;
		smokering.nextthink = (time + 0.01000);
		smokering.think = smokering_run;
		smokering.lifetime = (time + 1.20000);
		smokering.drawflags |= SCALE_ORIGIN_CENTER;
		smokering.scale = 1.5;
		smokering.owner = self;
	}
	else
	{
		CreateWhiteSmoke (self.origin, '0 0 6', HX_FRAME_TIME * random(8,12));
	}
	// End BAER
	self.nextthink = (time + HX_FRAME_TIME);
	self.think = pmissile2_puff;
	if ( (time > (self.lifetime - 1.70000)) ) {

		HomeThink ( );
		self.angles = vectoangles ( self.velocity);

	}
	if ( (self.lifetime < time) ) {

		pmissile_gone ( );

	}
};


void  ()launch_pmissile2 =  {
	local entity missile;
	missile = spawn ( );
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.frags = TRUE;
	missile.classname = "purimissile";
	makevectors ( self.v_angle);
	missile.velocity = normalize ( v_forward);
	missile.velocity = (missile.velocity * 1000);
	missile.touch = pmissile2_touch;
	missile.angles = vectoangles ( missile.velocity);
	sound ( self, CHAN_VOICE, "paladin/purfireb.wav", 1, ATTN_NORM);
	setmodel ( missile, "models/drgnball.mdl");
	setsize ( missile, '0 0 0', '0 0 0');
	setorigin ( missile, (((self.origin + (v_forward * 10)) + (v_right * 1)) + (v_up * 40)));
	missile.effects = EF_BRIGHTLIGHT;
	missile.nextthink = time + HX_FRAME_TIME; // BAER changed from .15 to frame rate, 1/20 second.
	missile.think = pmissile2_puff;
	missile.lifetime = (time + 2);
	missile.veer = FALSE;
	missile.turn_time = 3;
	missile.speed = 1000;
	missile.ideal_yaw = TRUE;
	self.greenmana -= 8;
	self.bluemana -= 8;
};


void  ()purifier_tomefire =  {
	self.wfs = advanceweaponframe ( 16, 24);
	self.th_weapon = purifier_tomefire;
	if ( (self.weaponframe == 17) ) {

		self.punchangle_x = -4;
		launch_pmissile2 ( );
		self.attack_finished = (time + 0.50000);
	} else {

		if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

			purifier_ready ( );

		}

	}
};

// BAER all new code
void ()pmissile_update =
{
	particle4 (self.origin, 10.00000, (160 + random(15)), PARTICLETYPE_GRAV, 1.00000);

	particle4 (self.origin, 10.00000, (160 + random(15)), PARTICLETYPE_GRAV, 1.00000);

	particle4 (self.origin, 10.00000, (160 + random(15)), PARTICLETYPE_GRAV, 1.00000);

	if (self.lifetime < time)
	{
		remove(self);
	}
	self.nextthink = time + 0;
	self.think = pmissile_update;
};
// BAER end of new code

void  ()launch_pmissile1 =  
{
	local entity missile;
	
	missile = spawn ( );
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.classname = "purimissile";
	makevectors ( self.v_angle);
	missile.velocity = normalize ( v_forward);
	missile.velocity = (missile.velocity * 1000); 
	missile.touch = pmissile_touch;
	missile.angles = vectoangles ( missile.velocity);
	setmodel ( missile, "models/purfir1.mdl");
	setsize ( missile, '0 0 0', '0 0 0');
	if ( ((self.cnt == 1) || (self.cnt == 3)) ) {

		setorigin ( missile, (((self.origin + self.proj_ofs) + (v_forward * 6)) + (v_right * 10)));
	} else {

		if ( ((self.cnt == 0) || (self.cnt == 2)) ) {


			setorigin ( missile, (((self.origin + self.proj_ofs) + (v_forward * 6)) - (v_right * 10)));

		}

	}


	sound ( self, CHAN_WEAPON, "paladin/purfire.wav", 1, ATTN_NORM);
	self.cnt += 1;
	if ( (self.cnt > 3) ) 
	{

		self.cnt = 0;

	}
	missile.drawflags = MLS_ABSLIGHT;
	missile.abslight = 1;
	missile.nextthink = time + 0;
	missile.think = pmissile_update;
	missile.lifetime = time + 2.5;
	self.greenmana -= 1;
	self.bluemana -= 1;
};


void  ()purifier_rapidfire2R =  {
	self.wfs = advanceweaponframe ( 10, 12);
	self.th_weapon = purifier_rapidfire2R;
	if ( (self.weaponframe == 12) ) {

		self.punchangle_x = random(-3);

	}
	if ( ((self.attack_finished <= time) && self.button0) ) {

		launch_pmissile1 ( );

	}
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		purifier_ready ( );

	}
};


void  ()purifier_rapidfire2L =  {
	self.wfs = advanceweaponframe ( 7, 9);
	self.th_weapon = purifier_rapidfire2L;
	if ( (self.weaponframe == 3) ) {

		self.punchangle_x = random(-3);

	}
	if ( ((self.attack_finished <= time) && self.button0) ) {

		launch_pmissile1 ( );

	}
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		purifier_ready ( );

	}
};


void  ()purifier_rapidfire1R =  {
	self.wfs = advanceweaponframe ( 4, 6);
	self.th_weapon = purifier_rapidfire1R;
	if ( (self.weaponframe == 6) ) {

		self.punchangle_x = random(-3);

	}
	if ( ((self.attack_finished <= time) && self.button0) ) {

		launch_pmissile1 ( );

	}
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		purifier_ready ( );

	}
};


void  ()purifier_rapidfire1L =  {
	self.wfs = advanceweaponframe ( 1, 3);
	self.th_weapon = purifier_rapidfire1L;
	if ( (self.weaponframe == 3) ) {

		self.punchangle_x = random(-3);

	}
	if ( ((self.attack_finished <= time) && self.button0) ) {

		launch_pmissile1 ( );

	}
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		purifier_ready ( );

	}
};


void  ()purifier_rapidfire =  {
	if ( (self.counter == 0) ) {

		purifier_rapidfire1L ( );
	} else {

		if ( (self.counter == 1) ) {

			purifier_rapidfire1R ( );
		} else {

			if ( (self.counter == 2) ) {

				purifier_rapidfire2L ( );
			} else {

				if ( (self.counter == 3) ) {

					purifier_rapidfire2R ( );

				}

			}

		}

	}
	self.counter += 1;
	self.attack_finished = (time + 0.14000);
	if ( (self.counter > 3) ) {

		self.counter = 0;

	}
};


void  ()pal_purifier_fire =  {
	if ( (((self.artifact_active & ART_TOMEOFPOWER) && (self.greenmana >= 8)) && (self.bluemana >= 8)) ) {

		purifier_tomefire ( );
	} else {

		if ( ((self.greenmana >= 2) && (self.bluemana >= 2)) ) {

			purifier_rapidfire ( );

		}

	}
	self.nextthink = time;
};


void  ()purifier_ready =  {
	self.weaponframe = 0;
	self.wfs = 0;
	self.th_weapon = purifier_ready;
};


void  ()purifier_deselect =  {
	self.wfs = advanceweaponframe ( 36, 25);
	self.th_weapon = purifier_deselect;
	self.oldweapon = IT_WEAPON4;
	if ( (self.wfs == WF_LAST_FRAME) ) {

		W_SetCurrentAmmo ( );

	}
};


void  ()purifier_select =  {
	self.wfs = advanceweaponframe ( 25, 36);
	self.weaponmodel = "models/purifier.mdl";
	self.th_weapon = purifier_select;
	self.counter = 0;
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		self.attack_finished = (time - 1);
		purifier_ready ( );

	}
};

