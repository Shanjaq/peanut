
void  ()FireFizzle =  {
   sound ( self, CHAN_WEAPON, "misc/fout.wav", 1.00000, ATTN_NORM);
   DeathBubbles ( 1.00000);
   remove ( self);
};


void  ()fireballTouch =  {
local float damg = 0.00000;
   if ( (other == self.owner) ) {

      return ;

   }
   if ( (pointcontents ( self.origin) == CONTENT_SKY) ) {

      remove ( self);
      return ;

   }
   	if ( (self.dmg == -1.00000) ) 
	{
      	damg = random(5.00000,10.00000);
   	} 
	else 
	{
      	if ( self.dmg ) 
		{

         	damg = self.dmg;
      } else {

         damg = random(16.00000,34.00000); // BAER changed from 12, 22 to 44, 66.

      }

   }
   if ( other.health ) {


         T_Damage ( other, self, self.owner, damg);

   }
   //T_RadiusDamage ( self, self.owner, damg, other);
   T_RadiusDamageFlat (self, self.owner, damg, 75.00000, self, FALSE);
   self.origin = (self.origin - (8.00000 * normalize ( self.velocity)));
   WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte ( MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord ( MSG_BROADCAST, self.origin_x);
   WriteCoord ( MSG_BROADCAST, self.origin_y);
   WriteCoord ( MSG_BROADCAST, self.origin_z);
   remove ( self);
};


void  ()fireball_1 =  {
local float retval = 0.00000;
   self.nextthink = (time + HX_FRAME_TIME);
   retval = AdvanceFrame ( 0.00000, 9.00000);
   if ( (retval == AF_BEGINNING) ) {

      if ( (pointcontents ( self.origin) != CONTENT_EMPTY) ) {

         FireFizzle ( );

      }

   }
};


void  (vector offset)do_fireball =  {
local entity missile;
local vector vec = '0.00000 0.00000 0.00000';
   missile = spawn ( );
   missile.owner = self;
   missile.speed = 500.00000;
   if ( (self.classname == "monster_imp_lord") ) {

      missile.dmg = random(80.00000,120.00000);
      missile.speed += 500.00000;
      missile.scale = 2.00000;
	
   } else {

      missile.dmg = self.dmg;

   }
	if (self.classname == "cube_of_force")
	{
		missile.dmg = random(40,60);
	}
   missile.movetype = MOVETYPE_FLYMISSILE;
   missile.solid = SOLID_BBOX;
   missile.health = 10.00000;
   setmodel ( missile, "models/fireball.mdl");
   setsize ( missile, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
   makevectors ( self.angles);
   vec = ((self.origin + self.view_ofs) + v_factor ( offset));
   setorigin ( missile, vec);
   vec = ((self.enemy.origin - missile.origin) + self.enemy.view_ofs);
   vec = normalize ( vec);
   missile.velocity = ((vec + aim_adjust ( self.enemy)) * missile.speed);
   missile.angles = vectoangles ( ('0.00000 0.00000 0.00000' - missile.velocity));
   missile.touch = fireballTouch;
   missile.think = fireball_1;
   missile.nextthink = (time + HX_FRAME_TIME);
};

