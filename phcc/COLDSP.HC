
void ()coldsp_crash = {
	SprayIce();
};


void ()coldsp_timer = {
	if (time < self.splash_time) {
		particle2 ( self.origin, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (144.00000 + random(15.00000)), PARTICLETYPE_SLOWGRAV, 2.00000);
		particle2 ( self.origin, '-1.00000 -1.00000 -1.00000', '1.00000 1.00000 1.00000', (144.00000 + random(15.00000)), PARTICLETYPE_SLOWGRAV, 3.00000);
		self.think = coldsp_timer;
		self.nextthink = (time + 0.05);
	} else {
		self.think = coldsp_crash;
		self.nextthink = (time + 0.02);
	}
};

void ()coldsp_bounce = {
	self.dmg = self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500);
	if (self.cnt>0) {
		particle2 ( self.origin, '-100.00000 -100.00000 -100.00000', '100.00000 100.00000 100.00000', (144.00000 + random(15.00000)), PARTICLETYPE_SLOWGRAV, random(24.00000, 48.00000));
		particle2 ( self.origin, '-128.00000 -128.00000 -128.00000', '128.00000 128.00000 128.00000', (144.00000 + random(15.00000)), PARTICLETYPE_SLOWGRAV, random(12.00000, 24.00000));
		if (other.takedamage == TRUE) {
			sound ( self, CHAN_VOICE, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
			self.cnt = (self.cnt + 0);
			
			if ( ((((((other.health <= self.dmg) || (((other.classname == "player") && (other.frozen <= -5.00000)) && (other.health < 200.00000))) && (other.solid != SOLID_BSP)) && !(other.artifact_active & ART_INVINCIBILITY)) && (other.thingtype == THINGTYPE_FLESH)) && (other.health < 100.00000)) )
			{
				SnowJob ( other, self.owner);
			}
			else if (other.frozen <= 0)
			{
				if (other != self.owner)
					T_Damage ( other, self, self.owner, self.dmg);
			}
		}
		else
		{
			self.cnt = (self.cnt - 1);
			sound (self, CHAN_VOICE, "misc/tink.wav", 1, ATTN_NORM);
			IceBoom((128*self.spellradiusmod), (self.spelldamage/2) + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
		}
		self.think = coldsp_timer;
		self.nextthink = (time + 0.02);
	}
	else
	{
		IceBoom(128, (self.spelldamage/2) + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
		self.think = coldsp_crash;
		self.nextthink = (time + 0.02);
	}
};

void ()coldsp_launch = {
	local entity coldsp;

	makevectors (self.angles);
	coldsp = spawn();
	coldsp.spelldamage = self.spelldamage;
	coldsp.spellradiusmod = self.spellradiusmod;
	//traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	setorigin (coldsp, self.origin);

	sound (self, CHAN_WEAPON, "catfire.wav", 1, ATTN_NORM);
	coldsp.cnt = 7;
	coldsp.lifetime = 12.00000;
	coldsp.splash_time = (time + coldsp.lifetime);
	coldsp.owner = self.owner;
	coldsp.movetype = MOVETYPE_BOUNCEMISSILE;
	coldsp.solid = SOLID_PHASE;
	coldsp.touch = coldsp_bounce;
	coldsp.scale = 0.5;
	setmodel ( coldsp, "models/iceboom.mdl");
	coldsp.drawflags |= MLS_ABSLIGHT;
	coldsp.abslight = 1;
	setsize(coldsp, '0 0 0', '0 0 0');
	coldsp.velocity = (v_forward * 750);

	//coldsp.think = coldsp_timer;
	coldsp.think = coldsp_timer;
	coldsp.nextthink = (time + 0.02);
};
