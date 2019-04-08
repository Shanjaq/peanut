void() check_statuses;
void  ()reset_inning_scores;
void  ()check_rank;
float ()room_descriptor;
//void  ()personN;
//void  ()personS;
void  ()sheep_tranB;
void  (float NewLevel)PlayerAdvanceLevel;
void  ()player_level_cheat;
void  ()player_experience_cheat;
void  (entity loser)Polymorph;
void (string lastmap)enter_magic_shop;
void ()GotoNextMap;

float (vector pos, float radius)tracevolume;

void  ()prepare_think =  {
	centerprint ( self.enemy, "wait for all clients to rejoin your server, then press 1");
	if ( (self.enemy.selection == TRUE) ) {

		self.enemy.shopping = 0;
		if ( (mapname == "village2") ) {

			changelevel ( "meso2", self.target);

		}
		if ( (mapname == "meso8") ) {

			changelevel ( "egypt1", self.target);

		}
		if ( (mapname == "egypt1") ) {

			changelevel ( "romeric1", self.target);

		}
		if ( (mapname == "romeric5") ) {

			changelevel ( "cath", self.target);

		}
		remove ( self);
		return ;

	}
	AdvanceThinkTime(self,0.50000);
	self.think = prepare_think;
};


void  (entity targ)prepare_thyself =  {
	newmis = spawn ( );
	newmis.enemy = targ;
	targ.shopping = TRUE;
	AdvanceThinkTime(newmis,0.02000);
	newmis.think = prepare_think;
};





void  ()restore_weapon =  {
	self.weaponframe = 0.00000;
	if ( (self.playerclass == CLASS_PALADIN) ) {

		if ( (self.weapon == IT_WEAPON1) ) {

			self.weaponmodel = "models/gauntlet.mdl";
		} else {

			if ( (self.weapon == IT_WEAPON2) ) {

				self.weaponmodel = "models/vorpal.mdl";
			} else {

				if ( (self.weapon == IT_WEAPON3) ) {

					self.weaponmodel = "models/axe.mdl";
				} else {

					if ( (self.weapon == IT_WEAPON4) ) {

						self.weaponmodel = "models/purifier.mdl";

					}

				}

			}

		}
	} else {

		if ( (self.playerclass == CLASS_CRUSADER) ) {

			if ( (self.weapon == IT_WEAPON1) ) {

				self.weaponmodel = "models/warhamer.mdl";
			} else {

				if ( (self.weapon == IT_WEAPON2) ) {

					self.weaponmodel = "models/icestaff.mdl";
				} else {

					if ( (self.weapon == IT_WEAPON3) ) {

						self.weaponmodel = "models/meteor.mdl";
					} else {

						if ( (self.weapon == IT_WEAPON4) ) {

							self.weaponmodel = "models/sunstaff.mdl";

						}

					}

				}

			}
		} else {

			if ( (self.playerclass == CLASS_NECROMANCER) ) {

				if ( (self.weapon == IT_WEAPON1) ) {

					self.weaponmodel = "models/sickle.mdl";
				} else {

					if ( (self.weapon == IT_WEAPON2) ) {

						self.weaponmodel = "models/sickle.mdl";
					} else {

						if ( (self.weapon == IT_WEAPON3) ) {

							self.weaponmodel = "models/sickle.mdl";
						} else {

							if ( (self.weapon == IT_WEAPON4) ) {

								self.weaponmodel = "models/ravenstf.mdl";

							}

						}

					}

				}
			} else {

				if ( (self.playerclass == CLASS_ASSASSIN) ) {

					if ( (self.weapon == IT_WEAPON1) ) {

						self.weaponmodel = "models/punchdgr.mdl";
					} else {

						if ( (self.weapon == IT_WEAPON2) ) {

							self.weaponmodel = "models/crossbow.mdl";
						} else {

							if ( (self.weapon == IT_WEAPON3) ) {

								self.weaponmodel = "models/v_assgr.mdl";
							} else {

								if ( (self.weapon == IT_WEAPON4) ) {

									self.weaponmodel = "models/scarabst.mdl";

								}

							}

						}

					}

				}

			}

		}

	}
};


void  ()see_coop_view =  {
	local entity startent;
	local entity found;
	local float gotone = 0.00000;
	if ( (!coop && !teamplay) ) {

		centerprint ( self, "Ally vision not available\n");
		return ;

	}
	startent = self.viewentity;
	found = startent;
	while ( !gotone ) {

		found = find ( found, classname, "player");
		if ( (found.flags2 & FL_ALIVE) ) {

			if ( ((deathmatch && (found.team == self.team)) || coop) ) {

				gotone = TRUE;

			}

		}
		if ( (found == startent) ) {

			centerprint ( self, "No allies available\n");
			return ;

		}

	}
	sprint ( self, found.netname);
	sprint ( self, " found!\n");
	self.viewentity = found;
	CameraViewPort ( self, found);
	CameraViewAngles ( self, found, 0, 0, 0);
	if ( (self.viewentity == self) ) {

		self.oldweapon = self.weapon;
		restore_weapon ( );
	} else {

		self.weaponmodel = self.viewentity.weaponmodel;
		self.weaponframe = self.viewentity.weaponframe;

	}
};


void  ()player_everything_cheat =  {
	//   if ( (deathmatch || coop) ) {

	//      return ;

	//   }
	CheatCommand ( );
	Artifact_Cheat ( );
	self.puzzles_cheat = 1.00000;
};


void  ()PrintFrags =  {
	local entity lastent;
	lastent = nextent ( world);
	while ( lastent ) {

		if ( (lastent.classname == "player") ) {

			bprint ( lastent.netname);
			bprint ( " (L-");
			bprint ( ftos ( lastent.level));
			if ( (lastent.playerclass == CLASS_ASSASSIN) ) {

				bprint ( " Assassin) ");
			} else {

				if ( (lastent.playerclass == CLASS_PALADIN) ) {

					bprint ( " Paladin) ");
				} else {

					if ( (lastent.playerclass == CLASS_CRUSADER) ) {

						bprint ( " Crusader) ");
					} else {

						bprint ( " Necromancer) ");

					}

				}

			}
			bprint ( " FRAGS: ");
			bprint ( ftos ( lastent.frags));
			bprint ( " (LF: ");
			bprint ( ftos ( lastent.level_frags));
			bprint ( ")\n");

		}
		lastent = find ( lastent, classname, "player");

	}
};


void  ()player_stopfly =  {
	self.movetype = MOVETYPE_WALK;
	self.idealpitch = cvar ( "sv_walkpitch");
	self.idealroll = 0.00000;
};


void  ()player_fly =  {
	self.movetype = MOVETYPE_FLY;
	self.velocity_z = 100.00000;
	self.hoverz = 0.40000;
};

void  ()HeaveHo_think =  {
	makevectors ( self.v_angle);
	traceline ( (self.origin + self.proj_ofs), ((self.origin + self.proj_ofs) + (normalize ( v_forward) * (FLIGHT_TIME + (self.jones.size_x * 1.50000)))), FALSE, self);
	trace_endpos_z -= HX_FPS;
	self.jones.proj_ofs = self.jones.origin;
	setorigin ( self.jones, (trace_endpos - (v_forward * self.jones.size_x)));
	self.jones.velocity = '0 0 0';
	self.jones.angles_y = (self.jones.wisdom + (self.v_angle_y - self.jones.dexterity));
};



void  ()HeaveHo =  {
	local vector dir = '0.00000 0.00000 0.00000';
	makevectors ( self.v_angle);
	if ( (self.lifting == TRUE) ) {

		if ( (vlen ( (self.jones.origin - self.origin)) < (30 + (self.jones.size_x / 2))) ) {

			centerprint ( self, "no room to drop this here!");
		} else {

			//			self.hasted *= 2;
			self.lifting = 0;
			self.jones.movetype = self.jones.auraV;
			self.jones.solid = SOLID_BBOX;
			self.jones.velocity += ((self.jones.origin - self.jones.proj_ofs) * 200);
			if (self.jones.mass < 100) {
				self.jones.velocity_x *= (1 - (self.jones.mass / 100));
				self.jones.velocity_y *= (1 - (self.jones.mass / 100));
				self.jones.velocity_z *= (1 - (self.jones.mass / 100));
			} else {
				self.jones.velocity = '0 0 0';
			}
			self.jones.velocity += self.velocity;

		}

	} else {


		dir = normalize ( v_forward);
		traceline ( (self.origin + self.proj_ofs), ((self.origin + self.proj_ofs) + (dir * 48)), FALSE, self);
		if ( (((((trace_ent.movetype && trace_ent.solid) && (trace_ent.classname != "player")) && !(trace_ent.flags & FL_MONSTER)) && (trace_ent != world)) && ((trace_ent.solid != SOLID_BSP) && (trace_ent.mass < 8000.00000))) ) {

			if ( (self.lifting == 0) ) {

				self.lifting = TRUE;

			}
			//			self.hasted /= 2;
			self.jones = trace_ent;
			self.jones.auraV = self.jones.movetype;
			self.jones.wisdom = self.jones.angles_y;
			self.jones.dexterity = self.v_angle_y;
			self.jones.movetype = MOVETYPE_NOCLIP;
			self.jones.solid = SOLID_NOT;
			if ( (trace_ent.flags & FL_ONGROUND) ) {

				trace_ent.flags ^= FL_ONGROUND;

			}
			if ( (self.playerclass == CLASS_ASSASSIN) ) {

				sound ( self, CHAN_BODY, "player/assjmp.wav", TRUE, ATTN_NORM);
			} else {

				sound ( self, CHAN_BODY, "player/paljmp.wav", TRUE, ATTN_NORM);

			}
			self.attack_finished = (time + TRUE);

		}

	}//shan curious
};


void  (float addflag)AddServerFlag =  {
	addflag = byte_me ( (addflag + 8.00000));
	dprintf ( "Serverflags were: %s\n", serverflags);
	dprintf ( "Added flag %s\n", addflag);
	serverflags |= addflag;
	dprintf ( "Serverflags are now: %s\n", serverflags);
};


void  ()ImpulseCommands =  {
	local entity search;
	local float total = 0.00000;

	if (self.sale == 0)
		self.choice = 0;



	if ( ((self.flags2 & FL_CHAINED) && (self.impulse != 23.00000)) ) {

		return ;

	}
	if ( (self.impulse == 198.00000) ) {

		//      CheatCommand ( );
		sprint(self, "hey!  no cheating!\n");
	} else {

		if ( (self.impulse == 14.00000) ) {

			Polymorph ( self);
		} else {

			if ( (self.impulse == 99.00000) ) {

				ClientKill ( );
			} else {

				if ( (self.impulse == 149.00000) ) {

					dprintf ( "Serverflags are now: %s\n", serverflags);
				} else {

					if ( (self.impulse == 23.00000) ) {

						UseInventoryItem ( );
					} else {

						if ( (self.impulse == 33.00000) ) {

							see_coop_view ( );
						} else {

							if ( (self.impulse == 32.00000) ) {

								PanicButton ( );
							} else {

								if ( ((self.impulse == 35.00000) && (skill < 3.00000)) ) {

									search = nextent ( world);
									total = 0.00000;
									while ( (search != world) ) {

										if ( (search.flags & FL_MONSTER) ) {

											total += 1.00000;
											remove ( search);

										}
										search = nextent ( search);

									}
									dprintf ( "Removed %s monsters\n", total);
								} else {

									if ( ((self.impulse == 36.00000) && (skill < 3.00000)) ) {

										search = nextent ( world);
										total = 0.00000;
										while ( (search != world) ) {

											if ( (search.flags & FL_MONSTER) ) {

												total += 1.00000;
												AdvanceThinkTime(search,99999.00000);

											}
											search = nextent ( search);

										}
										dprintf ( "Froze %s monsters\n", total);
									} else {

										if ( ((self.impulse == 37.00000) && (skill < 3.00000)) ) {

											search = nextent ( world);
											total = 0.00000;
											while ( (search != world) ) {

												if ( (search.flags & FL_MONSTER) ) {

													total += 1.00000;
													AdvanceThinkTime(search,HX_FRAME_TIME);

												}
												search = nextent ( search);

											}
											dprintf ( "UnFroze %s monsters\n", total);
										} else {

											if ( (self.impulse == 25.00000) ) {

												if ( (deathmatch || coop) ) {

													self.impulse = 0.00000;
													return ;
												} else {

													self.cnt_tome += 1.00000;
													Use_TomeofPower ( );

												}
											} else {

												if ( ((self.impulse == 39.00000) && (skill < 3.00000)) ) {

													if ( (deathmatch || coop) ) {

														self.impulse = 0.00000;
														return ;
													} else {

														if ( (self.movetype != MOVETYPE_FLY) ) {

															player_fly ( );
														} else {

															player_stopfly ( );

														}

													}
												} else {

													if ( ((self.impulse == 40.00000) && (skill < 3.00000)) ) {

														player_level_cheat ( );
													} else {

														if ( ((self.impulse == 41.00000) && (skill < 3.00000)) ) {

															if ( (deathmatch || coop) ) {

																self.impulse = 0.00000;
																return ;
															} else {

																player_experience_cheat ( );

															}
														} else {

															//					     if ( (self.impulse == 42.00000) ) {

															//						dprintv ( "Coordinates: %s\n", self.origin);
															//						dprintv ( "Angles: %s\n", self.angles);
															//						dprint ( "Map is ");
															//						dprint ( mapname);
															//						dprint ( "\n");
															//					     } else {

															if ( ((self.impulse == 43.00000) && (skill < 3.00000)) ) {

																player_everything_cheat ( );
															} else {

																if ( (self.impulse == 44.00000) ) {

																	DropInventoryItem ( );
																} else {

																	if ( (self.impulse == 45.00000) ) {

																		UFOBoard ( );
																		self.UFO = 1;
																	} else {

																		if ( (self.impulse == 46.00000) ) {
																			UFOExit();
																			self.UFO = 0;
																			
																		} else {
																			if ( (self.impulse == 48.00000) ) {
																				//CameraViewAngles(self, self.enemy, 180, 0, 0);
																				//									bprint(self.P1name);
																				//									bprint(ftos(self.P1money));
																				//									bprint("\n");
																				//									bprint(self.P2name);
																				//									bprint(ftos(self.P2money));
																				//									bprint("\n");

																				//particle_sampler();
																				savechars();
																			} else {

																				if ( (self.impulse == 49.00000) ) {
																					restorechar(self);
																					//						      personN ( );
																					//map_changer();
																					//tp = self.origin;
																					//self.sheep = 5;
																					//particle_sampler();
																					//	prepare_thyself();
																				} else {

																					if ( (self.impulse == 50.00000) ) {

																						//						      personS ( );
																						//respawn();
																						//self.movetype = MOVETYPE_NOCLIP;
																						setorigin(self, tp);
																						//launch_crushdrop();
																						//localcmd ( "restart restore\n");


																					} else {

																						if ( (self.impulse == 51.00000) ) {
																							//MakeCamera2();
																							//launch_aero();
																							//self.pos2 = self.origin;
																							//self.blizzcount = 2;
																							//changelevel("shoptest", self.target);
																							if (!deathmatch) {
																								//	enter_magic_shop(mapname);
																								magic_shop_portal();
																							}
																						} else {

																							if ( (self.impulse == 52.00000) ) {

																								//windball_spawn();
																								//darkbeam();
																								//deatharc_launch();
																								//furniture_sensor();
																								//multiply_monsters();
																								//launch_swarm();
																								//lchain_launch();
																								//magnet_projectile_launch();
																								//self.Lfinger1Support |= SUPPORT_CASTSPEED; //SUPPORT_MULTI
																								/*
																								self.Lfinger1Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Lfinger2Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Lfinger3Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Lfinger4Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Lfinger5Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Rfinger1Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Rfinger2Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Rfinger3Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Rfinger4Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								self.Rfinger5Support |= (SUPPORT_CASTSPEED | SUPPORT_DAMAGE | SUPPORT_RADIUS | SUPPORT_TRAP);
																								*/
																								
																								/*
																								self.Lfinger1Support = random(0, 31);
																								self.Lfinger2Support = random(0, 31);
																								self.Lfinger3Support = random(0, 31);
																								self.Lfinger4Support = random(0, 31);
																								self.Lfinger5Support = random(0, 31);
																								self.Rfinger1Support = random(0, 31);
																								self.Rfinger2Support = random(0, 31);
																								self.Rfinger3Support = random(0, 31);
																								self.Rfinger4Support = random(0, 31);
																								self.Rfinger5Support = random(0, 31);
																								*/
																								/*
																								self.Lfinger1Support += 1;
																								self.Lfinger2Support += 1;
																								self.Lfinger3Support += 1;
																								self.Lfinger4Support += 1;
																								self.Lfinger5Support += 1;
																								self.Rfinger1Support += 1;
																								self.Rfinger2Support += 1;
																								self.Rfinger3Support += 1;
																								self.Rfinger4Support += 1;
																								self.Rfinger5Support += 1;
																								spells_compute(self);
																								*/
																								check_statuses();
																							} else {

																								if ( (self.impulse == 53.00000) ) {

																									check_money ( );
																									check_ammo ( );
																									check_stuff ( );
																									if (((survivor) && (deathmatch)) || (heresy)) {
																										check_rank();
																									}

																								} else {
																									if ( (self.impulse == 54.00000) ) {
																										//                                                      pblast_launch();
																										//particle_sampler();
																										if (heresy) {
																											select_mage();
																										}
																										//scan_launch();
																										//bh_launch();
																									} else {


																										if ( (self.impulse == 55.00000) ) {

																											//make_mage(self);
																											//self.level = 9;
																											//self.max_health = 200;
																											//self.health = 200;
																											//self.max_mana = 200;
																											//self.bluemana = self.max_mana;
																											//self.greenmana = self.max_mana;
																											self.Lfinger1S = ceil(random(0.5, 36));
																											self.Lfinger2S = ceil(random(0.5, 36));
																											self.Lfinger3S = ceil(random(0.5, 36));
																											self.Lfinger4S = ceil(random(0.5, 36));
																											self.Lfinger5S = ceil(random(0.5, 36));

																											self.Rfinger1S = ceil(random(0.5, 36));
																											self.Rfinger2S = ceil(random(0.5, 36));
																											self.Rfinger3S = ceil(random(0.5, 36));
																											self.Rfinger4S = ceil(random(0.5, 36));
																											self.Rfinger5S = ceil(random(0.5, 36));
																											
																											self.Lfinger1Support = 0;
																											self.Lfinger2Support = 0;
																											self.Lfinger3Support = 0;
																											self.Lfinger4Support = 0;
																											self.Lfinger5Support = 0;
																											
																											self.Rfinger1Support = 0;
																											self.Rfinger2Support = 0;
																											self.Rfinger3Support = 0;
																											self.Rfinger4Support = 0;
																											self.Rfinger5Support = 0;
																											spells_compute(self);
																										} else {


																											if ( (self.impulse == 56.00000) ) {
																												if ((self.mage == 1) && (deathmatch)) {
																													flash_toggle();
																												} else {
																													return;
																												}
																											} else {


																												if ( (self.impulse == 57.00000) ) {
																													if (self.mage == 1) {
																														if(self.flash_flag == FALSE) {
																															if ((self.handy == 0) || (self.handy == 1)) {
																																if (self.handy == 0) {
																																	if (self.Lfinger < 4) {
																																		self.Lfinger += 1;
																																	} else {
																																		self.Lfinger = 0;
																																	}
																																}
																																if (self.handy == 1) {
																																	if (self.Rfinger > 0) {
																																		self.Rfinger -= 1;
																																	} else {
																																		self.Rfinger = 4;
																																	}
																																}
																																spells_compute(self);
																																
																																if (self.handy == 0)
																																	self.LfingerC = time + self.spelltop;
																																else if (self.handy == 1)
																																	self.RfingerC = time + self.spelltop;
																															}
																															boot -= 1;
																														} else {
																															boot = (boot - 1);
																															if (self.dunk == 1)  {
																																if (self.menuitem < 1) {
																																	self.menuitem = 6;
																																}
																																self.menuitem = (self.menuitem - 1);
																																sound(self, CHAN_WEAPON, "down.wav", TRUE, ATTN_NORM);  
																																
																																sayitem();
																															} else {
																																return;
																															}
																														}
																														//}
																													} else {
																														return;
																													}
																												} else {



																													if ( (self.impulse == 58.00000) ) {
																														if (self.mage == 1) {
																															if(self.flash_flag == FALSE) {
																																if ((self.handy == 0) || (self.handy == 1)) {
																																	if (self.handy == 0) {
																																		if (self.Lfinger > 0) {
																																			self.Lfinger -= 1;
																																		} else {
																																			self.Lfinger = 4;
																																		}
																																	}
																																	if (self.handy == 1) {
																																		if (self.Rfinger < 4) {
																																			self.Rfinger += 1;
																																		} else {
																																			self.Rfinger = 0;
																																		}
																																	}
																																	spells_compute(self);
																																	
																																	if (self.handy == 0)
																																		self.LfingerC = time + self.spelltop;
																																	else if (self.handy == 1)
																																		self.RfingerC = time + self.spelltop;
																																}
																																boot += 1;
																															} else {
																																boot = (boot + 1);
																																if (self.dunk == 1)  { 
																																	sound(self, CHAN_WEAPON, "up.wav", TRUE, ATTN_NORM);

																																	self.menuitem = (self.menuitem + 1);
																																	
																																	if (self.menuitem > 5) {
																																		self.menuitem = 0;
																																	}
																																	
																																	sayitem();
																																} else {
																																	return;
																																}
																																//      }
																															}
																															//}
																														} else {
																															return;
																														}
																													} else {


																														if ( (self.impulse == 59.00000) ) {
																															if (self.mage == 1) {
																																if (self.flash_flag == FALSE) {
																																	if ((self.handy == 0) && (time < self.dest_z))
																																	{
																																		self.handy = 2;
																																		if ((self.Lsupport & SUPPORT_RADIUS) && (time > (self.LfingerC - ((self.spelltop * 0.36250)))))
																																			self.LfingerC = time + (self.spelltop * 0.36250);
																																	}
																																	else
																																	{
																																		self.handy = 0;
																																		spells_compute(self);
																																	}
																																	spell_marker(0, self.Lfinger);
																																	if ((self.Lspell == 19) || (self.Lspell == 25) || (self.Lspell == 2)) {
																																		if (self.Lspell == 19) {
																																			self.click = 1;
																																			windball_spawn();
																																		}
																																		if (self.Lspell == 2) {
																																			self.click = 1;
																																			light_shell();
																																		}
																																		if (self.Lspell == 25) {
																																			self.handy = 2;
																																		}
																																	}
																																} else {
																																	//if (self.hair == 0) {
																																	//flash_toggle();
																																	//self.hair = 1;
																																	//} else {
																																	if (self.dunk == 1)  { 
																																		
																																		self.ftype = 2;
																																		self.htype = 1;
																																		self.cskin = 1;
																																	} else {
																																		return;
																																	}
																																}
																															} else {
																																return;
																															}                           
																														} else {


																															if ( (self.impulse == 60.00000) ) {
																																if (self.mage == 1) {
																																	if (self.flash_flag == FALSE) {
																																		if ((self.handy == 1) && (time < self.dest_z))
																																		{
																																			self.handy = 3; 
																																			if ((self.Rsupport & SUPPORT_RADIUS) && (time > (self.RfingerC - ((self.spelltop * 0.36250)))))
																																				self.RfingerC = time + (self.spelltop * 0.36250);
																																		}
																																		else
																																		{
																																			self.handy = 1;
																																			spells_compute(self);
																																		}
																																		spell_marker(1, self.Rfinger);
																																		if ((self.Rspell == 19) || (self.Rspell == 25) || (self.Rspell == 2)) {
																																			if (self.Rspell == 19) {
																																				self.click = 1;
																																				windball_spawn();
																																			}
																																			if (self.Rspell == 25) {
																																				self.handy = 3; 
																																			}
																																			if (self.Rspell == 2) {
																																				self.click = 1;
																																				light_shell();
																																			}
																																		}
																																	} else {
																																		//if (self.hair == 0) {
																																		//flash_toggle();
																																		//self.hair = 1;
																																		//} else {

																																		if (self.dunk == 1)  {
																																			self.ftype = 1;                                                 
																																			self.htype = 1;
																																			self.cskin = 1;

																																		} else {
																																			return;
																																		}
																																	}
																																} else {
																																	return;
																																}
																															} else {


																																if ( (self.impulse == 62.00000) ) {
																																	if (self.mage == 1) {
																																		if (self.click == 0) {
																																			self.click = 1;
																																		}
																																	} else {
																																		return;
																																	}
																																} else {


																																	if ( (self.impulse == 63.00000) ) {

																																		self.spellfired = 0;
																																		self.cskin = 0;
																																		self.click = 0;

																																		if (self.handy == 2)
																																		{
																																			if ((self.Lsupport & SUPPORT_RADIUS) && (time > (self.LfingerC - ((self.spelltop * 0.36250)))))
																																			{
																																				if (self.predebt == 0)
																																				{
																																					if (self.modding)
																																						spellmod_install();
																																					else
																																						spellfire();
																																					
																																					self.LfingerC = time + self.spelltop;
																																				}
																																			}
																																			
																																			self.handy = 0;
																																		}
																																		if (self.handy == 3)
																																		{
																																			if ((self.Rsupport & SUPPORT_RADIUS) && (time > (self.RfingerC - ((self.spelltop * 0.36250)))))
																																			{
																																				if (self.predebt == 0)
																																				{
																																					if (self.modding)
																																						spellmod_install();
																																					else
																																						spellfire();
																																					
																																					self.RfingerC = time + self.spelltop;
																																				}
																																			}
																																			
																																			self.handy = 1;
																																		}
																																	} else {

																																		if ( (self.impulse == 64.00000) ) {
																																			sprint ( self, "test");
																																			return;

																																		} else {
																																			if ( (self.impulse == 65.00000) ) {
																																				make_flock();

																																			} else {


																																				if ( (self.impulse == 66.00000) ) {
																																					if (self.mage == 1) {
																																						personal_magic_shop(self);
																																					} else {
																																						return;
																																					}
																																				} else {

																																					if ( (self.impulse == 67.00000) ) {

																																						blood_control();

																																					} else {

																																						if ( (self.impulse == 68.00000) ) {
																																							if (survivor) {
																																								reset_inning_scores();
																																							} else {
																																								tell_flock();
																																							}
																																						} else {
																																							if ( (self.impulse == 69.00000) ) {
																																								if ((self.shopping == 0) && (deathmatch)) {
																																									gametype();
																																								}
																																								else
																																								{
																																									//multiply_monsters();
																																									magic_workbench();
																																									//tracevolume(self.origin, 30);
																																								}
/*																																							} else {

																																								if ( (self.impulse == 61.00000) ) {
																																									sprint(self, "BARF1");
																																									if (self.spellfired != 1) {
																																										sprint(self, "BARF2");

																																										if ( (time < self.magic_finished) ) {
																																											self.spellfired = 1;
																																											if ((self.menutype == 4) && (self.menuitem == 0)) {
																																												self.spellfired = 0;
																																											}
																																											if ((self.menutype == 0) && (self.menuitem == 1)) {
																																												self.spellfired = 0;
																																											}
																																											return;
																																										}
																																										spelly();

																																										if (self.dunk == 1)  {
																																											flash_toggle();
																																											self.hair = 0;
																																										}
																																										if (self.UFO == 1) {
																																											charge_readyfire();
																																										} else {


																																											if (self.menutype == 0) {

																																												if (self.menuitem == 2) {
																																													if (self.tele_dropped == 0) {                                                           
																																														DropTeleport( );
																																													} else {
																																														Teleport_to_drop();
																																													}
																																												}
																																												if (self.menuitem == 0) {

																																													time_warp();

																																												}

																																												if (self.menuitem == 1) {

																																													launch_pk( );

																																												}

																																												if (self.menuitem == 3) {
																																													
																																													CometFall();
																																													

																																												}
																																												if (self.menuitem == 4) {
																																													
																																													light_shell();
																																													

																																												}

																																												if (self.menuitem == 5) {
																																													
																																													photon_ball();
																																													

																																												}

																																											}
																																											if (self.menutype == 1) {

																																												if (self.menuitem == 0) {
																																													
																																													AxeSpikes();
																																													

																																												}

																																												if (self.menuitem == 1) {
																																													
																																													W_FireLeapFrog();                                                       
																																												}

																																												if (self.menuitem == 2) {
																																													
																																													balloffire_launch();                                                    
																																												}


																																												if (self.menuitem == 3) {
																																													
																																													obj_redM4();                                                    
																																												}

																																												if (self.menuitem == 4) {
																																													
																																													volcano_start();                                                        
																																												}

																																												if (self.menuitem == 5) {
																																													
																																													flare_drop();                                                   
																																												}


																																											}
																																											if (self.menutype == 3) {
																																												if (self.menuitem == 0) {
																																													
																																													windball_spawn();
																																													

																																												}

																																												if (self.menuitem == 1) {
																																													
																																													aero_init();
																																													

																																												}

																																												if (self.menuitem == 2) {
																																													
																																													bushbash_touch();
																																													

																																												}

																																												if (self.menuitem == 3) {
																																													
																																													TelluricRegen();
																																													

																																												}

																																												if (self.menuitem == 4) {
																																													
																																													launch_tol();
																																													

																																												}

																																												if (self.menuitem == 5) {
																																													
																																													twister_launch();
																																													

																																												}

																																											}
																																											if (self.menutype == 4) {
																																												if (self.menuitem == 0) {
																																													frost_launch();
																																												}
																																												if (self.menuitem == 1) {
																																													coldsp_launch();
																																												}
																																												if (self.menuitem == 2) {
																																													cage_launch();
																																												}
																																												if (self.menuitem == 3) {
																																													launch_crushdrop();
																																												}
																																												if (self.menuitem == 4) {
																																													LaunchGlacierspawner();
																																												}
																																												if (self.menuitem == 5) {
																																													//pblast_launch();                                                      
																																													tsunami_launch();
																																												}
																																											}

																																											if (self.menutype == 2) {
																																												if (self.menuitem == 0) {
																																													//       DropZap ( );
																																													obj_yellowM1();
																																													
																																													
																																												}

																																												if (self.menuitem == 1) {
																																													spire_drop ( );
																																													
																																												}

																																												if (self.menuitem == 2) {

																																													deatharc_launch ( );
																																													
																																												}

																																												if (self.menuitem == 3) {

																																													SlideDrop ( );
																																													
																																												}

																																											}

																																											if (self.menutype == 5) {
																																												//if (self.menuitem == 0) {

																																												//shadow_squash();

																																												//}

																																												if (self.menuitem == 3) {

																																													dark_matter_init();

																																												}

																																												if (self.menuitem == 4) {

																																													darkbeam();

																																												}

																																												if (self.menuitem == 5) {
																																													
																																													bh_ball_drop();
																																													
																																												}

																																												if (self.menuitem == 2) {
																																													
																																													AxeSpikes();
																																													
																																												}
																																												if (self.menuitem == 1) {
																																													
																																													blackdeath_swoop ( );
																																													
																																												}

																																											}

																																										}
																																									}    





																																									

*/


																																								} else {



																																									if ( ((self.impulse >= 100.00000) && (self.impulse <= 115.00000)) ) {

																																										Inventory_Quick ( (self.impulse - 99.00000));
																																									} else {


																																										if ( (self.impulse == 254.00000) ) {

																																											sprint ( self, "King of the Hill is ");
																																											search = FindExpLeader ( );
																																											sprint ( self, search.netname);
																																											sprint ( self, " (EXP = ");
																																											sprint ( self, ftos ( search.experience));
																																											sprint ( self, ") \n");
																																										} else {

																																											if ( (self.impulse == 255.00000) ) {

																																												PrintFrags ( );


																																											}

																																										}

																																									}

																																								}

																																							//}

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

																								if ( (self.model == "models/sheep.mdl") ) {

																									self.impulse = 0.00000;
																									return ;
																								} else {

																									if ((self.impulse == 1) && (self.UFO == 1)) {
																										self.lip = 0;
																										sprint (self, "anti-air mode\n");
																									} else {
																										if ((self.impulse == 2) && (self.UFO == 1)) {
																											self.lip = 1;
																											sprint (self, "anti-ground mode\n");
																										} else {

																											if ( ((self.impulse >= 1.00000) && (self.impulse <= 10.00000) && (self.shopping == 1)) ) {

																												self.selection = self.impulse;

																											} else {


																												if ( ((self.impulse >= 1.00000) && (self.impulse <= 5.00000)) ) {

																													W_ChangeWeapon ( );
																												} else {


																													if ( ((self.impulse == 10.00000) && (wp_deselect == 0.00000)) ) {

																														CycleWeaponCommand ( );
																													} else {

																														if ( (self.impulse == 11.00000) ) {

																															ServerflagsCommand ( );
																														} else {

																															if ( (self.impulse == 12.00000) ) {

																																CycleWeaponReverseCommand ( );
																															} else {

																																if ( (self.impulse == 13.00000) ) {

																																	HeaveHo ( );
																																} else {

																																	if ( ((self.impulse == 22.00000) && !(self.flags2 & FL2_CROUCHED)) ) {

																																		if ( (self.flags2 & FL2_CROUCH_TOGGLE) ) {

																																			self.flags2 ^= FL2_CROUCH_TOGGLE;
																																		} else {

																																			self.flags2 |= FL2_CROUCH_TOGGLE;

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
				}
			}
		}
	}
	if ( (self.lifting == TRUE) ) {

		HeaveHo_think ( );

	}

	if ((self.cscale == 1) && (self.magic_finished < time)) {
		transporter_active = 1;
		self.cscale = 0;
		prepare_thyself(self);
	}

	self.impulse = 0.00000;
};

