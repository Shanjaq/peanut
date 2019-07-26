void () item_arrows;

void () ArrowsTouch =
{
   local string mon;


   if ((other.classname) != "player") {
      return;
      }

   if ((other.health) <= 0) {
      return;
      }
if (other.predebt == 1) {
other.debt = (other.debt + 15);
}
   mon = ftos(self.arrows);
   sprint(other, "You get ");
   sprint(other, mon);
   sprint(other, " arrows\n");
   other.arrows += self.arrows;

   if (other.arrows > 100000) {
      other.arrows = 100000;
      }
  // sound(other, 3, "player/arrow.wav", 1, 1);
   stuffcmd(other, "bf\n");

   if ((self.classname) == "item_bigpile") {
      self.touch = SUB_Null;
      self.frame = 1;
      }
   else {
      remove(self);
      }
};





void (entity yo) ThrowArrows =
{
   local entity arrowsbunch;


 //  if ((self.arrows) <= 0) {
 //     return;
 //     }
   arrowsbunch = spawn();
   arrowsbunch.owner = yo;
   setorigin(arrowsbunch, (yo.origin) - '0 30 -24');
   arrowsbunch.arrows = yo.arrows;
   arrowsbunch.velocity_z = 300;
   arrowsbunch.velocity_x = -100 + ((random()) * 200);
   arrowsbunch.velocity_y = -100 + ((random()) * 200);
   arrowsbunch.avelocity = '0 600 0';
   arrowsbunch.flags = 256;
   arrowsbunch.solid = 1;
   arrowsbunch.movetype = 6;
   setmodel(arrowsbunch, "models/quiver.mdl");
   setsize(arrowsbunch, '-1 -1 0', '1 1 5');
   arrowsbunch.touch = item_arrows;
   arrowsbunch.think = item_arrows;
   AdvanceThinkTime(arrowsbunch, 10);
// StartItem();
};










void  ()spawn_item_arrows =  {
  if (deathmatch) {
      return;
      }

   if (!(self.arrows)) {
      self.arrows = 10 + (((random()) * 6) - 3);
  //    self.arrows = rint(self.arrows);
      }

   self.touch = ArrowsTouch;
   setmodel ( self, "models/quiver.mdl");
   setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
   self.hull = HULL_POINT;
   self.classname = "item_arrows";
   self.count = rint(self.arrows);
};


void () item_arrows =
{

   if (deathmatch) {
      return;
      }

   if (!(self.arrows)) {
self.arrows = 10;

if (bee == 1) {
      self.arrows = rint(5 + (((random()) * 6) - 3));
//      self.arrows = rint(self.arrows);
      }
} 
  self.touch = ArrowsTouch;
   setmodel(self, "models/quiver.mdl");
   setsize(self, '-1 -1 0', '1 1 5');
   self.think = SUB_Remove;
   AdvanceThinkTime(self, 30);
};






void () check_ammo =  {

local string mouse;


if (self.playerclass == CLASS_ASSASSIN) {
mouse = ftos(self.arrows);
  sprint(self, "You have ");
   sprint(self, mouse);
   sprint(self, "  arrows.\n");
}
};


void () check_stuff =  {

local string cat;
if (self.playerclass == CLASS_NECROMANCER) {
   sprint(self, "You has a pie.\n");
}
};
