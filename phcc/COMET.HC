void (entity holdy)hold;

void() CrashFlash =
{
	local entity head;
	local float dist;

	if (self.classname == "flare") {
		dist = 700;
	} else {
		dist = 400;
	}
	//        selected = world;
	if (self.classname == "flare") {
		head = findradius(self.origin, dist);
	} else {
		head = findradius((self.origin - '0 0 400'), dist);
	}
	while(head)
	{
		if ((self.classname == "flare") && (head.health > 0))
		{
			if (head.flags2 & FL_ALIVE) 
			{
				if (head.classname == "player")
				{
					head.artifact_active |= ARTFLAG_DIVINE_INTERVENTION;
					head.divine_time = (time + 1);
				}
				AdvanceThinkTime(head,4); 
				hold(head);
			}

			T_Damage ( head, self, self.owner, 1.00000);
		}
		if ((self.classname == "swelterment") && (head.health > 0) && (head != self.owner))
		{
			T_Damage ( head, self, self.owner, random(5, 10));
		}

		head = head.chain;
	}
};


void() Brick_Hurt = 
{ 
	self.cnt = (self.cnt - 1);
	if (self.cnt<1) {
		T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.25000, 125.00000 * self.spellradiusmod, self.owner, FALSE);
		//T_RadiusDamage (self, self.owner, 90, other);
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY); 
		WriteByte (MSG_BROADCAST, TE_EXPLOSION); 
		WriteCoord (MSG_BROADCAST, self.origin_x); 
		WriteCoord (MSG_BROADCAST, self.origin_y); 
		WriteCoord (MSG_BROADCAST, self.origin_z);
		BecomeExplosion (); 
		remove(self);
	}

	self.angles = vectoangles(self.velocity);
	if (self.flags & FL_ONGROUND) {

		self.scale = (self.scale - 0.2);
		traceline ( self.origin, (self.origin - '0.00000 0.00000 250.00000'), FALSE, self);
		particle2 ( trace_endpos, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 235.00000, 5, 80.00000);
		T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.25000, 125.00000 * self.spellradiusmod, self.owner, FALSE);
		//T_RadiusDamage ( self, self.owner, 80, other);
		if (self.scale < 0.6) {
			//T_RadiusDamage ( self, self.owner, 90, other);
			T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.25000, 125.00000 * self.spellradiusmod, self.owner, FALSE);
			DarkExplosion ( );
		} else {
			self.think = Brick_Hurt;
			AdvanceThinkTime(self,0.03000);
		}
	} else {
		self.think = Brick_Hurt;
		AdvanceThinkTime(self,0.03000);

	}
	if (other.takedamage ) {
		//T_RadiusDamage ( self, self.owner, 90, other);
		T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.25000, 125.00000 * self.spellradiusmod, self.owner, FALSE);
		self.scale = (self.scale - 0.2);
		traceline ( self.origin, (self.origin - '0.00000 0.00000 250.00000'), FALSE, self);
		particle2 ( trace_endpos, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 220.00000, 7, 80.00000);
		if (self.scale < 0.6) {
			//T_RadiusDamage ( self, self.owner, 90, other);  
			T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.25000, 125.00000 * self.spellradiusmod, self.owner, FALSE);
			DarkExplosion ( );
		} else {
			self.think = Brick_Hurt;
			AdvanceThinkTime(self,0.03000);
		}
	} else {
		self.think = Brick_Hurt;
		AdvanceThinkTime(self,0.03000);
	}

};


void() tossabrick =
{

	newmis = spawn(); 
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.cnt = 90; 
	newmis.solid = SOLID_PHASE;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.origin = (self.origin + '0 0 30'); 
	setmodel ( newmis, "models/fragm1.mdl");
	newmis.skin = self.skin;
	newmis.owner = self.owner; // for death obituary purposes. 
	newmis.touch = Brick_Hurt; 
	newmis.velocity = random('-180 -180 -30','400 400 900'); // notice the accent on the up velocity
	// newmis.avelocity = random('10 10 10', '300 300 300'); // or however fast the spin would be 
	newmis.think = Brick_Hurt;
	newmis.nextthink = (time + 0.1000);
};


void() CrashThink = 
{
	self.count += 1;
	if (self.scale <= 2.3)
	self.scale += 0.2;
	else
	{
		self.frame = 0;
		setmodel(self, "models/null.spr");
	}

	if (self.count >= self.cnt)
	{
		remove(self);
		return;
	}
	local vector random_vector;

	random_vector_x = random(-50,50);
	random_vector_y = random(-50,50);
	random_vector_z = random(-50,50);

	//      if (random() > 0.8)
	CreateExplosion29 (self.origin + random_vector);
	//      else
	CreateFireCircle (self.origin + random_vector);
	tossabrick();
	self.nextthink = HX_FRAME_TIME;
	self.think = CrashThink;

};

void() CometCrash = {
	local float damg1 = 0;
	if ((other != world) && ((other.movetype == MOVETYPE_FLYMISSILE) || (other.movetype == MOVETYPE_BOUNCEMISSILE) || (other.movetype == MOVETYPE_BOUNCE) || (other == self.owner)))
		return ;

	if ( other.health ) {

		T_Damage ( other, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));

	}
	damg1 = (self.scale * 90);
	MonsterQuake ( 400.00000, self);
	CrashFlash();
	T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*self.scale, 164.00000 * self.spellradiusmod, self.owner, FALSE);
	//T_RadiusDamage ( self, self.owner, damg1, other);
	sound ( self, CHAN_BODY, "exp3.wav", 1, ATTN_NORM);
	self.origin = (self.origin - (8 * normalize ( self.velocity)));
	self.effects = EF_NODRAW;
	self.solid = SOLID_NOT;


	local entity crasher;
	crasher = spawn();
	crasher.spelldamage = self.spelldamage;
	crasher.spellradiusmod = self.spellradiusmod;
	crasher.owner = self.owner;
	crasher.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
	setmodel(crasher, "models/crash.mdl");
	crasher.skin = self.goalentity.skin;
	crasher.abslight = 1;
	//	crasher.angles = self.angles;
	//crasher.frame = 1;
	crasher.scale = 0.2;
	setorigin(crasher, self.origin - (v_forward * 8));
	crasher.think = CrashThink;
	crasher.effects = EF_BRIGHTLIGHT;
	crasher.nextthink = time + HX_FRAME_TIME;
	crasher.cnt = (self.scale * 7);  

	self.goalentity.think = SUB_Remove;
	AdvanceThinkTime(self.goalentity, 0.50000);

	self.nextthink = (time + 0.50000);
	self.think = SUB_Remove;

};


void() comet_fall_think =
{
	local float pc;
	
	if (self.movetype == MOVETYPE_NOCLIP)
	{
		pc = pointcontents(self.origin);
		if (pc == CONTENT_EMPTY)
		{
			self.movetype = MOVETYPE_FLYMISSILE;
			self.solid = SOLID_BBOX;
		}
	}
};



void() CometFall = {
	local entity tail;
	local entity comet;
	local vector dir;

	//traceline (self.origin, (self.origin + '0 0 900'), TRUE, self);

	
	traceline ( self.origin, (self.origin - '0.00000 0.00000 800.00000'), TRUE, self);
	setorigin ( self, trace_endpos);
	traceline ( self.origin, (self.origin + '0.00000 0.00000 1024.00000'), TRUE, self);
	self.dest = trace_endpos;
	traceline ( self.dest, (self.dest + '0.00000 200.00000 0.00000'), TRUE, self);
	self.dest = random(self.dest,trace_endpos);
	traceline ( self.dest, (self.dest - '0.00000 200.00000 0.00000'), TRUE, self);
	self.dest = random(self.dest,trace_endpos);
	traceline ( self.dest, (self.dest + '200.00000 0.00000 0.00000'), TRUE, self);
	self.dest = random(self.dest,trace_endpos);
	traceline ( self.dest, (self.dest - '200.00000 0.00000 0.00000'), TRUE, self);
	self.dest = random(self.dest,trace_endpos);
	dir = vectoangles(self.origin - self.dest);
	dir_x *= -1;
	makevectors(dir);
	
	
	tail = spawn();
	tail.owner = self.owner;
	tail.solid = SOLID_NOT;
	tail.movetype = MOVETYPE_NOCLIP;
	tail.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
	setmodel (tail, "models/tail.mdl");
	tail.abslight = 0.5;
	tail.scale = (1.60000 * self.spellradiusmod);
	//tail.skin = rint(((1.6 * self.spellradiusmod) / 2.40000) * 4.00000);
	tail.skin = rint(random(0, 4));
	/*
	if (tail.scale<1.1) {
		tail.skin = 0;
	}
	if ((tail.scale>1) && (tail.scale<1.5)) 
	{
		tail.skin = 1;
	}
	if ((tail.scale>1.4) && (tail.scale<1.9)) 
	{
		tail.skin = 2;
	}
	if ((tail.scale>1.8) && (tail.scale<2.2)) 
	{
		tail.skin = 3;
	}
	if (tail.scale>2.1)  
	{
		tail.skin = 4;
	}
	*/
	setorigin (tail, self.dest);
	tail.size = ('0 0 0');
	tail.velocity = (v_forward * 850);
	tail.speed = 10;
	tail.angles = vectoangles(tail.velocity);
	tail.classname = "tail";
	tail.cnt = 80;

	comet = spawn();
	comet.spelldamage = self.spelldamage;
	comet.spellradiusmod = self.spellradiusmod;
	comet.owner = self.owner;
	comet.goalentity = tail;
	comet.solid = SOLID_NOT;
	comet.movetype = MOVETYPE_NOCLIP;
	comet.hull = HULL_POINT;
	setsize(newmis, '2 2 2', '2 2 2');
	comet.drawflags |= MLS_ABSLIGHT;
	setmodel (comet, "models/glowball.mdl");
	comet.scale = tail.scale;
	setorigin (comet, self.dest);
	sound ( comet, CHAN_BODY, "mortfal.wav", 1, ATTN_NORM);
	comet.velocity = (v_forward * 850);
	comet.classname = "comet"; 
	comet.lifetime = 8.00000;
	comet.splash_time = (time + comet.lifetime);
	comet.touch = CometCrash;
	comet.think = comet_fall_think;
	AdvanceThinkTime(comet, 0.10000);
};