void  (vector spot)CreateYRFlash;
void  (vector org,vector vel,float framelength)CreateWhiteSmoke;
void  ()make_bloodcount_reset;
void  (entity forent, float status_effect, float damage, float duration)apply_status;
entity (entity forent, float query_flags)status_controller_get;

.float ftype;
void  (vector slope)pitch_roll_for_slope;
void  (entity inflictor,entity attacker,float damage,entity ignore)T_RadiusDamage;
entity (entity inflictor, entity attacker, float damage, float radius, entity ignore, float vis)T_RadiusDamageFlat;



void  (float dm)ThrowSolidHead;

void  ()blood_splatter =  {
	SpawnPuff ( self.origin, (normalize ( self.velocity) * -20.00000), 10.00000, self);
	remove ( self);
};


void  (vector org,vector dir)ThrowBlood =  {
	local entity blood;
	blood = spawn_temp ( );
	blood.ltime = time;
	blood.solid = SOLID_BBOX;
	blood.movetype = MOVETYPE_TOSS;
	blood.touch = blood_splatter;
	blood.velocity = dir;
	blood.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	blood.thingtype = THINGTYPE_FLESH;
	setmodel ( blood, "models/bldspot4.spr");
	setsize ( blood, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( blood, org);
};


void  (vector spot,vector normal,float scaling,float face,float roll)ZeBrains =  {
	newmis = spawn ( );
	newmis.scale = scaling;
	newmis.angles = vectoangles ( normal);
	if ( face ) {

		newmis.angles_y += 180.00000;

	}
	newmis.angles_z = roll;
	setmodel ( newmis, "models/brains.mdl");
	setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( newmis, (spot + (normal * 1.00000)));
	newmis.think = corpseblink;
	AdvanceThinkTime(newmis,30.00000);
	spot = newmis.origin;
	makevectors ( normal);
	ThrowBlood ( spot, (((normal + (random(0.75000,0.75000) * v_up)) + (random(0.75000,0.75000) * v_right)) * random(200.00000,400.00000)));
	ThrowBlood ( spot, (((normal + (random(0.75000,0.75000) * v_up)) + (random(0.75000,0.75000) * v_right)) * random(200.00000,400.00000)));
	ThrowBlood ( spot, (((normal + (random(0.75000,0.75000) * v_up)) + (random(0.75000,0.75000) * v_right)) * random(200.00000,400.00000)));
	ThrowBlood ( spot, (((normal + (random(0.75000,0.75000) * v_up)) + (random(0.75000,0.75000) * v_right)) * random(200.00000,400.00000)));
	ThrowBlood ( spot, (((normal + (random(0.75000,0.75000) * v_up)) + (random(0.75000,0.75000) * v_right)) * random(200.00000,400.00000)));
};


void  ()ChunkRemove =  {
	if (self.classname == "bloodspot") {
		bloodcount -= 1;
		SUB_Remove ( );
	} else {
		chunk_cnt -= 1.00000;
		SUB_Remove ( );
	}
};


// BAER ALL NEW CODE
void () ChunkShrink = 
{
	if (self.abslight > 1.1) {
		self.abslight -= 0.01;
		if (self.classname != "tsunami") {
			self.dmg = ((self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.06250)*self.abslight;
			particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 140.00000, 16, random(1, 15));
			T_RadiusDamageFlat (self, self.owner, self.dmg, (26.00000*self.abslight), self.owner, FALSE);
			//T_RadiusDamage (self, self.owner, (self.abslight * 18), other);
		}
	} else {
		self.scale -= 0.05;
	}

	if ((self.classname == "blackhole") && (self.scale < (0.75 * self.spellradiusmod))) {
		self.drawflags ^= DRF_TRANSLUCENT;
	}
	if (self.scale < 0.1) {
		if ((self.classname == "blackhole") || (self.classname == "basher") || (self.classname == "flame") || (self.classname == "slimespot"))
			remove(self);
		else
			ChunkRemove();
		
	}
	self.think = ChunkShrink;
	self.nextthink = time + HX_FRAME_TIME;

};
// BAER End of new code

vector  ()ChunkVelocity =  {
	local vector v = '0.00000 0.00000 0.00000';
	v_x = (300.00000 * crandom ( ));
	v_y = (300.00000 * crandom ( ));
	v_z = random(100.00000,400.00000);
	v = (v * 0.70000);
	return ( v );
};


void  (string chunkname,vector location,float life_time,float skinnum)ThrowSingleChunk =  {
	local entity chunk;
	if ( (chunk_cnt < CHUNK_MAX) ) {

		chunk = spawn_temp ( );
		setmodel ( chunk, chunkname);
		chunk.frame = 0.00000;
		setsize ( chunk, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
		chunk.movetype = MOVETYPE_BOUNCE;
		chunk.solid = SOLID_NOT;
		chunk.takedamage = DAMAGE_NO;
		chunk.velocity = ChunkVelocity ( );
		chunk.think = ChunkRemove;
		chunk.flags ^= FL_ONGROUND;
		chunk.origin = location;
		chunk.avelocity_x = random(10.00000);
		chunk.avelocity_y = random(10.00000);
		chunk.avelocity_z = random(30.00000);
		chunk.skin = skinnum;
		chunk.ltime = time;
		AdvanceThinkTime(chunk,life_time);
		chunk_cnt += 1.00000;

	}
};

void() blood_mist = {
	self.lip = (1.00000 - ((self.splash_time - time) / self.lifetime)) * self.cscale;
	if (time < self.splash_time) {
		CreateYRFlash ( self.origin + random(('-1 -1 -2' * self.lip), ('1 1 0' * self.lip)));
		self.think = blood_mist;
		AdvanceThinkTime(self, 0.4);
	} else {
		remove(self);
		return;
	}
};



void() blood_drop_timer = {
	pitch_roll_for_slope('0.00000 0.00000 0.00000');
	if (time < self.splash_time) {
		
		if (self.frame < 2)
		{
			self.frame += 1;
		}
		else
		{
			if (self.cnt == 0)
			{
				self.cnt = 1;
				self.frame = random(2, 5);
			}
		}
			//self.frame = 2 + (1.00000 - ((self.splash_time - time) / self.lifetime))*3.00000;
		
		self.think = blood_drop_timer;
		self.nextthink = (time + 0.08);
	} else {
		self.think = ChunkShrink;
		AdvanceThinkTime(self, (4.00000 + random(4.00000)));
		return;
	}

};

void() blood_fall_timer = {
	if (time < self.splash_time) {
		if ((pointcontents(self.origin) == CONTENT_WATER) || (pointcontents(self.origin) == CONTENT_SLIME)) {
			bloodcount -= 1;
			self.think = blood_mist;
			self.movetype = MOVETYPE_FLY;
			self.velocity = '0 0 0';
			self.cscale = random(25, 40);
			setmodel ( self, "models/null.spr");
		}
		else
			self.think = blood_fall_timer;

		AdvanceThinkTime(self, 0.1);
	} else {
		self.think = ChunkRemove;
		AdvanceThinkTime(self, 0.1);
		return;
	}
};


void() blood_drop = {
	local entity chunk;
	if (bloodcount < MAX_BLOOD_COUNT) {
		chunk = spawn_temp();
		bloodcount += 1;
		chunk.ltime = time;
		chunk.lifetime = random(3.00000, 5.00000);
		chunk.splash_time = time + chunk.lifetime;
		chunk.classname = "bloodspot";
		chunk.movetype = MOVETYPE_TOSS;
		chunk.solid = SOLID_PHASE;
		chunk.velocity = random('-300 -300 -30','300 300 150');

		chunk.touch = blood_drop_timer;
		AdvanceThinkTime(chunk, HX_FRAME_TIME);
		chunk.think = blood_fall_timer;

		setmodel (chunk, "models/bloodspot.mdl");
		if (self.status_effects & STATUS_TOXIC)
			chunk.skin = 2;
		
		chunk.scale = (0.25000 + random(1.62500));
		setsize (chunk, '0 0 0', '0 0 0');
		setorigin (chunk, (self.origin + '0 0 10'));
		chunk.angles = random('0.00000 -180.00000 0.00000','0.00000 180.00000 0.00000');
	} else {
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = SUB_Remove;
	}
};

void() blood_fly = {
	if (self.cnt>0) {
		blood_drop();
		self.cnt -= 1;
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = blood_fly;
	} else {
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = SUB_Remove;
	}
};

void() bloodymess = {
	local entity bloodchunk;
	
	make_bloodcount_reset();
	bloodchunk = spawn_temp();
	bloodchunk.ltime = time;
	bloodchunk.origin = self.origin;
	bloodchunk.cnt = (5 + random(4));
	bloodchunk.status_effects = self.status_effects;
	AdvanceThinkTime(bloodchunk, HX_FRAME_TIME);
	bloodchunk.think = blood_fly;
};


void() blood_control_think = {
	centerprint(self.enemy, "Gore:@1:  ON@2: OFF");
	if (self.enemy.selection == 1) {
		MAX_BLOOD_COUNT = 64;
		self.enemy.shopping = 0;
		self.enemy.selection = 0;
		remove(self);
	}
	if (self.enemy.selection == 2) {
		local entity found;

		found = nextent (world);

		while ( found ) {

			if ( (found.classname == "bloodspot") ) {
				remove(found);
			}
			found = find ( found, classname, "bloodspot");
		}

		MAX_BLOOD_COUNT = 0;
		self.enemy.shopping = 0;
		self.enemy.selection = 0;
		remove(self);
	}
	AdvanceThinkTime(self, 0.1);
	self.think = blood_control_think;
};


void() blood_control = {
	self.shopping = 1;
	newmis = spawn();
	newmis.enemy = self;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = blood_control_think;
};






void() lava_drop_timer = {
	if ((pointcontents(self.origin) == CONTENT_WATER) || (pointcontents(self.origin) == CONTENT_SLIME)) {
		self.cnt = 0;
		self.ftype = 0;
	}
	
	pitch_roll_for_slope('0.00000 0.00000 0.00000');
	if (self.cnt <= 0) {
		self.solid = SOLID_PHASE;
		if (self.ftype > 0) {
			self.ftype -= 1;
			self.dmg = ((self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.12500)*self.scale;
			if ((T_RadiusDamageFlat (self, self.owner, self.dmg, (24.00000*self.scale), self.owner, FALSE) != world) && (random() < 0.12500))
				sound ( self, CHAN_AUTO, "crusader/sunhit.wav", 1.00000, ATTN_NORM);

			//T_RadiusDamage (self, self.owner, (self.scale * 15), other);
			self.think = lava_drop_timer;
			self.nextthink = (time + 0.2);
		} else {
			self.think = ChunkShrink;
			self.nextthink = (time + 0.2);

			return;
		}
	} else {
		self.cnt -= 1;
		self.frame += 1;
		self.think = lava_drop_timer;
		AdvanceThinkTime(self, 0.08);
	}
};

void() lava_fall_timer = {
	if (self.auraT <= 0) {
		self.think = ChunkRemove;
		AdvanceThinkTime(self, 0.1);
		return;
	} else {
		self.auraT -= 1;
		self.think = lava_fall_timer;
		AdvanceThinkTime(self, 0.1);
		if ((pointcontents(self.origin) == CONTENT_WATER) || (pointcontents(self.origin) == CONTENT_SLIME)) {
			CreateWhiteSmoke ( self.origin, '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));
		}
	}
};

void() lava_drop = {
	local float pc, i;
	local vector spot;
	local entity chunk;
	
	if (bloodcount < MAX_BLOOD_COUNT) {
		local	entity missile;
		bloodcount += 1;

		missile = spawn_temp();
		missile.spelldamage = self.spelldamage;
		missile.ltime = time;
		missile.owner = self.owner;
		missile.frame = 0;
		missile.auraT = 30;
		missile.cnt = (1 + random(3));
		missile.classname = "bloodspot";
		missile.movetype = MOVETYPE_TOSS;
		missile.solid = SOLID_PHASE;
		missile.velocity = (random('-1 -1 -1', '1 1 1') * self.lip);
		/*
		if (self.exploderadius == 1) {
			missile.velocity = random('-100 -100 0','100 100 150'); // notice the accent on the up velocity
		} else {
			missile.velocity = random('-500 -500 -50','500 500 250'); // notice the accent on the up velocity
		}
		*/
		// set missile speed
		missile.ftype = random(20, 40);
		missile.touch = lava_drop_timer;
		missile.drawflags = MLS_ABSLIGHT;
		missile.abslight = 1.50000;
		missile.skin = 1;

		// set missile duration
		setmodel (missile, "models/bloodspot.mdl");
		missile.scale = (0.5 + random(2));
		setsize (missile, '0 0 0', '0 0 0');
		missile.angles = random('0.00000 -180.00000 0.00000','0.00000 180.00000 0.00000');
		
		i = 0;
		spot = self.origin + (random('-1 -1 -1', '1 1 1') * self.exploderadius);
		pc = pointcontents(spot);
		while ((i < 8) && (pc == CONTENT_SOLID))
		{
			spot = self.origin + (random('-1 -1 -1', '1 1 1') * self.exploderadius);
			pc = pointcontents(spot);
			i += 1;
		}
		
		if (pc == CONTENT_EMPTY)
		{
			setorigin(missile, spot);
			missile.think = lava_fall_timer;
			AdvanceThinkTime(missile, HX_FRAME_TIME);
		}
		else
		{
			AdvanceThinkTime(self, HX_FRAME_TIME);
			self.think = SUB_Remove;
			AdvanceThinkTime(missile, HX_FRAME_TIME);
			missile.think = SUB_Remove;
		}
	} else {
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = SUB_Remove;
	}
};


void() lava_fly = {
	if (self.cnt>0) {
		self.cnt -= 1;
		lava_drop();
		AdvanceThinkTime(self, 0.02);
		self.think = lava_fly;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = SUB_Remove;
	}
};

void(float amount, float radius, float force) lavamess = {
	local entity missile;

	make_bloodcount_reset();
	missile = spawn();
	missile.spelldamage = self.spelldamage;
	missile.spellradiusmod = self.spellradiusmod;
	missile.ltime = time;
	missile.owner = self.owner;
	missile.cnt = amount;
	missile.exploderadius = radius;
	missile.lip = rint(force);
	missile.origin = self.origin;
	AdvanceThinkTime(missile, HX_FRAME_TIME);
	missile.think = lava_fly;
};


void(vector pos) slime_drop =
{
	local entity chunk, found;
	
	chunk = spawn_temp();
	chunk.spelldamage = self.spelldamage;
	chunk.spellradiusmod = self.spellradiusmod;
	chunk.ltime = time;
	chunk.owner = self.owner;
	chunk.lifetime = random(3.00000, 5.00000);
	chunk.splash_time = time + chunk.lifetime;
	chunk.classname = "slimespot";
	chunk.movetype = MOVETYPE_NOCLIP;
	chunk.solid = SOLID_NOT;
	//chunk.cnt = (1 + random(3));
	chunk.think = lava_drop_timer;
	AdvanceThinkTime(chunk, HX_FRAME_TIME);

	setmodel (chunk, "models/bloodspot.mdl");
	chunk.skin = 2;
	chunk.scale = (0.25000 + random(1.62500));
	setsize (chunk, '0 0 0', '0 0 0');
	setorigin (chunk, pos);
	chunk.angles = random('0.00000 -180.00000 0.00000','0.00000 180.00000 0.00000');
	
	found = T_RadiusDamageFlat (chunk, chunk.owner, (chunk.spelldamage + random(chunk.spelldamage*(-0.12500), chunk.spelldamage*0.12500))*0.12500, 128.00000, chunk.owner, 2);
	while (found)
	{
		apply_status(found, STATUS_TOXIC, (self.spelldamage * 0.12500), random(7, 11));
		found = found.chain2;
	}
};


void  (vector org,vector dir,float chunk_count,entity loser)MeatChunks =  {
	local float final = 0.00000;
	local entity chunk;
	while ( chunk_count ) {

		chunk = spawn_temp ( );
		chunk_count -= 1.00000;
		final = random();
		if ( (loser.model == "models/spider.mdl") || (loser.step4 == 9999) ) {

			if ( (final < 0.33000) ) {

				setmodel ( chunk, "models/sflesh1.mdl");
			} else {

				if ( (final < 0.66000) ) {

					setmodel ( chunk, "models/sflesh2.mdl");
				} else {

					setmodel ( chunk, "models/sflesh3.mdl");

				}

			}
		} else {

			if ( (final < 0.33000) ) {

				setmodel ( chunk, "models/flesh1.mdl");
			} else {

				if ( (final < 0.66000) ) {

					setmodel ( chunk, "models/flesh2.mdl");
				} else {

					setmodel ( chunk, "models/flesh3.mdl");

				}

			}

		}
		setsize ( chunk, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
		chunk.movetype = MOVETYPE_BOUNCE;
		chunk.solid = SOLID_NOT;
		if ( (dir == '0.00000 0.00000 0.00000') ) {

			chunk.velocity = ChunkVelocity ( );
		} else {

			chunk.velocity = dir;

		}


		chunk.think = ChunkRemove;
		chunk.avelocity_x = random(1200.00000);
		chunk.avelocity_y = random(1200.00000);
		chunk.avelocity_z = random(1200.00000);
		chunk.scale = 0.45000;
		chunk.ltime = time;
		AdvanceThinkTime(chunk,random(2.00000));
		setorigin ( chunk, org);

	}
};


void  (vector space,float scalemod)CreateModelChunks =  {
	local entity chunk;
	local float final = 0.00000;
	chunk = spawn_temp ( );
	space_x = (space_x * random());
	space_y = (space_y * random());
	space_z = (space_z * random());
	setorigin ( chunk, (self.absmin + space));
	final = random();
	if ( ((((self.thingtype == THINGTYPE_GLASS) || (self.thingtype == THINGTYPE_REDGLASS)) || (self.thingtype == THINGTYPE_CLEARGLASS)) || (self.thingtype == THINGTYPE_WEBS)) ) {

		if ( (final < 0.20000) ) {

			setmodel ( chunk, "models/shard1.mdl");
		} else {

			if ( (final < 0.40000) ) {

				setmodel ( chunk, "models/shard2.mdl");
			} else {

				if ( (final < 0.60000) ) {

					setmodel ( chunk, "models/shard3.mdl");
				} else {

					if ( (final < 0.80000) ) {

						setmodel ( chunk, "models/shard4.mdl");
					} else {

						setmodel ( chunk, "models/shard5.mdl");

					}

				}

			}

		}
		if ( (self.thingtype == THINGTYPE_CLEARGLASS) ) {

			chunk.skin = 1.00000;
			chunk.drawflags |= DRF_TRANSLUCENT;
		} else {

			if ( (self.thingtype == THINGTYPE_REDGLASS) ) {

				chunk.skin = 2.00000;
			} else {

				if ( (self.thingtype == THINGTYPE_WEBS) ) {

					chunk.skin = 3.00000;

				}

			}

		}
	} else {

		if ( (self.thingtype == THINGTYPE_WOOD) ) {

			if ( (final < 0.25000) ) {

				setmodel ( chunk, "models/splnter1.mdl");
			} else {

				if ( (final < 0.50000) ) {

					setmodel ( chunk, "models/splnter2.mdl");
				} else {

					if ( (final < 0.75000) ) {

						setmodel ( chunk, "models/splnter3.mdl");
					} else {

						setmodel ( chunk, "models/splnter4.mdl");

					}

				}

			}
		} else {

			if ( (self.thingtype == THINGTYPE_METAL) ) {

				if ( (final < 0.25000) ) {

					setmodel ( chunk, "models/metlchk1.mdl");
				} else {

					if ( (final < 0.50000) ) {

						setmodel ( chunk, "models/metlchk2.mdl");
					} else {

						if ( (final < 0.75000) ) {

							setmodel ( chunk, "models/metlchk3.mdl");
						} else {

							setmodel ( chunk, "models/metlchk4.mdl");

						}

					}

				}
			} else {

				if ( (self.thingtype == THINGTYPE_FLESH) ) {

					if ( (self.model == "models/spider.mdl") || (self.step4 == 9999) ) {

						if ( (final < 0.33000) ) {

							setmodel ( chunk, "models/sflesh1.mdl");
						} else {

							if ( (final < 0.66000) ) {

								setmodel ( chunk, "models/sflesh2.mdl");
							} else {

								setmodel ( chunk, "models/sflesh3.mdl");

							}

						}
					} else {

						if ( (final < 0.33000) ) {
							setmodel ( chunk, "models/flesh1.mdl");
						} else {

							if ( (final < 0.66000) ) {

								setmodel ( chunk, "models/flesh2.mdl");
							} else {

								setmodel ( chunk, "models/flesh3.mdl");

							}

						}

					}
					if ( (self.classname == "hive") ) {

						chunk.skin = 1.00000;

					}
				} else {

					if ( (self.thingtype == THINGTYPE_BROWNSTONE) ) {

						if ( (final < 0.25000) ) {

							setmodel ( chunk, "models/schunk1.mdl");
						} else {

							if ( (final < 0.50000) ) {

								setmodel ( chunk, "models/schunk2.mdl");
							} else {

								if ( (final < 0.75000) ) {

									setmodel ( chunk, "models/schunk3.mdl");
								} else {

									setmodel ( chunk, "models/schunk4.mdl");

								}

							}

						}
						chunk.skin = 1.00000;
					} else {

						if ( (self.thingtype == THINGTYPE_CLAY) ) {

							if ( (final < 0.25000) ) {

								setmodel ( chunk, "models/clshard1.mdl");
							} else {

								if ( (final < 0.50000) ) {

									setmodel ( chunk, "models/clshard2.mdl");
								} else {

									if ( (final < 0.75000) ) {

										setmodel ( chunk, "models/clshard3.mdl");
									} else {

										setmodel ( chunk, "models/clshard4.mdl");

									}

								}

							}
						} else {

							if ( (self.thingtype == THINGTYPE_LEAVES) ) {

								if ( (final < 0.33000) ) {

									setmodel ( chunk, "models/leafchk1.mdl");
								} else {

									if ( (final < 0.66000) ) {

										setmodel ( chunk, "models/leafchk2.mdl");
									} else {

										setmodel ( chunk, "models/leafchk3.mdl");

									}

								}
							} else {

								if ( (self.thingtype == THINGTYPE_HAY) ) {

									if ( (final < 0.33000) ) {

										setmodel ( chunk, "models/hay1.mdl");
									} else {

										if ( (final < 0.66000) ) {

											setmodel ( chunk, "models/hay2.mdl");
										} else {

											setmodel ( chunk, "models/hay3.mdl");

										}

									}
								} else {

									if ( (self.thingtype == THINGTYPE_CLOTH) ) {

										if ( (final < 0.33000) ) {

											setmodel ( chunk, "models/clthchk1.mdl");
										} else {

											if ( (final < 0.66000) ) {

												setmodel ( chunk, "models/clthchk2.mdl");
											} else {

												setmodel ( chunk, "models/clthchk3.mdl");

											}

										}
									} else {

										if ( (self.thingtype == THINGTYPE_WOOD_LEAF) ) {

											if ( (final < 0.14000) ) {

												setmodel ( chunk, "models/splnter1.mdl");
											} else {

												if ( (final < 0.28000) ) {

													setmodel ( chunk, "models/leafchk1.mdl");
												} else {

													if ( (final < 0.42000) ) {

														setmodel ( chunk, "models/splnter2.mdl");
													} else {

														if ( (final < 0.56000) ) {

															setmodel ( chunk, "models/leafchk2.mdl");
														} else {

															if ( (final < 0.70000) ) {

																setmodel ( chunk, "models/splnter3.mdl");
															} else {

																if ( (final < 0.84000) ) {

																	setmodel ( chunk, "models/leafchk3.mdl");
																} else {

																	setmodel ( chunk, "models/splnter4.mdl");

																}

															}

														}

													}

												}

											}
										} else {

											if ( (self.thingtype == THINGTYPE_WOOD_METAL) ) {

												if ( (final < 0.12500) ) {

													setmodel ( chunk, "models/splnter1.mdl");
												} else {

													if ( (final < 0.25000) ) {

														setmodel ( chunk, "models/metlchk1.mdl");
													} else {

														if ( (final < 0.37500) ) {

															setmodel ( chunk, "models/splnter2.mdl");
														} else {

															if ( (final < 0.50000) ) {

																setmodel ( chunk, "models/metlchk2.mdl");
															} else {

																if ( (final < 0.62500) ) {

																	setmodel ( chunk, "models/splnter3.mdl");
																} else {

																	if ( (final < 0.75000) ) {

																		setmodel ( chunk, "models/metlchk3.mdl");
																	} else {

																		if ( (final < 0.87500) ) {

																			setmodel ( chunk, "models/splnter4.mdl");
																		} else {

																			setmodel ( chunk, "models/metlchk4.mdl");

																		}

																	}

																}

															}

														}

													}

												}
											} else {

												if ( (self.thingtype == THINGTYPE_WOOD_STONE) ) {

													if ( (final < 0.12500) ) {

														setmodel ( chunk, "models/splnter1.mdl");
													} else {

														if ( (final < 0.25000) ) {

															setmodel ( chunk, "models/schunk1.mdl");
														} else {

															if ( (final < 0.37500) ) {

																setmodel ( chunk, "models/splnter2.mdl");
															} else {

																if ( (final < 0.50000) ) {

																	setmodel ( chunk, "models/schunk2.mdl");
																} else {

																	if ( (final < 0.62500) ) {

																		setmodel ( chunk, "models/splnter3.mdl");
																	} else {

																		if ( (final < 0.75000) ) {

																			setmodel ( chunk, "models/schunk3.mdl");
																		} else {

																			if ( (final < 0.87500) ) {

																				setmodel ( chunk, "models/splnter4.mdl");
																			} else {

																				setmodel ( chunk, "models/schunk4.mdl");

																			}

																		}

																	}

																}

															}

														}

													}
												} else {

													if ( (self.thingtype == THINGTYPE_METAL_STONE) ) {

														if ( (final < 0.12500) ) {

															setmodel ( chunk, "models/metlchk1.mdl");
														} else {

															if ( (final < 0.25000) ) {

																setmodel ( chunk, "models/schunk1.mdl");
															} else {

																if ( (final < 0.37500) ) {

																	setmodel ( chunk, "models/metlchk2.mdl");
																} else {

																	if ( (final < 0.50000) ) {

																		setmodel ( chunk, "models/schunk2.mdl");
																	} else {

																		if ( (final < 0.62500) ) {

																			setmodel ( chunk, "models/metlchk3.mdl");
																		} else {

																			if ( (final < 0.75000) ) {

																				setmodel ( chunk, "models/schunk3.mdl");
																			} else {

																				if ( (final < 0.87500) ) {

																					setmodel ( chunk, "models/metlchk4.mdl");
																				} else {

																					setmodel ( chunk, "models/schunk4.mdl");

																				}

																			}

																		}

																	}

																}

															}

														}
													} else {

														if ( (self.thingtype == THINGTYPE_METAL_CLOTH) ) {

															if ( (final < 0.14000) ) {

																setmodel ( chunk, "models/metlchk1.mdl");
															} else {

																if ( (final < 0.28000) ) {

																	setmodel ( chunk, "models/clthchk1.mdl");
																} else {

																	if ( (final < 0.42000) ) {

																		setmodel ( chunk, "models/metlchk2.mdl");
																	} else {

																		if ( (final < 0.56000) ) {

																			setmodel ( chunk, "models/clthchk2.mdl");
																		} else {

																			if ( (final < 0.70000) ) {

																				setmodel ( chunk, "models/metlchk3.mdl");
																			} else {

																				if ( (final < 0.84000) ) {

																					setmodel ( chunk, "models/clthchk3.mdl");
																				} else {

																					setmodel ( chunk, "models/metlchk4.mdl");

																				}

																			}

																		}

																	}

																}

															}
														} else {

															if ( (self.thingtype == THINGTYPE_ICE) ) {

																setmodel ( chunk, "models/shard.mdl");
																chunk.skin = 0.00000;
																chunk.frame = random(2.00000);
																chunk.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
																chunk.abslight = 0.50000;
															} else {

																if ( (final < 0.25000) ) {

																	setmodel ( chunk, "models/schunk1.mdl");
																} else {

																	if ( (final < 0.50000) ) {

																		setmodel ( chunk, "models/schunk2.mdl");
																	} else {

																		if ( (final < 0.75000) ) {

																			setmodel ( chunk, "models/schunk3.mdl");
																		} else {

																			setmodel ( chunk, "models/schunk4.mdl");

																		}

																	}

																}
																chunk.skin = 0.00000;

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

					}

				}

			}

		}

	}
	setsize ( chunk, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	chunk.movetype = MOVETYPE_BOUNCE;
	chunk.solid = SOLID_NOT;
	chunk.velocity = ChunkVelocity ( );
	chunk.think = ChunkShrink; // BAER changed to add shrinkage of chunks
	chunk.avelocity_x = random(1200.00000);
	chunk.avelocity_y = random(1200.00000);
	chunk.avelocity_z = random(1200.00000);
	if ( (self.classname == "monster_eidolon") ) {

		chunk.scale = random(2.10000,2.50000);
	} else {

		chunk.scale = random(scalemod,(scalemod + 0.10000));

	}
	chunk.ltime = time;
	AdvanceThinkTime(chunk,random(4.00000)); // BAER gave chunks longer life (doubled)
};

void  ()DropBackpack;

void  (vector location)TinySplat =  {
	local vector holdplane = '0.00000 0.00000 0.00000';
	local entity splat;
	traceline ( (((location + (v_up * 8.00000)) + (v_right * 8.00000)) + (v_forward * 8.00000)), (((location - (v_up * 32.00000)) + (v_right * 8.00000)) + (v_forward * 8.00000)), TRUE, self);
	holdplane = trace_plane_normal;
	if ( (trace_fraction == 1.00000) ) {

		return ;

	}
	traceline ( (((location + (v_up * 8.00000)) - (v_right * 8.00000)) + (v_forward * 8.00000)), (((location - (v_up * 32.00000)) - (v_right * 8.00000)) + (v_forward * 8.00000)), TRUE, self);
	if ( ((holdplane != trace_plane_normal) || (trace_fraction == 1.00000)) ) {

		return ;

	}
	traceline ( (((location + (v_up * 8.00000)) + (v_right * 8.00000)) - (v_forward * 8.00000)), (((location - (v_up * 32.00000)) + (v_right * 8.00000)) - (v_forward * 8.00000)), TRUE, self);
	if ( ((holdplane != trace_plane_normal) || (trace_fraction == 1.00000)) ) {

		return ;

	}
	traceline ( (((location + (v_up * 8.00000)) - (v_right * 8.00000)) - (v_forward * 8.00000)), (((location - (v_up * 32.00000)) - (v_right * 8.00000)) - (v_forward * 8.00000)), TRUE, self);
	if ( ((holdplane != trace_plane_normal) || (trace_fraction == 1.00000)) ) {

		return ;

	}
	traceline ( (location + (v_up * 8.00000)), (location - (v_up * 32.00000)), TRUE, self);
	splat = spawn ( );
	splat.owner = self;
	splat.classname = "bloodsplat";
	splat.movetype = MOVETYPE_NONE;
	splat.solid = SOLID_NOT;
	trace_plane_normal_x = (trace_plane_normal_x * -1.00000);
	trace_plane_normal_y = (trace_plane_normal_y * -1.00000);
	splat.angles = vectoangles ( trace_plane_normal);
	setmodel ( splat, "models/bldspot4.spr");
	setsize ( splat, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( splat, (trace_endpos + '0.00000 0.00000 2.00000'));
};


void  ()BloodSplat =  {
	local entity splat;
	local vector holdangles = '0.00000 0.00000 0.00000';
	if ( (random() < 0.50000) ) {

		holdangles_x = random(-30.00000,-20.00000);
		holdangles_y = random(30.00000,20.00000);
	} else {

		holdangles_x = random(30.00000,20.00000);
		holdangles_y = random(-30.00000,-20.00000);

	}
	holdangles_z = 16.00000;
	TinySplat ( (self.origin + holdangles));
	if ( (random() < 0.50000) ) {

		holdangles_x = random(-30.00000,-10.00000);
		holdangles_y = random(30.00000,10.00000);
	} else {

		holdangles_x = random(30.00000,10.00000);
		holdangles_y = random(-30.00000,-10.00000);

	}
	holdangles_z = 16.00000;
	TinySplat ( (self.origin + holdangles));
	makevectors ( self.angles);
	traceline ( (self.origin + (v_up * 8.00000)), (self.origin - (v_up * 32.00000)), TRUE, self);
	if ( (trace_fraction == 1.00000) ) {

		dprint ( "\n no floor ");
		return ;

	}
	splat = spawn ( );
	splat.owner = self;
	splat.classname = "bloodsplat";
	splat.movetype = MOVETYPE_NONE;
	splat.solid = SOLID_NOT;
	trace_plane_normal_x = (trace_plane_normal_x * -1.00000);
	trace_plane_normal_y = (trace_plane_normal_y * -1.00000);
	splat.angles = vectoangles ( trace_plane_normal);
	setmodel ( splat, "models/bldspot2.spr");
	setsize ( splat, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	setorigin ( splat, (trace_endpos + '0.00000 0.00000 2.00000'));
};


void  ()chunk_reset =  {
	chunk_cnt = FALSE;
	remove ( self);
};

void ()bloodcount_reset = {
	bloodcount = FALSE;
	remove(self);
};


void  ()make_chunk_reset =  {
	local entity chunktimer;
	
	chunktimer = spawn ( );
	chunktimer.think = chunk_reset;
	AdvanceThinkTime(chunktimer,1.50000);
};

void  ()make_bloodcount_reset =  {
	local entity chunktimer;
	chunktimer = spawn ( );
	chunktimer.think = bloodcount_reset;
	AdvanceThinkTime(chunktimer,1.50000);
};


void  ()chunk_death =  {
	local vector space = '0.00000 0.00000 0.00000';
	local float spacecube = 0.00000;
	local float model_cnt = 0.00000;
	local float scalemod = 0.00000;
	local string deathsound;

	newmis = find (world, classname, "player");
	while ( newmis ) {
		newmis.allexp += 1;
		AwardExperience ( newmis, self, 1);
		newmis = find ( newmis, classname, "player");
	}


	if (self.classname == "player") {
		bloodymess();
	}
	if ( (self.classname == "monster_archer") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_archer_lord") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_archer") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_mezzoman") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_werepanther") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_imp_lord") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_imp_ice") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_imp_fire") ) {
		bloodymess();
	}
	if ( (self.classname == "monster_medusa") ) {
		bloodymess();
	}


	DropBackpack ( );
	space = (self.absmax - self.absmin);
	spacecube = ((space_x * space_y) * space_z);
	model_cnt = (spacecube / 8192.00000);
	if ( (((self.thingtype == THINGTYPE_GLASS) || (self.thingtype == THINGTYPE_CLEARGLASS)) || (self.thingtype == THINGTYPE_REDGLASS)) ) {

		deathsound = "fx/glassbrk.wav";
	} else {

		if ( ((self.thingtype == THINGTYPE_WOOD) || (self.thingtype == THINGTYPE_WOOD_METAL)) ) {

			if ( (self.classname == "bolt") ) {

				deathsound = "assassin/arrowbrk.wav";
			} else {

				deathsound = "fx/woodbrk.wav";

			}
		} else {

			if ( ((((self.thingtype == THINGTYPE_GREYSTONE) || (self.thingtype == THINGTYPE_BROWNSTONE)) || (self.thingtype == THINGTYPE_WOOD_STONE)) || (self.thingtype == THINGTYPE_METAL_STONE)) ) {

				deathsound = "fx/wallbrk.wav";
			} else {

				if ( ((self.thingtype == THINGTYPE_METAL) || (self.thingtype == THINGTYPE_METAL_CLOTH)) ) {

					deathsound = "fx/metalbrk.wav";
				} else {

					if ( ((self.thingtype == THINGTYPE_CLOTH) || (self.thingtype == THINGTYPE_REDGLASS)) ) {

						deathsound = "fx/clothbrk.wav";
					} else {

						if ( (self.thingtype == THINGTYPE_FLESH) ) {

							if ( (self.health < -80.00000) ) {

								deathsound = "player/megagib.wav";
							} else {

								deathsound = "player/gib1.wav";
							}
							sound ( self, CHAN_AUTO, deathsound, 1.00000, ATTN_NORM);
							self.level = -666.00000;
						} else {

							if ( (self.thingtype == THINGTYPE_CLAY) ) {

								deathsound = "fx/claybrk.wav";
							} else {

								if ( ((self.thingtype == THINGTYPE_LEAVES) || (self.thingtype == THINGTYPE_WOOD_LEAF)) ) {

									deathsound = "fx/leafbrk.wav";
								} else {

									if ( (self.thingtype == THINGTYPE_ICE) ) {

										deathsound = "misc/icestatx.wav";
									} else {

										deathsound = "fx/wallbrk.wav";

									}

								}

							}

						}

					}

				}

			}

		}

	}
	if ( (self.level != -666.00000) ) {

		sound ( self, CHAN_VOICE, deathsound, 1.00000, ATTN_NORM);

	}
	if ( (spacecube < 5000.00000) ) {

		scalemod = 0.20000;
		model_cnt = (model_cnt * 3.00000);
	} else {

		if ( (spacecube < 50000.00000) ) {

			scalemod = 0.45000;
			model_cnt = (model_cnt * 3.00000);
		} else {

			if ( (spacecube < 500000.00000) ) {

				scalemod = 0.50000;
			} else {

				if ( (spacecube < 1000000.00000) ) {

					scalemod = 0.75000;
				} else {

					scalemod = 1.00000;

				}

			}

		}

	}
	if ( (model_cnt > CHUNK_MAX) ) {

		model_cnt = CHUNK_MAX;

	}
	while ( (model_cnt > 0.00000) ) {

		if ( (chunk_cnt < (CHUNK_MAX * 2.00000)) ) {

			CreateModelChunks ( space, scalemod);
			chunk_cnt += 1.00000;

		}
		model_cnt -= 1.00000;

	}
	make_chunk_reset ( );
	if ( (self.classname == "monster_eidolon") ) {

		return ;

	}
	SUB_UseTargets ( );
	if ( ((self.headmodel != "") && (self.classname != "head")) ) {

		ThrowSolidHead ( 50.00000);
	} else {

		remove ( self);

	}
};

