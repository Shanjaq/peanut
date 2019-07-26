void() AlarmCheck =
{
	local float customers;
	local entity found;

	if ((self.target != "") && (self.goalentity == world))
	{
		found = find ( world, targetname, self.target);
		while (found)
		{
			if (self.goalentity == world)
			{
				self.goalentity = found;
			}
			
			found = find ( found, targetname, self.target);
		}
	}
	
	if (self.lip == 0.00000)
	{
		found = nextent(world);
		while (found)
		{
			if (found.touch == artifact_touch)
			{
				//dprint(found.classname);
				//dprint("\n");
				item_spawnify(found);
			}
			found = nextent(found);
		}
		
		self.lip = 1.00000;
	}
	
	customers = 0;
	found = find ( world, classname, "player");
	while (found)
	{
		if ((vlen(found.origin - self.origin) < self.delay) )
		{
			found.predebt = 1;
			if ((found.debt > 0) && (self.goalentity != world))
			{
				customers += 1;
			}
		}
		else
		{
			found.predebt = 0;
		}
		
		found = find ( found, classname, "player");
	}
	
	if (customers > 0)
	{
		if (self.goalentity.inactive != 0)
			self.goalentity.inactive = 0;
	}
	else if ((self.goalentity != world) && (self.goalentity.inactive != 1))
		self.goalentity.inactive = 1;
	
	AdvanceThinkTime(self, 0.50000);
	self.think = AlarmCheck;

};

void() DropAlarm =
{
	self.think = AlarmCheck;
	AdvanceThinkTime(self, 3.00000);
};
