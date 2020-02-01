void ()monster_werepanther;
void ()monster_mezzoman;
void ()monster_mummy;
void ()monster_medusa;
void ()monster_hydra;
void ()monster_mummy_lord;
void ()monster_fallen_angel;
void ()monster_fallen_angel_lord;
void ()monster_golem_bronze;
void ()monster_golem_iron;
void ()monster_golem_stone;
void ()monster_archer_lord;
void ()monster_skull_wizard_lord;

vector (entity targ, entity forent)find_random_spot =
{
	local vector spot1 = '0.00000 0.00000 0.00000';
	local vector spot2 = '0.00000 0.00000 0.00000';
	local vector spot3 = '0.00000 0.00000 0.00000';
	local vector result  = '0.00000 0.00000 0.00000';
	local vector newangle = '0.00000 0.00000 0.00000';
	local vector enemy_dir = '0.00000 0.00000 0.00000';
	local float loop_cnt = 0.00000;
	local float forward = 0.00000;
	local float dot = 0.00000;
   	trace_fraction = 0.00000;
   	loop_cnt = 0.00000;
	
	result = world.origin;
	
   	do 
	{
	  newangle = targ.angles;
	  newangle_y = random(360.00000);

      makevectors ( newangle);
	  spot1 = targ.origin;

      forward = random((forent.size_x + forent.size_y),200.00000);
      spot2 = (spot1 + (v_forward * forward) + (v_up * forward));
      traceline ( spot1, (spot2 + (v_forward * ((forent.size_x + forent.size_y) * 0.5))), TRUE, targ);
	  
      if ( (trace_fraction == 1.00000) ) {

		 traceline ( spot2, (spot2 - (v_up * (forward * 2.00000))), TRUE, targ);
		 spot2 = trace_endpos;
		 
         makevectors ( newangle);
         tracearea ( spot2, (spot2 + (v_up * 80.00000)), (forent.absmin - forent.origin), (forent.absmax - forent.origin), FALSE, targ);
         if ( ((trace_fraction == 1.00000) && !trace_allsolid) ) {

            spot3 = (spot2 + (v_up * -128.00000));
            traceline ( spot2 + '0 0 128', spot3, FALSE, targ);
            if ( (trace_fraction == 1.00000) ) {

               trace_fraction = 0.00000; //in air
            } else {

               //traceline ( spot1, spot2, FALSE, targ);
			   //if (trace_fraction == 1.00000)
			   if (trace_ent.solid == SOLID_BSP)
			   {
				   trace_fraction = 1.00000;
				   //dprint("BARF32\n");
				   spot2 = trace_endpos + '0 0 2';
				   result = spot2;
			   }
			   /*
               if ( (trace_fraction == 1.00000) ) {

                  setsize ( targ, '-24.00000 -24.00000 0.00000', '24.00000 24.00000 64.00000');
                  targ.hull = 2.00000;
                  targ.solid = SOLID_SLIDEBOX;
                  setorigin ( targ, spot2);
                  if ( walkmove ( targ.angles_y, 0.05000, TRUE) ) {

                     trace_fraction = 1.00000;
                  } else {

                     trace_fraction = 0.00000;

                  }
               } else {

                  trace_fraction = 0.00000;

               }
			   */

            }
         } else {

            trace_fraction = 0.00000;

         }
      } else {

         trace_fraction = 0.00000;

      }
      loop_cnt += 1.00000;
      if ( (loop_cnt > 500.00000) ) {

         //targ.nextthink = (time + 2.00000);
		 //dprint("BARF33\n");
		 //dprintv("", result);
         return world.origin;

      }
   } while ( (trace_fraction != 1.00000) );
   
   return result;
   //targ.think = skullwiz_blinkin1;
   //targ.nextthink = time;
   //sound ( targ, CHAN_VOICE, "skullwiz/blinkin.wav", 1.00000, ATTN_NORM);
   //CreateRedFlash ( (targ.origin + '0.00000 0.00000 40.00000'));
};


void ()spawn_refresh = {
	local float nextaction = 0.1;
	local float total, pc, tmp, layer, step;
	local entity result;
	local entity search;
	local vector pos;
	
//	if ((self.click == 1) || (self.pie == 66)) //necromancy
	if (self.click == 1)
	{
		search = nextent ( world);
		total = 0.00000;
		
		while ( (search != world) ) {
			if (search.flags & FL_CLIENT) {
				if (vlen(search.origin - self.origin) < 2438) {
					total += 1.00000;
				}
						
			}
			search = find ( search, classname, "player");
		
		}
		
		//total = 0.00000;
//		if ((total > 0) && (self.pie != 66))  //necromancy
		if (total > 0)
		{
			nextaction = random(48, 96);
		} else {
			self.click = 0;
			//self.type_index = rint(random(0, (self.lockentity.cnt - 1)));
			//dprintf("max_type: %s\n", self.lockentity.cnt);
			//dprintf("type_index: %s\n", self.type_index);
			result = self.lockentity;
			while ((result.type_index != self.type_index) && (result != world))
			{
				result = result.lockentity;
			}
			
			if (result != world)
			{
				pos = self.origin;
				step = 0.00000;
				layer = 1.00000;
				tmp = 8.00000;
				
				/*
				tracearea ( pos + '0 0 12', pos + '0 0 2', result.mins, result.maxs, FALSE, self);
				while (((trace_ent != world) || (trace_fraction < 1.00000)) && (step < 48))
				{
					local vector dir;

					//dprintf("step: %s", step);
					//dprintf(", layer: %s", layer);
					//dprintf(", tmp: %s\n", tmp);
					
					if (fmod(step, tmp) == 0)
					{
						pos_x = self.origin_x - (result.size_x * layer);
						pos_y = self.origin_y - (result.size_y * layer);
						dir = '1 0 0';
					}
					else
					{
						pos_x = pos_x + (result.size_x * dir_x);
						pos_y = pos_y + (result.size_y * dir_y);
						
						if ( fmod((step - (8 * layer)), ((8 * layer) / 4) * 1) == 0 )
						{
							makevectors(vectoangles(dir));
							dir = (v_right * -1);
						}
					}
					
					
					while (tmp <= step)
					{
						layer += 1;
						tmp += (8 * layer);
						
						pos_x = self.origin_x - (result.size_x * layer);
						pos_y = self.origin_y - (result.size_y * layer);
						dir = '1 0 0';
					}
					
					pc = pointcontents(pos );
					if (pc == CONTENT_EMPTY)
					{
						tracearea ( pos + '0 0 12', pos + '0 0 2', result.mins, result.maxs, FALSE, self);
					}
					
					step += 1;
				}
				*/
				
				total = 0.00000;
				search = findradius (self.origin, 500);
				while (search)
				{
					if (search.flags & FL_MONSTER)
						total += 1;
					
					search = search.chain;
				}
				
				pos = find_random_spot(self, result);
				if ((step < 48) && (total < self.count) && (pos != world.origin))
				{
					particle2 ( pos, '-190.00000 -190.00000 50.00000', '190.00000 190.00000 300.00000', random(243, 246), 17, 80.00000);
					sound ( self, CHAN_AUTO, "skullwiz/push.wav", 1.00000, ATTN_NORM);
					newmis = spawn();
					//newmis.flags2 |= FL_SUMMONED;
					setorigin(newmis, pos);
					newmis.pie = self.pie;
					newmis.skin = result.skin;
					newmis.health = result.health;
					newmis.classname = result.classname;
					AdvanceThinkTime(newmis, 0.1);
					if (newmis.classname == "monster_imp_ice") {
						newmis.think = monster_imp_ice;
					} else if (newmis.classname == "monster_imp_fire") {
						newmis.think = monster_imp_fire;
					} else if (newmis.classname == "monster_archer") {
						newmis.think = monster_archer;
					} else if (newmis.classname == "monster_archer_lord") {
						newmis.think = monster_archer_lord;
					} else if (newmis.classname == "monster_skull_wizard") {
						newmis.think = monster_skull_wizard;
					} else if (newmis.classname == "monster_skull_wizard_lord") {
						newmis.think = monster_skull_wizard_lord;
					} else if (newmis.classname == "monster_scorpion_black") {
						newmis.think = monster_scorpion_black;
					} else if (newmis.classname == "monster_scorpion_yellow") {
						newmis.think = monster_scorpion_yellow;
					} else if (newmis.classname == "monster_spider_yellow_small") {
						newmis.think = monster_spider_yellow_small;
					} else if (newmis.classname == "monster_spider_yellow_large") {
						newmis.think = monster_spider_yellow_large;
					} else if (newmis.classname == "monster_spider_red_small") {
						newmis.think = monster_spider_red_small;
					} else if (newmis.classname == "monster_spider_red_large") {
						newmis.think = monster_spider_red_large;
					} else if (newmis.classname == "monster_golem_stone") {
						newmis.think = monster_golem_stone;
					} else if (newmis.classname == "monster_golem_bronze") {
						newmis.think = monster_golem_bronze;
					} else if (newmis.classname == "monster_golem_iron") {
						newmis.think = monster_golem_iron;
					} else if (newmis.classname == "monster_mezzoman") {
						newmis.think = monster_mezzoman;
					} else if (newmis.classname == "monster_werepanther") {
						newmis.think = monster_werepanther;
					} else if (newmis.classname == "monster_mummy") {
						newmis.think = monster_mummy;
					} else if (newmis.classname == "monster_mummy_lord") {
						newmis.think = monster_mummy_lord;
					} else if (newmis.classname == "monster_fallen_angel") {
						newmis.think = monster_fallen_angel;
					} else if (newmis.classname == "monster_fallen_angel_lord") {
						newmis.think = monster_fallen_angel_lord;
					} else if (newmis.classname == "monster_hydra") {
						newmis.think = monster_hydra;
					} else if (newmis.classname == "monster_medusa") {
						newmis.think = monster_medusa;
					} else {
						remove(newmis);
					}
				}
			}
//necromancy
//			if (self.pie == 66)
//			{
//				newmis.pie = self.pie;
//				newmis.owner = self.controller;
//				newmis.controller = newmis.owner;
//				newmis.team = newmis.owner.team;
//				newmis.goalentity = newmis.owner.enemy;
//				newmis.enemy = newmis.owner.enemy;
//				newmis.monster_awake = TRUE;
//				remove(self);
//			}
		}
	}
	//else if ((self.owner == world) || (self.owner.health < 1)) 
	else
	{
		//nextaction = random(3, 9);
		nextaction = random(2, 4);
		self.click = 1;
	}
	
	AdvanceThinkTime(self, nextaction);
	self.think = spawn_refresh;
};

void (entity subject, entity bestiary)spawnify = {
	subject.pie = 1;  //don't respawn spawned spawners!
	if (subject.solid != SOLID_BSP)
	{
		newmis = spawn();
		newmis.pie = subject.pie;
		newmis.lockentity = bestiary;
		newmis.type_index = 0;
		newmis.count = floor(random(1, ((skill + 1) * 2)));
		newmis.classname = "multispawner";
		while ((bestiary.classname != subject.classname) && (bestiary != world))
		{
			newmis.type_index += 1;
			bestiary = bestiary.lockentity;
		}
		setorigin(newmis, subject.origin);
		newmis.solid = SOLID_NOT;
		newmis.movetype = MOVETYPE_NOCLIP;
		newmis.takedamage = DAMAGE_NO;
		AdvanceThinkTime(newmis, 0.02);
		newmis.think = spawn_refresh;
	}
};


entity (entity subject)monster_template = {
	subject.pie = 1;  //don't respawn spawned spawners!
	newmis = spawn();
	newmis.pie = subject.pie;
	newmis.owner = subject;
	setorigin(newmis, world.origin);
	newmis.skin = subject.skin;
	newmis.health = subject.max_health;
	newmis.classname = subject.classname;
	newmis.controller = subject.controller;
	newmis.size = subject.size;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	return newmis;
};

entity ()scan_monsters = {
	local entity search, result, head;
	search = nextent ( world);
	
	while ( (search != world) ) {
		if ( (search.flags & FL_MONSTER) && (search.pie == 0)) {
			
			if (head == world)
			{
				head = monster_template(search);
				newmis.type_index = 0;
				head.cnt += 1.00000;
			}
			else
			{
				result = head;
				while ((result != world) && (result.classname != search.classname))
				{
					result = result.lockentity;
				}
				
				if (result == world)
				{
					result = head;
					while ((result.lockentity != world) && (result.classname != search.classname))
					{
						result = result.lockentity;
					}
					newmis = monster_template(search);
					newmis.type_index = head.cnt;
					result.lockentity = newmis;
					head.cnt += 1.00000;
				}
			}
			
		}

		search = nextent ( search);
	
	}
	return head;
	dprintf ( "Found %s monster types\n", head.cnt);
};

void ()multiply_monsters = {
	local entity bestiary;
	local entity search;
	local float total = 0.00000;
	local float type_count = 0;
	
	search = find ( world, classname, "multispawner");
	while (search)
	{
		//search.count = 64;
		search.count = floor(random(1, ((skill + 1) * 2)));
		search = find ( search, classname, "multispawner");
	}
	if (search == world)
	{
		bestiary = scan_monsters();
		
		search = nextent ( world);
		
		total = 0.00000;
		while ( (search != world) ) {
			//if ( (search.flags & FL_MONSTER) && (search.pie == 0) && (!(search.spawnflags & ONWALL) && (vlen(search.origin - self.origin) < 100)) ) {
			if ( (search.flags & FL_MONSTER) && (search.pie == 0) && (!(search.spawnflags & ONWALL)) ) {
				total += 1.00000;
				spawnify(search, bestiary);
			}

			search = nextent ( search);
		}
		
		dprintf ( "Found %s monsters\n", total);
	}

};

