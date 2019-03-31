void  ()BlowUp =  {
   if ( ((self.dmg < 2.50000) && (self.scale >= 0.10000)) ) {

      self.v_angle = RandomVector ( '180.00000 180.00000 180.00000');
      self.scale = self.dmg;
      T_RadiusDamage ( self, self.owner, (self.dmg * 100.00000), world);
      self.dmg += 0.10000;
      if ( self.enemy ) {

         setorigin ( self, (self.enemy.origin + self.view_ofs));

      }
      self.think = BlowUp;
      AdvanceThinkTime(self,0.02500);
   } else {

      self.think = SUB_Remove;
      AdvanceThinkTime(self,0.00000);

   }
};


void  ()Bigf =  {
local entity bigfb;
   sound ( self, CHAN_AUTO, "weapons/fbfire.wav", 1.00000, ATTN_NORM);
   bigfb = spawn ( );
   bigfb.enemy = self.enemy;
   bigfb.movetype = MOVETYPE_NOCLIP;
   bigfb.owner = self.owner;
   bigfb.classname = "bigfb";
   bigfb.solid = SOLID_NOT;
   bigfb.drawflags |= ((MLS_ABSLIGHT | SCALE_TYPE_UNIFORM) | SCALE_ORIGIN_CENTER);
   bigfb.abslight = 0.50000;
   bigfb.scale = 0.10000;
   setmodel ( bigfb, "models/blast.mdl");
   setsize ( bigfb, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
   setorigin ( bigfb, self.origin);
   bigfb.dmg = 0.10000;
   bigfb.avelocity = '50.00000 50.00000 50.00000';
   bigfb.think = BlowUp;
   AdvanceThinkTime(bigfb,0.00000);
   remove ( self);
};
