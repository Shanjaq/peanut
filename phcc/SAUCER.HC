void(float power_value) charge;
void() charge_idle;
void  (entity loser)Polymorph;
void() fireballTouch;

void ()UFOThink = 
{
	if (self.UFO == 1) {
		if (self.cnt>0) 
		{       
			self.skin = 4;
			self.cnt = (self.cnt - 1);
			self.velocity = ('0 0 80');
			self.think = UFOThink;
			self.nextthink = (time + 0.1);
		} 
		else 
		{
			// self.velocity = ('0 0 0');
			// self.angles = vectoangles(self.velocity);
			if (self.skin > 2) {
				self.skin = 0;
			} else {
				self.effects = EF_DIMLIGHT;
				self.skin = (self.skin + 1);
			}
			self.think = UFOThink;
			self.nextthink = (time + 0.1);
		}
	}
	else 
	{
		// self.velocity = ('0 0 0');
		// self.angles = vectoangles(self.velocity);
		self.think = SUB_Null;
		self.nextthink = (time + 0.1);
	}

};

void  ()splashz = {
	if (self.frame>4) {
		self.think = SUB_Remove;
		self.nextthink = (time + 0);
		return;
	} else {
		self.frame = (self.frame + 1);
		self.think = splashz;
		self.nextthink = (time + 0.08);
	}
};
void  ()splashy = {
	local entity splash;

	splash = spawn();
	setorigin (splash, self.origin);
	splash.solid = SOLID_NOT;
	splash.drawflags = MLS_ABSLIGHT;
	splash.effects = EF_DIMLIGHT;
	setmodel (splash, "models/splashy.mdl");
	splash.abslight = 0.5;
	splash.owner = self.owner;
	splash.scale = self.cscale;
	splash.skin = self.cskin;
	splash.frame = 0;
	splash.angles = (self.angles);
	splash.think = splashz;
	splash.nextthink = (time + 0.02);
	if (self.auraV == 1) {
		self.cskin = 5;
	}
	if (self.cskin == 0) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 140.00000, 2, 80.00000);
		sound ( splash, CHAN_VOICE, "chit1.wav", 1.00000, ATTN_NORM);
	}

	if (self.cskin == 1) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 174.00000, 2, 80.00000);
		sound ( splash, CHAN_VOICE, "chit1.wav", 1.00000, ATTN_NORM);
	}

	if (self.cskin == 2) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 245.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 245.00000, 2, 80.00000);
		sound ( splash, CHAN_VOICE, "chit2.wav", 1.00000, ATTN_NORM);
	}

	if (self.cskin == 3) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 248.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 250.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 249.00000, 2, 80.00000);
		sound ( splash, CHAN_VOICE, "chit2.wav", 1.00000, ATTN_NORM);
	}

	if (self.cskin == 4) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 241.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 242.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 240.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 241.00000, 1, 80.00000);
		sound ( splash, CHAN_VOICE, "chit2.wav", 1.00000, ATTN_NORM);
	}

	if (self.cskin == 5) {
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(112, 127), 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(168, 175), 2, 80.00000);
		sound ( splash, CHAN_VOICE, "golem/stomp.wav", 1.00000, ATTN_NORM);
	}


	remove(self);
};

void  ()charge_touch =  {
	if ( (((other == world) || (other.solid == SOLID_BSP)) || (other.mass > 300.00000)) ) {
		splashy();
		//      DarkExplosion ( );
	} else {

		if ( (other != self.enemy) ) {

			if ( other.takedamage ) {

				self.enemy = other;
				makevectors ( self.velocity);
				T_Damage ( other, self, self.owner, self.dmg);
				if ( (self.dmg < 10.00000) ) {

					T_Damage ( other, self, self.owner, 10.00000);
					splashy();         
					//DarkExplosion ( );
				} else {

					SpawnPuff ( self.origin, self.velocity, 10.00000, other);
					SpawnPuff ( (self.origin + (v_forward * 36.00000)), self.velocity, 10.00000, other);
					if ( (other.thingtype == THINGTYPE_FLESH) ) {

						sound ( self, CHAN_VOICE, "assassin/core.wav", 1.00000, ATTN_NORM);
						MeatChunks ( (self.origin + (v_forward * 36.00000)), (((self.velocity * 0.20000) + (v_right * random(-30.00000,150.00000))) + (v_up * random(-30.00000,150.00000))), 5.00000, other);

					}
					if ( (other.classname == "player") ) {

						T_Damage ( other, self, self.owner, ((self.dmg + (self.frags * 10.00000)) / 3.00000));
					} else {

						T_Damage ( other, self, self.owner, (self.dmg + (self.frags * 10.00000)));

					}
					self.frags += 1.00000;
					self.dmg -= 10.00000;

				}

			}

		}

	}
};







void  ()charge_think =  {
	if (self.cnt > 50) {
		remove(self);
	} else {
		self.cnt += 1;
	}
	if ( (self.frame < 7.00000) ) {

		self.frame += 1.00000;

	}
	if ( (self.pain_finished <= time) ) {

		self.pain_finished = (time + 1.00000);
		sound ( self, CHAN_BODY, "assassin/spin.wav", 1.00000, ATTN_NORM);

	}
	//   if ( ((self.lifetime < time) || (self.flags & FL_ONGROUND)) ) {

	//DarkExplosion ( );
	//  } else {

	if ( (self.velocity != (self.movedir * self.speed)) ) {

		self.velocity = (self.movedir * self.speed);

	}
	if (self.skin == 0) {
		particle4 (self.origin, 10.00000, (128 + random(15)), PARTICLETYPE_GRAV, 3.00000);

	}

	if (self.skin == 1) {
		particle4 (self.origin, 20.00000, (160 + random(15)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 20.00000, (160 + random(15)), PARTICLETYPE_GRAV, 3.00000);

	}

	if (self.skin == 2) {
		particle4 (self.origin, 30.00000, (243 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 30.00000, (243 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 30.00000, (243 + random(3)), PARTICLETYPE_GRAV, 3.00000);

	}

	if (self.skin == 3) {
		particle4 (self.origin, 40.00000, (247 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (247 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (247 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (247 + random(3)), PARTICLETYPE_GRAV, 3.00000);

	}

	if (self.skin == 4) {
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);

	}

	if (self.ions == 15) {
		T_RadiusDamage ( self, world, 150, self.owner);
		particle4 (self.origin, 40.00000, (239 + random(3)), PARTICLETYPE_GRAV, 3.00000);

	}
	self.think = charge_think;
	AdvanceThinkTime(self,0.10000);

	//   }
};


void  (float power_value)charge =  {

	if (power_value<4) {
		self.cskin = 0;
		self.cscale = 0.5;
	}
	if ((power_value<7) && (power_value>3)) {
		self.cskin = 1;
		self.cscale = 1;
	}
	if ((power_value<10) && (power_value>6)) {
		self.cskin = 2;
		self.cscale = 1.5;
	}
	if ((power_value<13) && (power_value>9)) {
		self.cskin = 3;
		self.cscale = 2;
	}
	if (power_value>12) {
		self.cskin = 4;
		self.cscale = 2.5;
	}


	if (self.cscale<1.5) {
		sound (self, CHAN_WEAPON, "stml.wav", 1, ATTN_NORM);
	} 
	if ((self.cscale<2.6) && (self.cscale>1)) {
		sound (self, CHAN_WEAPON, "supnova.wav", 1, ATTN_NORM);
	}
	if (self.ions>14) {
		sound (self, CHAN_WEAPON, "stme.wav", 1, ATTN_NORM);
	}
	makevectors ( self.v_angle);
	self.punchangle_x = (power_value * -1.00000);
	self.effects |= EF_MUZZLEFLASH;
	newmis = spawn ( );
	newmis.enemy = world;
	newmis.owner = self;
	if (self.ions>14) {
		newmis.ions = 15;
	}
	newmis.classname = "pincer";
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_PHASE;
	newmis.thingtype = 1.00000;
	if (self.ions<15) {
		newmis.touch = charge_touch;
	} else {
		newmis.touch = ChargeBlast;
	}
	newmis.dmg = (power_value * 15.00000);
	if ( (newmis.dmg < 15.00000) ) {

		newmis.dmg = 15.00000;

	}
	newmis.th_die = DarkExplosion;
	newmis.drawflags = MLS_ABSLIGHT;
	newmis.abslight = 1.50000;
	newmis.avelocity_z = random(300, 600);
	// newmis.scale = 2.00000;
	newmis.speed = (750.00000 + (30.00000 * power_value));
	newmis.movedir = v_forward;
	newmis.velocity = (newmis.movedir * newmis.speed);
	newmis.angles = vectoangles ( newmis.velocity);
	if (self.ions>14) {
		setmodel (newmis, "models/tail.mdl");
	} else {
		setmodel ( newmis, "models/fragm2.mdl");
	}
	newmis.skin = self.cskin;
	newmis.scale = self.cscale;
	newmis.cskin = self.cskin;
	newmis.cscale = self.cscale;
	setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( newmis, (((self.origin + '0 0 -20') + self.proj_ofs) + (v_forward * 8.00000)));
	// self.attack_finished = (time + 0.25 + (power_value / 10));
	newmis.lifetime = (time + 7.00000);
	newmis.think = charge_think;
	AdvanceThinkTime(newmis,0.00000);
};


void  ()charge_powerfire =  {
	self.wfs = advanceweaponframe ( 25.00000, 31.00000);
	self.th_weapon = charge_powerfire;
	if ( (self.weaponframe == 26.00000) ) {

		TheOldBallAndChain ( );
		//    self.greenmana -= 30.00000;
		//    self.bluemana -= 30.00000;

	}
	if ( (self.wfs == WF_CYCLE_WRAPPED) ) {

		charge_idle ( );

	}
};


void  ()charge_settle =  {
	self.wfs = advanceweaponframe ( 15.00000, 23.00000);
	self.th_weapon = charge_settle;
	if ( (self.wfs == WF_LAST_FRAME) ) {

		charge_idle ( );

	}
};


void  ()charge_readyfire =  {

	if (self.cations > 99) {
		self.cations = 100;
	} else {
		self.cations = (self.cations + 1);
	}
	if ( (self.ions > 14.00000) ) {

		self.ions = 15.00000;

	}
	if ( (self.ions == 0.00000) ) {

		sound ( self, CHAN_WEAPON, "assassin/build.wav", 1.00000, ATTN_NORM);

		self.ions = 1;

	}
	if ( ((self.ions >= 0.00000) && (self.ions < 15.00000)) ) {
		if (self.cations == 6) {
			self.ions += 1.00000;
		}
		if (self.cations == 12) {
			self.ions += 1.00000;
		}
		if (self.cations == 18) {
			self.ions += 1.00000;
		}
		if (self.cations == 24) {
			self.ions += 1.00000;
		}
		if (self.cations == 30) {
			self.ions += 1.00000;
		}
		if (self.cations == 36) {
			self.ions += 1.00000;
		}
		if (self.cations == 42) {
			self.ions += 1.00000;
		}
		if (self.cations == 48) {
			self.ions += 1.00000;
		}
		if (self.cations == 54) {
			self.ions += 1.00000;
		}
		if (self.cations == 60) {
			self.ions += 1.00000;
		}
		if (self.cations == 68) {
			self.ions += 1.00000;
		}
		if (self.cations == 76) {
			self.ions += 1.00000;
		}
		if (self.cations == 84) {
			self.ions += 1.00000;
		}
		if (self.cations == 92) {
			self.ions += 1.00000;
			sound ( self, CHAN_WEAPON, "full.wav", 1.00000, ATTN_NORM);
		}
		if (self.cations == 99) {
			self.ions += 1.00000;

		}



	}

	if ((self.click == 0) && (self.ions>0)) {
		charge(self.ions);
		self.ions = 0;
		self.cations = 0;
	}

	// if ((self.click == 0) && (self.ions>14)) {
	// charge_powerfire();
	// self.ions = 0;
	// self.cations = 0;
	// }

	if (self.click == 1) {
		self.think = charge_readyfire;
		self.nextthink = (time + 0.1000);
	}


	if ((self.click == 0) && (self.ions == 0)) {
		self.think = UFOThink;
		self.nextthink = (time + 0.1);
	}
};



void  ()charge_idle =  {
	self.weaponframe = 24.00000;
	self.th_weapon = charge_idle;
};











void() UFOFire =
{


	if (newmis.owner.level == 1) {
		newmis.owner.drip = 0;
		newmis.owner.drop = 0.7;
	}
	if (newmis.owner.level == 2) {
		newmis.owner.drip = 1;
		newmis.owner.drop = 0.6;
	}
	if (newmis.owner.level == 3) {
		newmis.owner.drip = 2;
		newmis.owner.drop = 0.5;
	}
	if (newmis.owner.level == 4) {
		newmis.owner.drip = 3;
		newmis.owner.drop = 0.4;
	}
	if (newmis.owner.level > 4) {
		newmis.owner.drip = 4;
		newmis.owner.drop = 0.3;
	}

	newmis = spawn();
	newmis.cnt = 90;
	newmis.solid = SOLID_BBOX;
	newmis.origin = (((self.origin + '0 0 -5') + self.proj_ofs) + (v_forward * 6)); 
	newmis.drawflags = MLS_ABSLIGHT;
	setmodel ( newmis, "models/fragm1.mdl");
	newmis.abslight = 0.5;
	setsize ( newmis, '-6 -6 -6', '6 6 6');
	newmis.hull = HULL_POINT;
	newmis.skin = self.drip;
	self.attack_finished = (time + self.drop);
	if (self.drip<3) {
		sound (self, CHAN_WEAPON, "ebcs.wav", 1, ATTN_NORM);
	} else {
		sound (self, CHAN_WEAPON, "ebbs.wav", 1, ATTN_NORM);
	}
	newmis.owner = self; // for death obituary purposes. 
	newmis.touch = fireballTouch; 
	if (self.lip == 0) {
		newmis.movetype = MOVETYPE_FLY;
		newmis.movedir = v_forward;
		newmis.velocity = (newmis.movedir * 750);
	} else {
		// newmis.velocity = (self.velocity + v_forward * 10);
		newmis.movetype = MOVETYPE_BOUNCE;
		newmis.velocity = v_forward*500 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	}
	newmis.think = Brick_Hurt;
	newmis.nextthink = (time + 0.0100);
};


void ()UFOBoard = 
{
	local float beans;
	beans = 30;
	setorigin ( self, (self.origin + '0 0 40'));
	// self.hull = HULL_SPIDER;
	setsize ( self, '-16.00000 -16.00000 -16.00000', '16.00000 16.00000 16.00000');
	self.hull = HULL_CROUCH;
	self.cnt = beans;
	self.movetype = MOVETYPE_FLY;
	setmodel (self, "models/saucer3.mdl");
	self.think = UFOThink;
	self.nextthink = (time + 0.1);
	//stuffcmd(self,"midi_play octor\n");
	stuffcmd(self,"music octor\n");
	stuffcmd ( self, "chase_active 1\n");
	stuffcmd ( self, "fov 110\n");
};


void ()UFOExit = 
{
	self.effects = 0;
	self.prehealth = self.health;
	stuffcmd ( self, "fov 90\n");
	// stuffcmd(self,"midi_play wasteland\n");
	Polymorph ( self);
	self.sheep_time = 0.00000;
	self.movetype = MOVETYPE_WALK;
	stuffcmd ( self, "chase_active 0\n");
	self.health = self.prehealth;
};


void() UFOField =

{



	local entity head, selected;
	local float dist;



	dist = 500;
	selected = world;
	head = findradius(self.origin, 500);
	while(head)
	{
		if( (head.health > 1) && (head.classname == "player") )
		{
			traceline(self.origin,head.origin,TRUE,self);
			if ( (vlen(head.origin - self.origin) < dist) )
			{
				selected = head;
				dist = vlen(head.origin - self.origin);
			}
		}
		head = head.chain;
	}
	if (dist<500)
	{
		// centerprint (selected, "You've found a UFO!");
		//  stuffcmd ( selected, "bf\n");
		if (selected.UFO == 1) {
			self.think = UFOField;
			self.nextthink = (time + 0.1);
		} else {
			stuffcmd (selected, "impulse 45");
		}
	}
	self.think = UFOField;
	self.nextthink = (time + 0.1);
};


void ()UFOFieldSpawner = {
	local entity dropy;

	dropy = spawn();
	dropy.origin = self.origin;
	dropy.solid = SOLID_BBOX;
	dropy.movetype = MOVETYPE_NONE;
	dropy.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
	// setmodel(dropy, "models/glowball.mdl");
	dropy.abslight = 0.5;
	setsize(dropy, '-1 -1 0', '1 1 4');
	dropy.think = UFOField;
	dropy.nextthink = (time + 0);
};

void  (entity loser)UFOInit =  
{
	sound ( loser, CHAN_VOICE, "misc/sheepfly.wav", 1.00000, ATTN_NORM);
	loser.sheep_time = (time + 30.00000);
	GenerateTeleportEffect ( loser.origin, 1.00000);
	if ( (loser.classname == "player") ) 
	{
		if ( ((loser.effects & EF_BRIGHTLIGHT) && (loser.playerclass == CLASS_CRUSADER)) ) 
		{
			loser.effects ^= EF_BRIGHTLIGHT;
		}
		if ( (loser.artifact_active & ART_TOMEOFPOWER) ) 
		{
			loser.tome_time = 0.00000;
		}
		if ( (loser.hull != HULL_CROUCH) ) 
		{
			if ( loser.hasted ) 
			{
				loser.hasted *= 0.60000;
			} 
			else 
			{
				loser.hasted = 0.60000;
			}
		}
		loser.mass = 3.00000;
		if ( (loser.health > 25.00000) ) 
		{
			loser.health = 25.00000;
		}
		loser.th_missile = player_sheep_baa;
		loser.th_melee = player_sheep_baa;
		//           loser.th_stand = player_sheep_stand;
		//              loser.th_run = player_sheep_run;
		//              loser.th_walk = player_sheep_run;
		//              loser.th_pain = player_sheep_pain;
		//              loser.th_jump = player_sheep_jump;
		setmodel ( loser, "models/sheep.mdl");
		setsize ( loser, '-16.00000 -16.00000 -16.00000', '16.00000 16.00000 16.00000');
		loser.model = "models/sheep.mdl";
		//              loser.th_weapon = player_sheep_snout_pain1;
		loser.hull = HULL_CROUCH;
		loser.view_ofs = '0.00000 0.00000 24.00000';
		loser.proj_ofs = '0.00000 0.00000 18.00000';
		loser.attack_finished = 0.00000;
		loser.weapon = FALSE;
		loser.weaponmodel = "models/snout.mdl";
		loser.weaponframe = 0.00000;
		loser.sheep_sound_time = FALSE;
		loser.think = UFOThink;
		AdvanceThinkTime(loser,0.00000);
	} 
	else 
	{
		sound ( loser, CHAN_BODY, "misc/null.wav", 1.00000, ATTN_NONE);
		sound ( loser, CHAN_WEAPON, "misc/null.wav", 1.00000, ATTN_NONE);
		sound ( loser, CHAN_ITEM, "misc/null.wav", 1.00000, ATTN_NONE);
		newmis = spawn ( );
		setorigin ( newmis, loser.origin);
		newmis.th_spawn = loser.th_spawn;
		newmis.skin = 0.00000;
		newmis.oldskin = loser.skin;
		newmis.max_health = loser.health;
		if ( !loser.enemy ) 
		{
			newmis.enemy = self.owner;
		} 
		else 
		{
			newmis.enemy = loser.enemy;
		}
		newmis.goalentity = newmis.enemy;
		newmis.angles = loser.angles;
		remove ( loser);
		newmis.flags2 |= FL_SUMMONED;
		newmis.spawnflags |= NO_DROP;
		newmis.think = UFOThink;
		AdvanceThinkTime(newmis,0.00000);
	}
};

