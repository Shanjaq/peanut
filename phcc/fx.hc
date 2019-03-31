float WHITE_PUFF   =  0.00000;
float RED_PUFF   =  1.00000;
float GREEN_PUFF   =  2.00000;
float GREY_PUFF   =  3.00000;

void  (vector org,vector vel,float framelength)CreateTeleporterBodyEffect =  {
	starteffect ( CE_TELEPORTERBODY, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateTeleporterSmokeEffect =  {
	starteffect ( CE_TELEPORTERPUFFS, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateWhiteSmoke =  {
	starteffect ( CE_WHITE_SMOKE, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateRedSmoke =  {
	starteffect ( CE_RED_SMOKE, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateGreySmoke =  {
	starteffect ( CE_GREY_SMOKE, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateGreenSmoke =  {
	starteffect ( CE_GREEN_SMOKE, org, vel, framelength);
};


void  (vector org,vector vel,float framelength)CreateRedCloud =  {
	starteffect ( CE_REDCLOUD, org, vel, framelength);
};


void  (vector spot)CreateLittleWhiteFlash =  {
	starteffect ( CE_SM_WHITE_FLASH, spot);
};


void  (vector spot)CreateLittleBlueFlash =  {
	starteffect ( CE_SM_BLUE_FLASH, spot);
};


void  (vector spot)CreateBlueFlash =  {
	starteffect ( CE_BLUE_FLASH, spot);
};


void  (vector spot)CreateWhiteFlash =  {
	starteffect ( CE_WHITE_FLASH, spot);
};


void  (vector spot)CreateYRFlash =  {
	starteffect ( CE_YELLOWRED_FLASH, spot);
};


void  (vector spot)CreateBlueExplosion =  {
	starteffect ( CE_BLUE_EXPLOSION, spot);
};


void  (vector spot)CreateExplosion29 =  {
	starteffect ( CE_BG_CIRCLE_EXP, spot);
};


void  (vector spot)CreateFireCircle =  {
	starteffect ( CE_SM_CIRCLE_EXP, spot);
};


void  (vector spot)CreateRedSpark =  {
	starteffect ( CE_REDSPARK, spot);
};


void  (vector spot)CreateGreenSpark =  {
	starteffect ( CE_GREENSPARK, spot);
};


void  (vector spot)CreateBSpark =  {
	starteffect ( CE_BLUESPARK, spot);
};


void  (vector spot)CreateSpark =  {
	starteffect ( CE_YELLOWSPARK, spot);
};


void  ()splash_run =  {
	local float result = 0.00000;
	result = AdvanceFrame ( 0.00000, 5.00000);
	self.nextthink = (time + HX_FRAME_TIME);
	self.think = splash_run;
	if ( (result == AF_END) ) {

		self.nextthink = (time + HX_FRAME_TIME);
		self.think = SUB_Remove;

	}
};


void  (vector spot)CreateWaterSplash =  {
	local entity newent;
	newent = spawn ( );
	setmodel ( newent, "models/wsplash.spr");
	setorigin ( newent, spot);
	newent.movetype = MOVETYPE_NOCLIP;
	newent.solid = SOLID_NOT;
	newent.velocity = '0.00000 0.00000 0.00000';
	newent.nextthink = (time + 0.05000);
	newent.think = splash_run;
};


void  (vector org,vector vel,float damage,entity victim)SpawnPuff =  
{
	local float part_color;
	local float part_color2;
	local float part_color3;
	local float rad = 0.00000;
	if  ((victim.thingtype == THINGTYPE_FLESH) && (victim.classname != "mummy") && (victim.netname != "spider"))  
	{
		part_color = ((256.00000 + (8.00000 * 16.00000)) + random(9.00000));
		part_color2 = ((256.00000 + (8.00000 * 16.00000)) + random(9.00000));
		part_color3 = ((256.00000 + (8.00000 * 16.00000)) + random(9.00000));
	} 
	else 
	{
		if ((victim.thingtype == THINGTYPE_GREYSTONE) || (victim.thingtype == THINGTYPE_BROWNSTONE))  
		{
			part_color = ((256.00000 + 20.00000) + random(8.00000));
			part_color2 = ((256.00000 + 20.00000) + random(8.00000));
			part_color3 = ((256.00000 + 20.00000) + random(8.00000));
		} 
		else 
		{
			if (victim.thingtype == THINGTYPE_METAL)
			{
				part_color = (256.00000 + (8.00000 * 15.00000));
				part_color2 = (256.00000 + (8.00000 * 15.00000));
				part_color3 = (256.00000 + (8.00000 * 15.00000));
			} 
			else 
			{
				if (victim.thingtype == THINGTYPE_WOOD) 
				{
					part_color = ((256.00000 + (5.00000 * 16.00000)) + random(8.00000));
					part_color2 = ((256.00000 + (5.00000 * 16.00000)) + random(8.00000));
					part_color3 = ((256.00000 + (5.00000 * 16.00000)) + random(8.00000));

				} 
				else 
				{
					if (victim.thingtype == THINGTYPE_ICE) 
					{
						part_color = (406.00000 + random(8.00000));
						part_color2 = (406.00000 + random(8.00000));
						part_color3 = (406.00000 + random(8.00000));

					} 
					else 
					{
						if (victim.netname == "spider") //|| (victim.model == "models\scorpion.mdl"))  
						{
							part_color = ((256.00000 + 183.00000) + random(8.00000));
							part_color2 = ((256.00000 + 183.00000) + random(8.00000));
							part_color3 = ((256.00000 + 183.00000) + random(8.00000));
						} 
						else 
						{
							part_color = ((256.00000 + (3.00000 * 16.00000)) + 4.00000);
							part_color2 = ((256.00000 + (3.00000 * 16.00000)) + 4.00000);
							part_color3 = ((256.00000 + (3.00000 * 16.00000)) + 4.00000);

						}
					}
				}
			}
		}
	}
	rad = vlen ( vel);
	if ( !rad ) 
	{
		rad = random(10.00000,20.00000);
	}
	//particle4 ( org, rad, part_color, PARTICLETYPE_FASTGRAV, (2.00000 * damage));
	particle2 ( org, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (part_color), PARTICLETYPE_SLOWGRAV, damage);
	particle2 ( org, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (part_color2), PARTICLETYPE_GRAV, damage);
	particle2 ( org, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (part_color3), PARTICLETYPE_SLOWGRAV, damage);
};


void  (vector spot)CreateRedFlash =  {
	starteffect ( CE_RED_FLASH, spot);
};

void  ()DeathBubblesSpawn;

void  ()flash_remove =  {
	remove ( self);
};


void  (entity center)GenerateTeleportSound =  {
	local string telesnd;
	local float r = 0.00000;
	r = (rint ( random(4.00000)) + 1.00000);
	if ( (r == 1.00000) ) {

		telesnd = "misc/teleprt1.wav";
	} else {

		if ( (r == 2.00000) ) {

			telesnd = "misc/teleprt2.wav";
		} else {

			if ( (r == 3.00000) ) {

				telesnd = "misc/teleprt3.wav";
			} else {

				if ( (r == 4.00000) ) {

					telesnd = "misc/teleprt4.wav";
				} else {

					telesnd = "misc/teleprt5.wav";

				}

			}

		}

	}
	sound ( center, CHAN_AUTO, telesnd, 1.00000, ATTN_NORM);
};


void  (vector spot1,float teleskin)GenerateTeleportEffect =  {
	local entity sound_ent;
	if ( (self.attack_finished > time) ) {

		return ;

	}
	sound_ent = spawn ( );
	setorigin ( sound_ent, spot1);
	GenerateTeleportSound ( sound_ent);
	sound_ent.think = SUB_Remove;
	AdvanceThinkTime(sound_ent,2.00000);
	CreateTeleporterBodyEffect ( spot1, '0.00000 0.00000 0.00000', teleskin);
	CreateTeleporterSmokeEffect ( spot1, '0.00000 0.00000 0.00000', HX_FRAME_TIME);
	CreateTeleporterSmokeEffect ( (spot1 + '0.00000 0.00000 64.00000'), '0.00000 0.00000 0.00000', HX_FRAME_TIME);
};


void  ()smoke_generator_use =  {
	self.use = smoke_generator_use;
	self.nextthink = (time + HX_FRAME_TIME);
	if ( !self.wait ) {

		self.wait = 2.00000;

	}
	self.owner = other;
	if ( self.lifespan ) {

		self.lifetime = (time + self.lifespan);

	}
};


void  ()smoke_generator_run =  {
	local float pc;
	
	if (self.lip > 0.00000)
	setorigin (self, self.dest + (random('-1.00000 -1.00000 -1.00000', '1.00000 1.00000 1.00000') * self.lip));
	
	
	pc = pointcontents(self.origin);
	if ( !(((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) || (pc == CONTENT_LAVA)) )
	{
		if (self.thingtype == WHITE_PUFF || self.classname == "fizz_generator") // BAER hacked this
		{

			CreateWhiteSmoke ( self.origin, '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));
		} else {

			if ( (self.thingtype == RED_PUFF) || (self.classname == "balloffire") ) {

				CreateRedSmoke ( self.origin, '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));
			} else {

				if ( (self.thingtype == GREEN_PUFF) ) {

					CreateRedSmoke ( self.origin, '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));
				} else {

					if ( (self.thingtype == GREY_PUFF) ) {

						CreateGreySmoke ( self.origin, '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));

					}

				}

			}

		}
	}
	self.nextthink = (time + random(self.wait));
	self.think = smoke_generator_run;
	if ( (self.lifespan && (self.lifetime < time)) ) {

		remove ( self);

	}
};


void  ()fx_smoke_generator =  {
	setmodel ( self, "models/null.spr");
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.th_die = SUB_Remove;
	if ( !self.targetname ) {

		self.nextthink = (time + HX_FRAME_TIME);

	}
	self.use = smoke_generator_use;
	if ( !self.wait ) {

		self.wait = 2.00000;

	}
	self.think = smoke_generator_run;
};


void  (vector org)fx_flash =  {
	local entity newent;
	newent = spawn ( );
	setmodel ( newent, "models/s_bubble.spr");
	setorigin ( newent, (org + '0.00000 0.00000 24.00000'));
	newent.movetype = MOVETYPE_NOCLIP;
	newent.solid = SOLID_NOT;
	newent.velocity = '0.00000 0.00000 0.00000';
	newent.nextthink = (time + 0.50000);
	newent.think = flash_remove;
	newent.classname = "bubble";
	newent.effects = EF_BRIGHTLIGHT;
	setsize ( newent, '-8.00000 -8.00000 -8.00000', '8.00000 8.00000 8.00000');
};


void  ()explosion_done =  {
	self.effects = EF_DIMLIGHT;
};


void  ()explosion_use =  {
	sound ( self, CHAN_BODY, self.noise1, 1.00000, ATTN_NORM);
	particleexplosion ( self.origin, self.color, self.exploderadius, self.counter);
};

