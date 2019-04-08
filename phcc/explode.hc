void  (entity loser,entity forwhom)SnowJob;
void  ()CB_BoltStick;
void  (string type)FireMeteor;

void  ()BlowUp =  
{
	if (self.scale >= 1.7)
	{
		if (self.scale >= 2.2 && !self.drawflags & DRF_TRANSLUCENT)
		{
			self.drawflags |= DRF_TRANSLUCENT;
		}
		self.abslight -= 0.1;
	}
	if (self.dmg < 2.5)  
	{

		self.v_angle = RandomVector ( '180 180.00000 180.00000');
		self.scale = self.dmg;
		T_RadiusDamage ( self, self.owner, (self.dmg * 100.00000), world);
		self.dmg += 0.10000;
		self.think = BlowUp;
		AdvanceThinkTime(self,0.02500);
	} else {
		self.think = SUB_Remove;
		AdvanceThinkTime(self,0.00000);
	}
};


void  ()BlowUp2 =  
{
	if (self.owner.cscale<0.6) {
		self.think = SUB_Remove;
		self.nextthink = (time + 0.02);
	} else {
		self.cscale - 0.1;
	}

	if (self.scale >= 1.7)
	{
		if (self.scale >= 2.0 && !self.drawflags & DRF_TRANSLUCENT)
		{
			self.drawflags |= DRF_TRANSLUCENT;
		}
		self.abslight -= 0.1;
	}
	if (self.dmg < 2.5)  
	{

		self.v_angle = RandomVector ( '180 180.00000 180.00000');
		self.scale = self.dmg;
		T_RadiusDamage ( self, self.owner, (self.dmg * 100.00000), world);
		self.dmg += 0.10000;
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 241.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 242.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 240.00000, 17, 80.00000);
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 241.00000, 21, 80.00000);

		self.think = BlowUp2;
		AdvanceThinkTime(self,0.0550);
	} 
	else 
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self,0.00000);
	}
};

void() BlowUp3 =

{

	if (self.scale >= (1.35000*self.spellradiusmod) && !self.drawflags & DRF_TRANSLUCENT)
	{
		
		self.drawflags |= DRF_TRANSLUCENT;

		self.abslight -= 0.1;	
	}


	if (self.scale>(1.65000*self.spellradiusmod)) {
		self.think = SUB_Remove;
		self.nextthink = (time + 0.02);
		remove (self);
		return;
	} else {
		self.scale += 0.10000;
	}
	local entity head, selected;
	local float dist;
	dist = (self.scale * 75);
	head = findradius(self.origin, (self.scale * 75));
	while(head)
	{
		if((head.health >= 1) && (head != self.owner))
		{
			if ( (vlen(head.origin - self.origin) < dist) )
			{
				dist = vlen(head.origin - self.origin);
				
				//if  ((head.freeze_time <= time) && (head.health<10)) {
				if ( ((((((head.health <= self.spelldamage) || (((head.classname == "player") && (head.frozen <= -5.00000)) && (head.health < 200.00000))) && (head.solid != SOLID_BSP)) && !(head.artifact_active & ART_INVINCIBILITY)) && (head.thingtype == THINGTYPE_FLESH)) && (head.health < 100.00000)) ) {
					SnowJob ( head, self.owner);
				} else {
					if (head.freeze_time <= time) {
						T_Damage ( head, self, self.owner, self.spelldamage);
					}
				}
			}
		}
		head = head.chain;
	}
	self.nextthink = 0.5;
	self.think = BlowUp3;
};


void ()coldsp_timer;

void() IceBlastWave = {
	if (time < self.splash_time)
	{
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * 0.36250)*self.spellradiusmod;
		self.abslight = ((self.splash_time - time) / self.lifetime);
		self.think = IceBlastWave;
	} 
	else 
	{
		self.think = SUB_Remove;
	}
	AdvanceThinkTime(self, HX_FRAME_TIME);
};

void (float howbig, float howmuch)IceBoom =
{
	local entity head;
	local float dist;
	local string grr;
	dist = howbig;
	head = findradius(self.origin, howbig);
	while(head)
	{
		if((head.health >= 1) && (head != self.owner))
		{
			traceline(self.origin,head.origin,TRUE,self);
			if ( (vlen(head.origin - self.origin) < dist) )
			{
				dist = vlen(head.origin - self.origin);
				
				//if  ((head.freeze_time <= time) && (head.health<10)) {
				if ( ((((((head.health <= howmuch) || (((head.classname == "player") && (head.frozen <= -5.00000)) && (head.health < 200.00000))) && (head.solid != SOLID_BSP)) && !(head.artifact_active & ART_INVINCIBILITY)) && (head.thingtype == THINGTYPE_FLESH)) && (head.health < 100.00000)) ) {
					SnowJob ( head, self.owner);
				} else {
					if (head.freeze_time <= 0) {
						T_Damage ( head, self, self.owner, howmuch);
					}
				}
			}
		}
		head = head.chain;
	}
	
	newmis = spawn();
	newmis.spellradiusmod = self.spellradiusmod;
	setorigin (newmis, self.origin);
	newmis.scale = 0.01250;
	setmodel(newmis, "models/expring.mdl");
	newmis.drawflags = MLS_ABSLIGHT;
	newmis.abslight = 1;
	newmis.skin = 1;
	makevectors (self.velocity);
	traceline ( (self.origin - (v_forward * 24.00000)), (self.origin + (v_forward * 48.00000)), 1, self);
	if ((trace_ent.classname == "worldspawn") && (trace_fraction < 1)) {
		//sprint(self.owner, "hit a wall!\n");
		newmis.angles = vectoangles(trace_plane_normal);
		newmis.angles_x = ((90.00000 - newmis.angles_x) * -1.00000);
	} else {
		//sprint(self.owner, "hit something else!\n");
		newmis.angles = vectoangles(v_forward);
	}
	newmis.lifetime = 0.36250;
	newmis.splash_time = time + newmis.lifetime;
	
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = IceBlastWave;
	
	
	self.nextthink = 0.5;
	self.think = coldsp_timer;

};






void  ()SprayFire =  
{
	local entity fireballblast;
	//   sound ( self, CHAN_AUTO, "exp3.wav", 1.00000, ATTN_NORM);
	sound ( self, CHAN_AUTO, "weapons/fbfire.wav", 1.00000, ATTN_NORM);
	fireballblast = spawn ( );
	fireballblast.enemy = self.enemy;
	fireballblast.movetype = MOVETYPE_NOCLIP;
	fireballblast.owner = self.owner;
	fireballblast.stickydir = self.stickydir;
	fireballblast.classname = "fireballblast";
	fireballblast.solid = SOLID_NOT;
	fireballblast.drawflags |= ((MLS_ABSLIGHT | SCALE_TYPE_UNIFORM) | SCALE_ORIGIN_CENTER);
	fireballblast.abslight = 1;
	fireballblast.scale = 0.1;
	setmodel ( fireballblast, "models/blast.mdl");
	setsize ( fireballblast, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( fireballblast, self.origin);
	fireballblast.dmg = 0.1;
	fireballblast.avelocity = '50.00000 50.00000 50.00000';
	fireballblast.think = BlowUp;
	AdvanceThinkTime(fireballblast,0.00000);
	remove ( self);
};


void ()photon_beam_think;

void  ()ChargeBlast =  {
	local entity fireballblast;
	//   sound ( self, CHAN_AUTO, "exp3.wav", 1.00000, ATTN_NORM);
	local entity found;

	found = nextent (world);

	while ( found ) {

		if ( (found.classname == "player") ) {

			sound (found, CHAN_BODY, "lbht.wav", 1, ATTN_NORM);
		}
		found = find ( found, classname, "player");
	}
	fireballblast = spawn ( );
	fireballblast.enemy = self.enemy;
	fireballblast.movetype = MOVETYPE_NOCLIP;
	fireballblast.owner = self.owner;
	fireballblast.classname = "fireballblast";
	fireballblast.solid = SOLID_NOT;
	fireballblast.drawflags |= ((MLS_ABSLIGHT | SCALE_TYPE_UNIFORM) | SCALE_ORIGIN_CENTER);
	fireballblast.abslight = 1;
	fireballblast.scale = 0.1;
	setmodel ( fireballblast, "models/cblast.mdl");
	setsize ( fireballblast, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( fireballblast, self.origin);
	fireballblast.dmg = 0.10000;
	fireballblast.avelocity = '50.00000 50.00000 50.00000';
	fireballblast.think = BlowUp2;
	AdvanceThinkTime(fireballblast,0.00000);
	self.drawflags |= DRF_TRANSLUCENT;
	self.cnt = 96;
	self.velocity = '0 0 0';
	AdvanceThinkTime(self, 0.02);
	self.think = photon_beam_think;
};


void  ()SprayIce =  
{
	local entity fireballblast;
	//   sound ( self, CHAN_AUTO, "exp3.wav", 1.00000, ATTN_NORM);
	sound ( self, CHAN_AUTO, "weapons/fbfire.wav", 1.00000, ATTN_NORM);
	fireballblast = spawn ( );
	fireballblast.spelldamage = self.spelldamage;
	fireballblast.spellradiusmod = self.spellradiusmod;
	fireballblast.enemy = self.enemy;
	fireballblast.movetype = MOVETYPE_NOCLIP;
	fireballblast.owner = self.owner;
	fireballblast.stickydir = self.stickydir;
	fireballblast.classname = "fireballblast";
	fireballblast.solid = SOLID_NOT;
	fireballblast.drawflags |= ((MLS_ABSLIGHT | SCALE_TYPE_UNIFORM) | SCALE_ORIGIN_CENTER);
	fireballblast.abslight = 1;
	fireballblast.scale = 0.1;
	setmodel ( fireballblast, "models/iceboom.mdl");
	setsize ( fireballblast, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( fireballblast, self.origin);
	fireballblast.dmg = 0.1;
	fireballblast.avelocity = '50.00000 50.00000 50.00000';
	fireballblast.think = BlowUp3;
	AdvanceThinkTime(fireballblast,0.00000);
	remove ( self);
};


void  ()SmallExplosion =  {
	sound ( self, CHAN_AUTO, "weapons/explode.wav", 0.50000, ATTN_NORM);
	BecomeExplosion ( CE_SM_EXPLOSION);
};


void  ()DarkExplosion =  {
	local entity ignore, found;
	if ( (self.classname == "timebomb") ) {

		sound ( self, CHAN_AUTO, "weapons/explode.wav", 1.00000, ATTN_NORM);
		ignore = self.enemy;
	} else {

		if ( (self.classname == "pincer") ) {

			sound ( self, CHAN_BODY, "weapons/explode.wav", 1.00000, ATTN_NORM);
			ignore = self.owner;
		} else {

			if ( (self.controller.classname == "multigrenade") ) {

				sound ( self.controller, CHAN_BODY, "weapons/explode.wav", 1.00000, ATTN_NORM);
			} else {

				sound ( self, CHAN_AUTO, "weapons/explode.wav", 1.00000, ATTN_NORM);

			}
			ignore = world;

		}

	}
	T_RadiusDamage ( self, self.owner, self.dmg, ignore);
	self.spelldamage = (self.dmg * 0.25000);
	self.spellradiusmod = 1.00000;
	if ((random() < 0.5) && (self.enemy.takedamage == DAMAGE_YES) && (self.enemy.solid != SOLID_BSP))
		apply_status(self.enemy, STATUS_BURNING, self.spelldamage, 8);
	
	found = found = findradius (self.origin, self.dmg);
	while (found)
	{
		if ((random() < 0.5) && (found.takedamage == DAMAGE_YES) && (found.solid != SOLID_BSP) && (found != self.enemy) && (found != self.owner))
			apply_status(found, STATUS_BURNING, self.spelldamage, 8);	
		
		found = found.chain;
	}
	
	if ( ((self.classname == "minigrenade") && (random() < 0.50000)) ) {

		BecomeExplosion ( FALSE);
	} else {

		if ( (self.classname == "flaming arrow") ) {

			starteffect ( CE_XBOW_EXPLOSION, self.origin);
			remove ( self);
		} else {

			starteffect ( CE_NEW_EXPLOSION, self.origin);
			remove ( self);

		}

	}
};


void  ()MultiExplode =  {
	local float nummeteorites = 0.00000;
	if ( (self.classname == "stickmine") ) {

		SprayFire ( );
		return ;

	}
	T_RadiusDamage ( self, self.owner, self.dmg, world);
	if ( (self.classname == "meteor") ) {

		nummeteorites = random(3.00000,10.00000);
		while ( (nummeteorites > 0.00000) ) {

			FireMeteor ( "minimeteor");
			nummeteorites = (nummeteorites - 1.00000);

		}

	}
	if ( (self.flags2 & FL_SMALL) ) {

		SmallExplosion ( );
	} else {

		WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte ( MSG_BROADCAST, TE_EXPLOSION);
		WriteCoord ( MSG_BROADCAST, self.origin_x);
		WriteCoord ( MSG_BROADCAST, self.origin_y);
		WriteCoord ( MSG_BROADCAST, self.origin_z);
		BecomeExplosion ( FALSE);

	}
};

void  ()SuperGrenadeExplode;

void  ()GrenadeTouch2 =  {
	if ( (other == self.owner) ) {

		return ;

	}
	if ( (((other.owner == self.owner) && (other.classname == self.classname)) && (self.classname == "minigrenade")) ) {

		return ;

	}
	if ( (other.takedamage == DAMAGE_YES) ) {

		T_Damage ( other, self, self.owner, self.dmg);
		self.dmg /= 2.00000;
		if ( (self.classname == "multigrenade") ) {

			self.think = SuperGrenadeExplode;
		} else {

			if ( ((self.classname == "minigrenade") || (self.classname == "flaming arrow")) ) {
				self.enemy = other;
				self.think = DarkExplosion;
			} else {

				self.think = MultiExplode;

			}

		}
		AdvanceThinkTime(self,0.00000);
	} else {

		sound ( self, CHAN_WEAPON, "assassin/gbounce.wav", 1.00000, ATTN_NORM);
		if ( (self.velocity == '0.00000 0.00000 0.00000') ) {

			self.avelocity = '0.00000 0.00000 0.00000';

		}

	}
};


void  ()StickMineTouch =  
{
	local vector stickdir = '0.00000 0.00000 0.00000';
	if ( (other == self.owner) ) 
	{
		return ;
	}
	self.skin = 1.00000;
	self.touch = SUB_Null;
	if ( other.takedamage ) 
	{
		sound ( self, CHAN_WEAPON, "weapons/met2flsh.wav", 1.00000, ATTN_NORM);
		T_Damage ( other, self, self.owner, 3.00000);
		if ( (other.solid != SOLID_BSP) ) 
		{
			//stickdir = (other.origin + (normalize ( (self.origin - other.origin)) * 12.00000));
			stickdir = self.origin - other.origin; // BAER commented line out above and added this.
			self.stickydir = stickdir;
			if ( (other.classname == "player") ) 
			{
				stickdir_z = ((other.origin_z + other.proj_ofs_z) + 1.00000);
			} 
			else 
			{
				if ( (other.classname == "monster_spider") ) 
				{
					stickdir_z = ((self.origin_z + ((other.origin_z + (other.size_z * 0.20000)) * 3.00000)) * 0.25000);
				} 
				/*else 
				{
						stickdir_z = ((self.origin_z + ((other.origin_z + (other.size_z * 0.60000)) * 3.00000)) * 0.25000);
BAER commented this out.
					}*/

			}
			setorigin ( self, stickdir);
			SpawnPuff ( (self.origin + (v_forward * 8.00000)), ('0.00000 0.00000 0.00000' - (v_forward * 24.00000)), 10.00000, other);

		}
	} 
	else 
	{
		setorigin ( self, (self.origin + (normalize ( self.velocity) * -3.00000)));
		sound ( self, CHAN_WEAPON, "weapons/met2stn.wav", 1.00000, ATTN_NORM);
		SpawnPuff ( (self.origin + (v_forward * 8.00000)), ('0.00000 0.00000 0.00000' - (v_forward * 24.00000)), 10.00000, world);
	}
	self.velocity = '0.00000 0.00000 0.00000';
	self.movetype = MOVETYPE_NOCLIP;
	self.solid = SOLID_NOT;
	self.touch = SUB_Null;
	self.wait = (time + 1.00000);
	self.health = other.health;
	if ( other.takedamage && other.solid != SOLID_BSP) 
	{
		self.enemy = other;
		self.view_ofs = (self.origin - other.origin);
		self.o_angle = (self.angles - self.enemy.angles);
		self.think = CB_BoltStick;
		AdvanceThinkTime(self,0.00000);
	} 
	else 
	{
		if (other.takedamage && other.solid == SOLID_BSP)
		{
			self.enemy = self;
			self.stickydir = '0 0 0';
			self.think = SprayFire;
			AdvanceThinkTime(self, 1);
		}
		else
		{
			self.enemy = world;
			self.movetype = MOVETYPE_NONE;
			self.think = MultiExplode;
			AdvanceThinkTime(self,0.50000);
		}
	}
};


void  ()Use_Fireball =  
{
	local entity missile;
	self.attack_finished = (time + 1.00000);
	makevectors ( self.v_angle);
	missile = spawn ( );
	missile.owner = self;
	missile.classname = "stickmine";
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.touch = StickMineTouch;
	missile.dmg = 50.00000;
	missile.velocity = ((normalize ( v_forward) * 700.00000) + (v_up * 200.00000));
	missile.avelocity = RandomVector ( '300.00000 300.00000 300.00000');
	missile.lifetime = (time + 60.00000);
	setmodel ( missile, "models/glyphwir.mdl");
	setsize ( missile, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( missile, ((self.origin + self.proj_ofs) + (v_forward * 16.00000)));
	missile.think = MultiExplode;
	AdvanceThinkTime(missile,10.00000);
};

