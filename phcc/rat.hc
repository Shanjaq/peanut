void  ()rat_wait;
void  (float vol)rat_sound;
void  ()rat_wander;

void  ()rat_die_wait =  {

	if ( (self.health < -80.00000) ) {

		chunk_death ( );
		return ;

	}
	if ( !self.velocity ) {

		if ( (random() < 0.50000) ) {

			self.angles_x = 0.00000;
		} else {

			self.angles_x = 180.00000;

		}
		self.avelocity = '0.00000 0.00000 0.00000';
		MakeSolidCorpse ( );
		return ;
	} else {

		self.think = rat_die_wait;
		AdvanceThinkTime(self,0.50000);

	}
};


void  ()rat_death =  {

	local vector bounce_vel = '0.00000 0.00000 0.00000';
	if ( (self.health < -80.00000) ) {

		chunk_death ( );
		return ;

	}
	bounce_vel = normalize ( (self.origin - damage_attacker.origin));
	bounce_vel_x *= random((self.health * -30.00000));
	self.velocity = bounce_vel;
	self.velocity_z = random(150.00000,450.00000);
	self.flags ^= FL_ONGROUND;
	self.movetype = MOVETYPE_BOUNCE;
	self.avelocity_x = (random((self.health * 10.00000)) - self.health);
	self.avelocity_y = (random((self.health * 10.00000)) - self.health);
	self.avelocity_z = (random((self.health * 10.00000)) - self.health);
	self.think = rat_die_wait;
	AdvanceThinkTime(self,0.00000);
};


void  ()rat_stupor =  {
	self.angles_y += random(-2.00000,2.00000);
	self.frame = random(17.00000);
	self.think = rat_wait;
	AdvanceThinkTime(self,random(0.30000,1.30000));
};


void  (float dist)rat_move =  {
	/*
	local vector best_yaw = '0.00000 0.00000 0.00000';
	best_yaw = normalize ( (self.goalentity.origin - self.origin));
	best_yaw = vectoangles ( best_yaw);
	self.ideal_yaw = best_yaw_y;
	ChangeYaw ( );
	movetogoal ( dist);
	pitch_roll_for_slope ( '0.00000 0.00000 0.00000');
	//walkmove ( self.angles_y, dist, FALSE);
	*/
   //ai_walk ( (self.speed / 2.00000));
  //AdvanceFrame( 1.00000, 17.00000);
  if (self.frame >= 16)
	  self.frame = 0;
  else
	  self.frame += 2;
  
  //movetogoal ( 3);
  //walkmove ( self.angles_y, 3, FALSE);
  //ai_walk ( self.speed);
  movetogoal ( self.speed);
  //dprint("self.goalentity: ");
  //dprint(self.goalentity.classname);
  //dprint("\n");
  
   //ai_walk ( (3.00000));
  // if ((random() < 0.10000))
  //    pitch_roll_for_slope ( '0.00000 0.00000 0.00000');
	
};

void  ()rat_think =  {
	local entity nearest;
	MonsterCheckContents ( );
	if (time > self.lifetime) {
		remove(self);
		return;
	}
	
	//dprint("BARF21\n");
	if ( self.goalentity != world ) {
		//dprint("BARF22\n");
		//dprint(self.goalentity.classname);
		//dprint("\nisAlive: ");
		//dprint(ftos(self.goalentity.flags2 & FL_ALIVE));
		//dprint("\n");
		
		if (self.goalentity == self.controller)
		{
	//dprint("BARF23\n");
			
			self.dest = (self.goalentity.origin - self.origin);
			if (vlen(self.dest) <= 100.00000)
			{
	//dprint("BARF24\n");
				self.think = rat_wait;
				self.th_stand = rat_wait;
				self.th_walk = rat_wait; //shan
			}
			else
			{
	//dprint("BARF25\n");
				self.th_stand = rat_stupor;
				self.th_walk = rat_move;
				//movetogoal (self.speed);
				self.th_walk();
			}
			
			droptofloor ( );
			nearest = findNearestHurtable(self.origin, 500.00000, 0, FL_ALIVE, FALSE);
			if (nearest != world)
			{
				/*
					dprint("BARF26 - ");
					dprint("nearest.netname: ");
					dprint(nearest.netname);
					dprint("\n");
				*/
				self.goalentity = nearest;
				self.enemy = nearest;
			}
		}
		else 
		{
	//dprint("BARF27\n");
			if (!(self.goalentity.flags2 & FL_ALIVE))
			{
	//dprint("BARF28\n");
				droptofloor ( );
				nearest = findNearestHurtable(self.origin, 500.00000, 0, FL_ALIVE, FALSE);
				if (nearest != world)
				{
					/*
					dprint("BARF43 - ");
					dprint("nearest.netname: ");
					dprint(nearest.netname);
					dprint("\n");
					*/
					self.goalentity = nearest;
					self.enemy = nearest;
				}
				else
				{
					self.goalentity = self.controller;
					self.enemy = self.controller;
				}
			}
			
			self.dest = (self.goalentity.origin - self.origin);
			//if (infront ( self.goalentity))
			if (vlen(self.dest) <= 32.00000)
			{
	//dprint("BARF29\n");
				if (time > self.attack_finished)
				{
	//dprint("BARF30\n");
					if (random() < 0.5)
					{
	//dprint("BARF31\n");
						self.frame = random(17.00000);
						self.last_attack = time;
						self.attack_state = AS_MELEE;
						self.th_melee();
					}
					else
					{
	//dprint("BARF32\n");
						if ( !walkmove ( self.angles_y, 3.00000, FALSE) )
						{
	//dprint("BARF33\n");
							sheep_turn ( ); //shan borrowing this
						}
					}
				}
			}
			else
			{
	//dprint("BARF34\n");
				self.th_walk();//movetogoal (self.speed);
				//if ( !walkmove ( self.angles_y, 3.00000, FALSE) )
				//{
				//	sheep_turn ( ); //shan borrowing this
				//}
			}
		}
	} else {
	//dprint("BARF35\n");
		if (self.controller)
		{
	//dprint("BARF36\n");
			nearest = findNearestHurtable(self.origin, 512.00000, 0, FL_ALIVE, FALSE);
			if (nearest != world)
			{
				/*
					dprint("BARF37 - ");
					dprint("nearest.netname: ");
					dprint(nearest.netname);
					dprint("\n");
					*/
				self.goalentity = nearest;
				self.enemy = nearest;
			}
			else
			{
	//dprint("BARF38\n");
				self.goalentity = self.controller;
				self.enemy = self.controller;
			}
			droptofloor ( );
		} else {
	//dprint("BARF39\n");
			//if ( !walkmove ( self.angles_y, 3.00000, FALSE) ) {
	//dprint("BARF40\n");
			//	sheep_turn ( ); //shan borrowing this
			//}
			self.th_walk();
		}
	}
	if ((self.controller.classname != "player") && (self.controller.enemy != world))
	{
	//dprint("BARF41\n");
		self.goalentity = self.controller.enemy;
		self.enemy = self.controller.enemy;
	}
	if ( (((random() < 0.10000) && (random() < 0.20000)) && (self.pain_finished < time)) ) {
	//dprint("BARF42\n");

		rat_sound ( random(0.20000,0.80000));

	}
	self.think = rat_think;
	AdvanceThinkTime(self,HX_FRAME_TIME);
};


void  ()rat_wait =  {
	if (self.goalentity) {
		if ( (vlen ( (self.goalentity.origin - self.origin)) > 64.00000) ) {
			self.think = rat_think;
			self.th_stand = rat_stupor;
			//self.th_walk = rat_think;
			self.th_walk = rat_move;
		}
	} else {
		self.think = rat_think;
		self.th_stand = rat_stupor;
		//self.th_walk = rat_think;
		self.th_walk = rat_move;

	}
	AdvanceThinkTime(self,0.25000);
};


void  (float vol)rat_sound =  {

	sound ( self, CHAN_VOICE, "misc/squeak.wav", vol, ATTN_NORM);
	self.pain_finished = (time + random(1.00000,12.00000));
};


void  ()rat_touch =  {

	return ;
};

void ()rat_wander = {
	/*	
goaldir = vectoangles(self.origin - (self.goalentity.origin+random('-120 -120 0', '120 120 0')));
makevectors (self.angles);

local vector goaldir = '0.00000 0.00000 0.00000';
goaldir = vectoangles(self.origin - (self.goalentity.origin+random('-120 -120 0', '120 120 0')));
//goaldir = self.angles;
//goaldir_y = self.ideal_yaw;
makevectors ( goaldir);
//setorigin ( self.goalentity, (self.origin + (v_forward * 1000.00000)));
//setorigin ( self.goalentity, (self.origin + (v_forward * random(100, 1000.00000)) + (v_right * random(-1000, 1000))));
	traceline ( self.origin, (v_vorward * 1000), FALSE, self);
	//trace_endpos
	setorigin ( self.goalentity, trace_endpos);
	
*/
	local vector best_yaw = '0.00000 0.00000 0.00000';
	best_yaw = normalize ( (self.goalentity.origin - self.origin));
	best_yaw = vectoangles ( best_yaw);
	self.ideal_yaw = best_yaw_y;
	ChangeYaw ( );
	//movetogoal ( 3 );
};

/*
void  ()rat_make_goal =  {

local vector goaldir = '0.00000 0.00000 0.00000';
goaldir = self.angles;
goaldir_y = self.ideal_yaw;
makevectors ( goaldir);
newmis = spawn ( );
newmis.effects = EF_NODRAW;
setmodel ( newmis, "models/null.spr");
setorigin ( newmis, (self.origin + (v_forward * 1000.00000)));
self.goalentity = newmis;
newmis.classname = "tempgoal";
AdvanceThinkTime(newmis,30.00000);
newmis.think = SUB_Remove;
};
*/


void  ()rat_go =  {

	//self.th_stand = rat_think;
	self.th_walk = rat_move;
	self.th_run = rat_move;
	self.think = rat_think;
	AdvanceThinkTime(self,0.00000);
};


void  ()monster_rat =  
{
	if ( (self.flags2 & FL_SUMMONED) ) 
	{
		self.th_stand = rat_stupor;
		self.th_walk = rat_move;
		self.lifetime = (time + random(14.00000, 18.00000));
		self.goalentity = self.controller;
		self.use = rat_go;
	} 
	else 
	{
		precache_model ( "models/rat.mdl");
		precache_sound ( "misc/squeak.wav");
		self.th_stand = rat_stupor;
		//self.th_walk = rat_stupor;
		//self.th_stand = rat_think;
		self.th_walk = rat_move;
		//self.th_walk = rat_think;
		self.use = rat_go;
		self.lifetime = (time + random(5.00000,12.00000));
	}
	setmodel ( self, "models/rat.mdl");
	self.movetype = MOVETYPE_STEP;
	self.solid = SOLID_SLIDEBOX;
	if ( (pointcontents ( self.origin) != CONTENT_EMPTY) ) 
	{
		self.flags |= FL_SWIM;
		self.angles_x = 10.00000;
	}
	self.touch = obj_push;
	self.flags |= FL_PUSH;
	self.flags2 |= FL_ALIVE;
	self.classname = "monster_rat";
	setsize ( self, '-3.00000 -3.00000 0.00000', '3.00000 3.00000 7.00000');
	self.view_ofs = '0.00000 0.00000 7.00000';
	self.health = 25.00000;
	self.thingtype = THINGTYPE_FLESH;
	self.th_run = rat_move;
	self.th_melee = monster_sheep_bite;
	//self.th_missile = rat_think;
	self.th_pain = rat_sound;
	self.th_die = rat_death;
	self.think = rat_think;	
	self.flags |= FL_MONSTER;
	self.yaw_speed = 10.00000;
	self.speed = 6.00000;
	self.mass = 1.00000;
	self.mintel = 5.00000;
	AdvanceThinkTime(self,0.25000);

	/*
	player = find ( world, classname, "player");
	while ( player ) 
	{
		self.target = player;
	}
	*/
	
	walkmonster_start ( );
};


void  ()monster_ratnest =  {

	precache_model ( "models/rat.mdl");
	precache_sound ( "misc/squeak.wav");
	self.use = barrel_die;
};

