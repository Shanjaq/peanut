
void() Regen_HealPlayer = 
{
	local entity beamer;
	local float beamercount;
	local vector beamerorigin;

	
	if (time < self.splash_time)
	{
		traceline (self.controller.origin, (self.controller.origin - '0 0 40'), TRUE, self.controller);
		if ((self.controller.origin_z - trace_endpos_z) < 10) {
			particle2 ( (self.controller.origin + random('-30 -30 0', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(243, 246), 2, 10.00000);

			if (self.controller.health < self.controller.max_health&&self.controller.deadflag == FALSE)
			{
				self.controller.health += 2;
		
				beamercount = random(1,3);
				dprint("BARF1");
				
				// Launch a beam of green light upwards
				while (beamercount > 0)
				{
					dprint("BARF2");
					beamer = spawn();
					beamerorigin_x = self.controller.origin_x + random(-24, 24);
					beamerorigin_y = self.controller.origin_y + random(-24, 24);
					beamerorigin_z = self.controller.origin_z - 15;
		
					setorigin(beamer, beamerorigin);
					setmodel(beamer, "models/stclrbm.mdl");
					beamer.skin = 2;
					beamer.scale = random(0.5,2.5);
					beamer.movetype = MOVETYPE_FLYMISSILE;
					beamer.solid = SOLID_NOT;
					beamer.velocity = '0 0 150';
					beamer.angles = '90 0 0';
					beamer.drawflags = MLS_ABSLIGHT;
					beamer.abslight = 0.5;
					beamer.nextthink = time + 1.5;
					beamer.think = SUB_Remove;
			
					beamercount -= 1;
				}
			}
		} else {
			centerprint(self.controller, "Telluric Current interrupted!@@Regeneration canceled...");
			remove(self);
			return;
		}


		self.think = Regen_HealPlayer;
		AdvanceThinkTime(self, 0.50000);
		
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void() TelluricRegen =
{
	local entity regener, found;

	found = find(world, classname, "telluric regeneration");
	while ( found ) {
		if ((found != world) && (found.controller == self.owner))
		{
			centerprint(self.owner, "Telluric Current is already flowing at your feet!");
			self.owner.elemana += self.owner.spellcost;
			return;
		}
		
		found = find ( found, classname, "telluric regeneration");
	}

	regener = spawn();
	regener.owner = self.owner;
	setorigin(regener, self.origin);
	//self.movechain = regener;
	regener.controller = self.owner;
	regener.classname = "telluric regeneration";
	regener.lifetime = 60.00000;	//The effect lasts for a minute
	regener.splash_time = (time + regener.lifetime);
	regener.nextthink = time + 0.5;
	regener.think = Regen_HealPlayer;
};
