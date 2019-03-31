
void  ()corpseblink =  {
   self.think = corpseblink;
   AdvanceThinkTime(self,0.10000);
   self.scale -= 0.10000;
   if ( (self.scale < 0.10000) ) {

      remove ( self);

   }
};


void  ()init_corpseblink =  {
   CreateYRFlash ( self.origin);
   self.drawflags |= ((DRF_TRANSLUCENT | SCALE_TYPE_ZONLY) | SCALE_ORIGIN_BOTTOM);
   corpseblink ( );
};


void  ()Spurt =  {
local float bloodleak = 0.00000;
   makevectors ( self.angles);
   bloodleak = rint ( random(3.00000,8.00000));
   SpawnPuff ( ((self.origin + (v_forward * 24.00000)) + '0.00000 0.00000 -22.00000'), ('0.00000 0.00000 -5.00000' + (v_forward * random(20.00000,40.00000))), bloodleak, self);
   sound ( self, CHAN_AUTO, "misc/decomp.wav", 0.30000, ATTN_NORM);
   if ( ((self.lifetime < time) || (self.watertype == CONTENT_LAVA)) ) {

      T_Damage ( self, world, world, self.health);
   } else {

      self.think = Spurt;
      AdvanceThinkTime(self,random(0.50000,6.50000));

   }
};


void  ()CorpseThink =  {
   self.think = CorpseThink;
   AdvanceThinkTime(self,3.00000);
   if ( (self.watertype == CONTENT_LAVA) ) {

      T_Damage ( self, self, self, self.health);
   } else {
//necromancy
//      if ( self.pie == 65 ) 
//      {
//         self.pie = 66;
//         spawnify(self);
//         self.lifetime = time;	
//      }

      if ( (self.lifetime < time) ) {

         init_corpseblink ( );

      }

   }
};

void() Corpseplosion =
{
	newmis = spawn();
	newmis.effects = EF_NODRAW;
	setmodel ( newmis, "models/spider.mdl");
	newmis.thingtype = THINGTYPE_FLESH;
	setorigin(newmis, self.origin + '0 0 5');
	setsize(newmis, self.mins * 3.50000, self.maxs * 3.50000);
	sound ( newmis, CHAN_AUTO, "player/megagib.wav", 1.00000, ATTN_NORM);
	newmis.think = chunk_death;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	T_RadiusDamageFlat (self, self, random(48, 96), 128.00000, self, FALSE);
	remove(self);
	
	//self.think = SUB_Remove;
	//AdvanceThinkTime(self, HX_FRAME_TIME);
};

void  ()MakeSolidCorpse =  {
local vector newmaxs = '0.00000 0.00000 0.00000';
   //self.pie = 64; //necromancy
   self.deadflag = DEAD_DEAD;
   
   self.th_die = chunk_death;
   self.touch = obj_push;
   self.health = random(10.00000,25.00000);
   self.takedamage = DAMAGE_YES;
   self.solid = SOLID_PHASE;
   self.experience_value = 0.00000;
   
   if ( (self.classname != "monster_hydra") ) {

      self.movetype = MOVETYPE_STEP;

   }
   if ( !self.mass ) {

      self.mass = 1.00000;

   }
   newmaxs = self.maxs;
   if ( (newmaxs_z > 5.00000) ) {

      newmaxs_z = 5.00000;

   }
   setsize ( self, self.mins, newmaxs);
   if ( (self.flags & FL_ONGROUND) ) {

      self.velocity = '0.00000 0.00000 0.00000';

   }
   self.flags ^= FL_MONSTER;
   self.controller = self;
   self.onfire = FALSE;
   pitch_roll_for_slope ( '0.00000 0.00000 0.00000');
   if ( (self.decap && (self.classname == "player")) ) {

      if ( (deathmatch || teamplay) ) {

         self.lifetime = (time + random(20.00000,40.00000));
      } else {

         self.lifetime = (time + random(10.00000,20.00000));

      }
      self.owner = self;
      self.think = Spurt;
      AdvanceThinkTime(self,random(1.00000,4.00000));
   } else {

      self.lifetime = (time + random(10.00000,20.00000));
      self.think = CorpseThink;
      AdvanceThinkTime(self,0.00000);

   }
};

