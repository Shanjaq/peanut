void() SlideRise;
void(entity holdy)hold;

void ()slide_pull =
{
	local float grap;
	local vector pull;
	local float  pull_speed;
	local entity head;
	
	grap = (self.scale*100);
	head = findradius ( self.origin, grap);
	
	while (head)
	{
		pull = self.origin - head.origin;
		
		if (head.classname == "spire_trap") {
			sound ( self, CHAN_VOICE, "golem/stomp.wav", 1.00000, ATTN_NORM);
			hold(head);
			head.think = SUB_Remove;
			head.nextthink = (time + 0.02);
		}

		if((grap>0) && (head != world) && (head.solid != SOLID_BSP) && (head.takedamage == DAMAGE_YES) && (head.health > -1.00000))
		{
			//TODO: change 400 to whatever maximum
			//speed you want. Actual speed is inversely proportional
			//to distance. At distace=radius, speed will be 0
			pull_speed = (1-vlen(pull)/grap)*2;
			normalize(pull);
			pull *= pull_speed;

			if ((head.health<2) && (head.lip == 0)) {
				if (head.classname == "monster_archer") {
					sound ( self, CHAN_VOICE, "crushme.wav", 1.00000, ATTN_NORM);
					head.lip = 1;
				}
				if (head.classname == "monster_archer_lord") {
					sound ( self, CHAN_VOICE, "crushme.wav", 1.00000, ATTN_NORM);
					head.lip = 1;
				}
				if (head.classname == "monster_mezzoman") {
					sound ( self, CHAN_VOICE, "crushme.wav", 1.00000, ATTN_NORM);
					head.lip = 1;
				}
				if (head.classname == "monster_werepanther") {
					sound ( self, CHAN_VOICE, "crushme.wav", 1.00000, ATTN_NORM);
					head.lip = 1;
				}
				if (head.classname == "player") {
					sound ( self, CHAN_VOICE, "crushme.wav", 1.00000, ATTN_NORM);
					head.lip = 1;
				}

				AdvanceThinkTime(head,0.01);
				if (head.classname != "player") {
					head.think = SUB_Remove;
					remove(head);
				}
			}
			
			if (head != self.owner)
				T_Damage ( head, self, self.owner, self.spelldamage*0.36250);
			
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			head.velocity += pull;
		}
		
		head = head.chain;
	}
	
	AdvanceThinkTime(self,0.01);
	self.think = SlideRise;
};





void ()rock_crash = {
	if (self.scale < 0.1) {
		AdvanceThinkTime(self,0.1);
		self.think = SUB_Remove;
	} else {
		self.scale -= 0.05;
		self.think = rock_crash;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};


void ()rock_timer = {
	if (self.ltime>0) {
		self.ltime -= 1;
		self.think = rock_timer;
		self.nextthink = (time + 0.5);
	} else {
		self.think = rock_crash;
		self.nextthink = (time + 0.02);
	}
};

void ()rock_bounce = {
	if (self.flags & FL_ONGROUND) {
		self.solid = SOLID_NOT;
	} else {
		if (self.cnt>0) {
			if (other.takedamage == TRUE) {
				sound ( self, CHAN_VOICE, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
				self.cnt = (self.cnt + 0);
			} else {
				self.cnt = (self.cnt - 1);
				sound (self, CHAN_VOICE, "misc/sshatter.wav", 1, ATTN_NORM);
				particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(48, 63), PARTICLETYPE_FASTGRAV, random(8.00000, 16.00000));
				
				//T_RadiusDamage ( self, self.owner, (self.scale * 10), self);
			}
		}
		self.think = rock_timer;
		self.nextthink = (time + 0.02);
		if ((other.takedamage == TRUE) && (other != self.owner)) {
			T_Damage ( other, self, self.owner, (self.spelldamage*vlen(self.velocity))*0.00125);
		} else {
			self.think = rock_crash;
			self.nextthink = (time + 0.02);
		}
	}
};


void (float bigness)rock_launch = {
	local float flak;
	local vector random_vector;

	random_vector_x = random((bigness * -125),(bigness * 125));
	random_vector_y = random((bigness * -125),(bigness * 125));
	random_vector_z = random(5,(bigness * 75));
	local entity rock;
	
	if (pointcontents(self.origin + random_vector) == CONTENT_EMPTY)
	{
		particle2 ( self.origin + (random_vector + random('-64 -64 0', '64 64 24')), '-64.00000 -64.00000 50.00000', '64.00000 64.00000 100.00000', random(112, 127), PARTICLETYPE_FASTGRAV, random(12.00000, 32.00000));
		flak = random();
		rock = spawn();
		rock.spelldamage = self.spelldamage;
		setorigin (rock, self.origin + random_vector);
		rock.velocity = random('-500 -500 -30','500 500 150'); // notice the accent on the up velocity
		rock.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
		sound (rock, CHAN_VOICE, "fx/wallbrk.wav", 1, ATTN_NORM);
		rock.cnt = 7;
		rock.ltime = 10;
		rock.owner = self.owner;
		rock.movetype = MOVETYPE_BOUNCE;
		rock.solid = SOLID_PHASE;
		rock.touch = rock_bounce;
		rock.scale = random(0.80000,2.40000);
		if (flak<0.8) {
			setmodel ( rock, "models/schunk1.mdl");
		} else {
			if (flak<0.6) {
				setmodel ( rock, "models/schunk2.mdl");
			}
			if (flak<0.4) {
				setmodel ( rock, "models/schunk3.mdl");
			}
			if (flak<0.2) {
				setmodel ( rock, "models/schunk4.mdl");
			} else {
				setmodel ( rock, "models/schunk2.mdl");
			}
		}
		rock.think = rock_timer;
		rock.nextthink = (time + 0.02);
	}
};


.float trop;

void ()SlideBurst = {
	if (self.trop<3) {
		self.frame = 10;
	} else {
		if (self.trop<6) {
			self.frame = 9;
		} else {
			if (self.trop<9) {
				self.frame = 8;
			} else {
				if (self.trop<12) {
					self.frame = 7;
				} else {
					if (self.trop<14) {
						self.frame = 6;
					} else {
						if (self.trop<16) {
							self.frame = 5;
						} else {
							if (self.trop<18) {
								self.frame = 4;
							} else {
								if (self.trop<20) {
									self.frame = 3;
								} else {
									if (self.trop<22) {
										self.frame = 2;
									} else {
										if (self.trop<24) {
											self.frame = 1;
										} else {
											self.frame = 0;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	if (self.trop>25) {
		remove (self);
		return;
	} else {
		if (self.scale< 0.6) {
			self.scale = 0.5;
		} else {
			self.scale = (self.scale - 0.1);
		}
		self.trop += 1;
		rock_launch(self.scale);
		self.think = SlideBurst;
		self.nextthink = (time + 0.08);
	}
};



void ()SlideRise = {
	if (self.scale>(1.60000*self.spellradiusmod)) {
		self.trop = rint(24 - (16 * self.spellradiusmod));
		self.think = SlideBurst;
		self.nextthink = (time + 0.7);
	} else {
		self.scale = (self.scale + 0.2);
		self.think = slide_pull;
		self.nextthink = (time + 0.2);
	}
};

void ()SlideHit = {
	MonsterQuake ( 400.00000, self); 
	sound ( self, CHAN_VOICE, "thnd2.wav", 1.00000, ATTN_NORM);
	sound ( self, CHAN_AUTO, "thnd2.wav", 1.00000, ATTN_NORM);
	setmodel (self, "models/lslide.mdl");
	self.movetype = MOVETYPE_FLY;
	setorigin (self, (self.origin + '0 0 20'));
	self.frame = 0;
	AdvanceThinkTime(self,0.1);
	self.think = SlideRise;
};

void ()SlideDrop = {
	self.magic_finished = (time + 3);
	makevectors(self.angles);
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.trop = 0;
	traceline (self.origin , (self.origin-('0 0 600')) , TRUE , self);
	setorigin(newmis, trace_endpos);
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NONE;
	newmis.scale = 0.2;

	newmis.think = SlideHit;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};

//		particle2 ( (self.origin + random('-30 -30 0', '30 30 100')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(160, 175), 2, 80.00000);
