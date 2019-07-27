void () item_coins;

void () CoinsTouch =
{
   	local string mon;


   	if ((other.classname) != "player") 
	{
      	return;
      }

   	if ((other.health) <= 0) 
	{
      	return;
      }
   	mon = ftos(self.money);
   	sprint(other, "You get ");
   	sprint(other, mon);
   	sprint(other, " gold coins\n");
   	other.money = (other.money) + (self.money);

/*
   	if ((other.money) > 100000) 
	{
      	other.money = 100000;
      }
*/
   	sound(other, 3, "player/money.wav", 1, 1);
   	stuffcmd(other, "bf\n");

	remove(self);
};


void (entity who) ThrowMoney =
{
   local entity coins;

   coins = spawn();
   coins.owner = who;
   setorigin(coins, (who.origin) - '0 -30 -24');
   coins.money = who.money;
   coins.velocity_z = 300;
   coins.velocity_x = -100 + ((random()) * 200);
   coins.velocity_y = -100 + ((random()) * 200);
   coins.avelocity = '0 600 0';
   coins.flags = 256;
   coins.solid = 1;
   coins.movetype = MOVETYPE_BOUNCE;
   setmodel(coins, "models/gold.mdl");
   setsize(coins, '-1 -1 0', '1 1 5');
   coins.touch = item_coins;
   coins.think = item_coins;
   AdvanceThinkTime(coins, 10);

};


void  (float amount)spawn_item_coins =  {
  if (deathmatch) {
      return;
      }

   if (!(self.money)) {
      self.money = 10 + (((random()) * 6) - 3);
  //    self.money = rint(self.money);
      }

   self.touch = CoinsTouch;
   setmodel ( self, "models/gold.mdl");
   setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
   self.hull = HULL_POINT;
   self.classname = "item_coins";
   self.count = rint(self.money);
 //  self.netname = STR_COINS;
//   StartItem ( );
};


void () item_coins =
{

   	if (deathmatch) 
	{
      	return;
      }
   	if (!(self.money)) 
	{
      	self.money = 10 + (((random()) * 6) - 3);
      	self.money = rint(self.money);
	} 

//self.money = 100;

 //     } 

   self.touch = CoinsTouch;
   setmodel(self, "models/gold.mdl");
   setsize(self, '-1 -1 0', '1 1 5');
   self.think = SUB_Remove;
   AdvanceThinkTime(self, 30);
  // StartItem();

};


void () item_bigpile =
{

   if (deathmatch) {
      return;
      }
   precache_model("models/gold.mdl");

   if (!(self.money)) {
      self.money = 50 + (((random()) * 10) - 5);
      self.money = rint(self.money);
      }
   self.solid = 1;
   self.movetype = MOVETYPE_BOUNCE;
   self.touch = CoinsTouch;
   setmodel(self, "models/gold.mdl");
   setsize(self, '-12 -12 0', '12 12 8');
 //  StartItem();
};


void () check_money =  
{

	local string cat;

	cat = ftos(self.money);

  	sprint(self, "You have ");
  	sprint(self, cat);
   	sprint(self, " gold coins\n");

};
