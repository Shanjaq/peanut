entity self;
entity other;
entity world;
float time;
float frametime;
float force_retouch;
string mapname;
string startspot;
float deathmatch;
float randomclass;
float coop;
float teamplay;
float serverflags;
float total_secrets;
float total_monsters;
float found_secrets;
float killed_monsters;
float chunk_cnt;
float done_precache;
float parm1;
float parm2;
float parm4;
float parm5;
float parm6;
float parm7;
float parm8;
float parm9;
float parm10;
float parm11;
float parm12;
float parm13;
float parm14;
float parm15;
float parm16;
string parm3;
vector v_forward;
vector v_up;
vector v_right;
float trace_allsolid;
float trace_startsolid;
float trace_fraction;
vector trace_endpos;
vector trace_plane_normal;
float trace_plane_dist;
entity trace_ent;
float trace_inopen;
float trace_inwater;
entity msg_entity;
float cycle_wrapped;
float crouch_cnt;
float modelindex_assassin;
float modelindex_crusader;
float modelindex_paladin;
float modelindex_necromancer;
float modelindex_sheep;
float num_players;
float exp_mult;
void  ()main;
void  ()StartFrame;
void  ()PlayerPreThink;
void  ()PlayerPostThink;
void  ()ClientKill;
void  ()ClientConnect;
void  ()PutClientInServer;
void  (float TimeDiff)ClientReEnter;
void  ()ClientDisconnect;
void  ()ClassChangeWeapon;
void end_sys_globals;
float movedist;
float gameover;
string string_null   =  "";
entity newmis;
entity activator;
entity damage_attacker;
float framecount;
float skill;
float multim;
float wp_deselect;
.float modelindex;
.vector absmin;
.vector absmax;
.float ltime;
.float movetype;
.float solid;
.vector origin;
.vector oldorigin;
.vector velocity;
.vector angles;
.vector avelocity;
.vector punchangle;
.string classname;
.string model;
.float frame;
.float skin;
.float effects;
.float scale;
.float drawflags;
.float abslight;
.vector mins;
.vector maxs;
.vector size;
.float hull;
.void  () touch;
.void  () use;
.void  () think;
.void  () blocked;
.float nextthink;
.entity groundentity;
.float stats_restored;
.float frags;
.float weapon;
.string weaponmodel;
.float weaponframe;
.float health;
.float max_health;
.float playerclass;
.float bluemana;
.float greenmana;
.float max_mana;
.float armor_amulet;
.float armor_bracer;
.float armor_breastplate;
.float armor_helmet;
.float level;
.float intelligence;
.float wisdom;
.float dexterity;
.float strength;
.float experience;
.float ring_flight;
.float ring_water;
.float ring_turning;
.float ring_regeneration;
.float haste_time;
.float tome_time;
.string puzzle_inv1;
.string puzzle_inv2;
.string puzzle_inv3;
.string puzzle_inv4;
.string puzzle_inv5;
.string puzzle_inv6;
.string puzzle_inv7;
.string puzzle_inv8;
.float experience_value;
.float items;
.float takedamage;
.entity chain;
.float deadflag;
.vector view_ofs;
.float button0;
.float button1;
.float button2;
.float impulse;
.float fixangle;
.vector v_angle;
.float idealpitch;
.float idealroll;
.float hoverz;
.string netname;
.entity enemy;
.float flags;
.float flags2;
.float artifact_flags;
.float colormap;
.float team;
.float light_level;
.float teleport_time;
.float armortype;
.float armorvalue;
.float waterlevel;
.float watertype;
.float friction;
.float ideal_yaw;
.float yaw_speed;
.entity goalentity;
.float spawnflags;
.string target;
.string targetname;
.float dmg_take;
.float dmg_save;
.entity dmg_inflictor;
.entity owner;
.vector movedir;
.float message;
.float soundtype;
.string noise;
.string noise1;
.string noise2;
.string noise3;
.float rings;
.float rings_active;
.float rings_low;
.float artifacts;
.float artifact_active;
.float artifact_low;
.float hasted;
.float inventory;
.float cnt_torch;
.float cnt_h_boost;
.float cnt_sh_boost;
.float cnt_mana_boost;
.float cnt_teleport;
.float cnt_tome;
.float cnt_summon;
.float cnt_invisibility;
.float cnt_glyph;
.float cnt_haste;
.float cnt_blast;
.float cnt_polymorph;
.float cnt_flight;
.float cnt_cubeofforce;
.float cnt_invincibility;
.entity cameramode;
.entity movechain;
.void  () chainmoved;
.float string_index;
void end_sys_fields;
.string wad;
.string map;
.float worldtype;
.string killtarget;
.float light_lev;
.float style;
.void  () th_stand;
.void  () th_walk;
.void  () th_run;
.void  () th_missile;
.void  () th_melee;
.void  (entity attacker,float damage) th_pain;
.void  () th_die;
.void  () th_save;
.entity oldenemy;
.float speed;
.float lefty;
.float search_time;
.float attack_state;
.float monster_stage;
.float monster_duration;
.float monster_awake;
.float monster_check;
.float cloud_style alias monster_stage;
.float cloud_height alias monster_duration;
.float sale alias monster_stage;
.vector monster_last_seen;
.vector adjust_velocity;
.vector menuspin;
.float splash_time;
.float camera_time;
.float weaponframe_cnt;
.float attack_cnt;
.float ring_regen_time;
.float ring_flight_time;
.float ring_water_time;
.float ring_turning_time;
.float super_damage;
.float super_damage_low;
.float puzzles_cheat;
.float camptime;
.float crouch_time;
.float crouch_stuck;
.float divine_time;
.float act_state;
.float raven_cnt;
.float newclass;
.float fangel_SaveFrame alias splash_time;
.float fangel_Count alias camera_time;
.float shoot_cnt alias weaponframe_cnt;
.float shoot_time alias attack_cnt;
.float z_movement alias ring_regen_time;
.float z_duration alias ring_flight_time;
.float drop_time alias ring_water_time;
.float spell_angle alias splash_time;
.float hydra_FloatTo alias splash_time;
.float hydra_chargeTime alias camera_time;
.float spiderType alias splash_time;
.float spiderActiveCount alias camera_time;
.float spiderGoPause alias weaponframe_cnt;
.float spiderPauseLength alias attack_cnt;
.float spiderPauseCount alias ring_regen_time;
.float scorpionType alias splash_time;
.float scorpionRest alias camera_time;
.float scorpionWalkCount alias weaponframe_cnt;
.float golemSlideCounter alias splash_time;
.float golemBeamDelay alias camera_time;
.float golemBeamOff1 alias weaponframe_cnt;
.float golemBeamOff2 alias attack_cnt;
.float impType alias splash_time;
.float parts_gone alias splash_time;
.float mummy_state alias camera_time;
.float mummy_state_time alias weaponframe_cnt;
.float artifact_respawn alias splash_time;
.float artifact_ignore_owner_time alias camera_time;
.float artifact_ignore_time alias weaponframe_cnt;
.float next_path_1 alias splash_time;
.float next_path_2 alias camera_time;
.float next_path_3 alias weaponframe_cnt;
.float next_path_4 alias attack_cnt;
.float path_id alias ring_regen_time;
.float next_path_5 alias ring_flight_time;
.float next_path_6 alias ring_water_time;
.float rt_chance alias splash_time;
.float rider_gallop_mode alias splash_time;
.float rider_last_y_change alias camera_time;
.float rider_y_change alias weaponframe_cnt;
.float rider_death_speed alias attack_cnt;
.float rider_path_distance alias ring_regen_time;
.float rider_move_adjustment alias ring_flight_time;
.float waraxe_offset alias splash_time;
.float waraxe_horizontal alias camera_time;
.float waraxe_track_inc alias weaponframe_cnt;
.float waraxe_track_limit alias attack_cnt;
.float waraxe_max_speed alias ring_regen_time;
.float waraxe_max_height alias ring_flight_time;
.float wrq_effect_id alias splash_time;
.float wrq_radius alias camera_time;
.float wrq_count alias weaponframe_cnt;
.float beam_angle_a alias splash_time;
.float beam_angle_b alias camera_time;
.float beam_max_scale alias weaponframe_cnt;
.float beam_direction alias attack_cnt;
.float beam_speed alias ring_regen_time;
.float z_modifier alias splash_time;
.float last_health alias splash_time;
.float pitchdowntime alias splash_time;
.float searchtime alias camera_time;
.float next_action alias weaponframe_cnt;
.float damage_max alias attack_cnt;
.float fish_speed alias splash_time;
.float fish_leader_count alias camera_time;
.float exploderadius alias splash_time;
.float scream_time alias splash_time;
.float beginframe alias splash_time;
.float sound_time alias splash_time;
.float shot_cnt alias splash_time;
.float inv_spellmods alias monster_awake;
.float monsterclass;
.float melee_rate_low alias artifact_low;
.float melee_rate_high alias super_damage_low;
.float missile_rate_low alias rings_low;
.float missile_rate_high alias monster_check;
.float missile_count alias monsterclass;
.float turn_time;
.float failchance;
.string failtarget;
.string puzzle_piece_1;
.string puzzle_piece_2;
.string puzzle_piece_3;
.string puzzle_piece_4;
.float no_puzzle_msg;
.string puzzle_id;
.entity path_current;
.vector oldangles;
.string lastweapon;
.float lifetime;
.float lifespan;
.float walkframe;
.float wfs;
.float elemana;
.float attack_finished;
.float magic_finished;
.float pain_finished;
.float invisible_finished;
.float invincible_time;
.float invincible_sound;
.float invisible_time;
.float super_damage_time;
.float show_hostile;
.float jump_flag;
.float swim_flag;
.float air_finished;
.float bubble_count;
.string deathtype;
.string mdl;
.vector mangle;
.float t_length;
.float t_width;
.float color;
.float counter;
.float plaqueflg;
.vector plaqueangle;
.vector dest;
.vector dest1;
.vector dest2;
.float wait;
.float delay;
.entity trigger_field;
.string noise4;
.float pausetime;
.entity pathentity;
.float aflag;
.float dmg;
.float cnt;
.float thingtype;
.float torchtime;
.void  () torchthink;
.float healthtime;
.void  () think1;
.vector finaldest;
.vector finalangle;
.float count;
.float spawn_health;
.float lip;
.float trap_count alias lip;
.float type_index alias lip;
.float state;
.vector pos1;
.vector pos2;
.float height;
.vector orgnl_mins;
.vector orgnl_maxs;
.float veer;
.float homerate;
.float mass;
.float onfire;
.vector o_angle;
.float bloodloss;
.float oldweapon;
.entity controller;
.float init_modelindex;
.string init_model;
.void  () th_swim;
.void  () th_jump;
.void  () th_fly;
.void  () th_die1;
.void  () th_die2;
.void  () th_goredeath;
.void  () th_possum;
.void  () th_possum_up;
.float last_attack;
.entity shield;
.float frozen;
.float oldskin;
.void  () oldthink;
.void  () th_weapon;
.float decap;
.string headmodel;
.void  () oldtouch;
.float oldmovetype;
.float target_scale;
.float scalerate;
.float blizzcount;
.float tripwire_cnt;
.float imp_count;
.vector proj_ofs;
.string spawnername;
.entity catapulter;
.entity chain2 alias catapulter;
.float catapult_time;
.float last_onground;
.vector pos_ofs;
.vector angle_ofs;
.float safe_time;
.float absorb_time;
.float mintel;
.vector wallspot;
.vector lastwaypointspot;
.entity lockentity;
.float last_impact;
.float inactive;
.float msg2;
.string msg3;
.string nexttarget;
.float gravity;
.float upside_down;
.float lightvalue1;
.float lightvalue2;
.float fadespeed;
.float point_seq;
.float sheep_time;
.float sheep_sound_time;
.float still_time;
.float visibility_offset;
.float check_ok;
.entity check_chain;
.void  () th_spawn;
.float freeze_time;
.float level_frags;
.float visibility;
entity sight_entity;
.entity viewentity;
.float sv_flags;
.float dmgtime;
.float healamount;
.float healtype;
.float anglespeed;
.float angletime;
.float movetime;
.float hit_z;
.float torncount;
.entity path_last;
.float dflags;
.entity teledrop_dest;
.entity jones;
.float tele_dropped; 
vector tp;
.float shownmotd;
.float money;
.float stepy;	//steps in chain(starts in colour)
.float step1;	//colour
.float step2;	//item
.float step3;	//hand
.float step4;	//finger
.float glow_dest alias step1;
.float glow_last alias step2;
.float glow_time alias step3;
.float glow_delay alias step4;
entity chars;
.float charsaved;
float nextsave;
//player 1 data
.string P1name;
.float P1Lfinger1S, P1Lfinger2S, P1Lfinger3S, P1Lfinger4S, P1Lfinger5S;
.float P1Rfinger1S, P1Rfinger2S, P1Rfinger3S, P1Rfinger4S, P1Rfinger5S;
.float P1Lfinger1Support, P1Lfinger2Support, P1Lfinger3Support, P1Lfinger4Support, P1Lfinger5Support;
.float P1Rfinger1Support, P1Rfinger2Support, P1Rfinger3Support, P1Rfinger4Support, P1Rfinger5Support;
.float P1money;
.float P1items;

//player 2 data
.string P2name;
.float P2Lfinger1S, P2Lfinger2S, P2Lfinger3S, P2Lfinger4S, P2Lfinger5S;
.float P2Rfinger1S, P2Rfinger2S, P2Rfinger3S, P2Rfinger4S, P2Rfinger5S;
.float P2Lfinger1Support, P2Lfinger2Support, P2Lfinger3Support, P2Lfinger4Support, P2Lfinger5Support;
.float P2Rfinger1Support, P2Rfinger2Support, P2Rfinger3Support, P2Rfinger4Support, P2Rfinger5Support;
.float P2money;
.float P2items;
.float sheep;
.float allexp;
.float handy;
.float modding;
.float fingery;
.float Lfinger;
.float Rfinger;
.float Lspell;
.float Rspell;
.float Lsupport;
.float Rsupport;
float SUPPORT_CASTSPEED = 1.00000;
float SUPPORT_MULTI = 2.00000;
float SUPPORT_DAMAGE = 4.00000;
float SUPPORT_RADIUS = 8.00000;
float SUPPORT_TRAP = 16.00000;
float cast_time[37] = { 0,
	1.5, 2, 3, 4, 5, 7,
	1.2, 2, 2.5, 5, 5, 7,
	2, 2, 2.5, 1.5, 5, 7,
	2, 2, 2.5, 3, 5, 7,
	2, 2, 2.5, 4, 5, 7,
	5, 2.5, 4, 5, 5, 7
};
float spell_support[37] = { 31,
	27, 4, 1, 31, 31, 29,
	23, 23, 31, 29, 31, 31,
	31, 31, 23, 31, 31, 29,
	5, 31, 29, 1, 12, 29,
	5, 31, 19, 31, 29, 21,
	29, 23, 29, 31, 31, 25
};
float spell_cost[37] = { 0,
	7, 5, 10, 20, 30, 40,
	4, 5, 10, 15, 25, 40,
	4, 8, 10, 6, 16, 35,
	2, 10, 15, 20, 30, 35,
	1, 5, 7, 15, 25, 35,
	10, 15, 20, 25, 30, 40
};
float spell_damage[37] = { 0,
	0, 0, 0, 60, 22, 16,
	6, 26, 28, 28, 30, 38,
	12, 14, 12, 21, 32, 40,
	4, 10, 128, 20, 30, 35,
	2, 8, 7, 26, 32, 8,
	7, 2, 20, 8, 30, 40
};
float spell_price[36] = {
	200, 250, 350, 400, 500, 725,
	150, 300, 350, 450, 550, 700,
	250, 300, 350, 375, 400, 650,
	300, 350, 400, 425, 550, 650,
	200, 250, 320, 450, 500, 600,
	300, 350, 400, 450, 580, 725
};
float spell_type[37] = { 0,
	4, 0, 0, 1, 2, 2,
	0, 0, 3, 2, 2, 2,
	0, 3, 3, 0, 2, 2,
	0, 4, 1, 0, 0, 2,
	0, 3, 1, 2, 2, 2,
	4, 1, 2, 2, 2, 2
};
float magic_affinity[24] = {
	1.35, 0.65, 1.00, 1.00, 1.35, 0.65,
	1.00, 0.65, 1.35, 1.35, 1.00, 0.65,
	0.65, 1.35, 1.00, 1.00, 0.65, 1.35,
	0.65, 1.00, 1.35, 0.65, 1.35, 1.00
};
float SPELL_TYPE_NULL = 0;
float SPELL_TYPE_PROJ = 1;
float SPELL_TYPE_PROJ_SLOW = 2;
float SPELL_TYPE_PROJ_CUSTOM = 3;
float SPELL_TYPE_TRACE = 4;
.float spelltop;
.float spellcost;
.float spelldamage;
.float spellradiusmod;
.float Lfinger1S, Lfinger2S, Lfinger3S, Lfinger4S, Lfinger5S;
.float Rfinger1S, Rfinger2S, Rfinger3S, Rfinger4S, Rfinger5S;
.float Lfinger1Support, Lfinger2Support, Lfinger3Support, Lfinger4Support, Lfinger5Support;
.float Rfinger1Support, Rfinger2Support, Rfinger3Support, Rfinger4Support, Rfinger5Support;
.float LfingerC;
.float RfingerC;
.float mage;
.float menubar_type alias armorvalue;
.float lifting;
float heresy;
float survivor;
.float spellfired;
.float inning_time;
.float best_inning_time;
.float UFO;
.float cscale;
.float menuhand;
.float menutime;
.float htype;
float STATUS_BURNING = 1;
float STATUS_POISON = 2;
.float status_effects;
.float arrows;
float transporter_active;
.float phaseout;
.float halted;
.float click;
.float ions;
.float cations;
.float cskin;
float bloodcount;
.float prehealth;
.float drip;
.float drop;
float bee;
.float auraV;
float Ccolor;
.float auraT;
.float shopping;
.float selection;
.float choice;
.float flash_flag; // On/off for the flashlight
.entity flash;   // flash entity
.entity I0;
.entity I1;
.entity I2;
.entity I3;
.entity I4;
.entity I5;
.entity Mmyring;
.float menuitem;
.float menutype;
.float dunk;
.float pie;
.float hair;
.float debt;
float clap;
.float predebt;
.string close_target;
.float monsterlevel; // BAER so monsters can level up with the player
//Shan now used for player events per-second
.float poisoncount;
.float healthcount;
.vector stickydir;	// BAER for the paladin glyph reference.
.float max_scale;	   // BAER for the spiders and anything else
.float glyph_time;	// BAER to stop the chaingunning effect of glyphs
//string nextmap;
float FALSE   =  0.00000;
float TRUE   =  1.00000;
float HX_FRAME_TIME   =  0.05000;
float HX_FPS   =  20.00000;
float FL_FLY   =  1.00000;
float FL_SWIM   =  2.00000;
float FL_PUSH   =  4.00000;
float FL_CLIENT   =  8.00000;
float FL_INWATER   =  16.00000;
float FL_MONSTER   =  32.00000;
float FL_GODMODE   =  64.00000;
float FL_NOTARGET   =  128.00000;
float FL_ITEM   =  256.00000;
float FL_ONGROUND   =  512.00000;
float FL_PARTIALGROUND   =  1024.00000;
float FL_WATERJUMP   =  2048.00000;
float FL_JUMPRELEASED   =  4096.00000;
float FL_FLASHLIGHT   =  8192.00000;
float FL_ARTIFACTUSED   =  16384.00000;
float FL_MOVECHAIN_ANGLE   =  32768.00000;
float FL_FIRERESIST   =  65536.00000;
float FL_FIREHEAL   =  131072.00000;
float FL_COLDHEAL   =  524288.00000;
float FL_ARCHIVE_OVERRIDE   =  1048576.00000;
float FL_CLASS_DEPENDENT   =  2097152.00000;
float FL_SPECIAL_ABILITY1   =  4194304.00000;
float FL_SPECIAL_ABILITY2   =  8388608.00000;
float FL2_ADJUST_MON_DAM   =  1.00000;
float FL_NODAMAGE   =  2.00000;
float FL_SMALL   =  4.00000;
float FL_ALIVE   =  8.00000;
float FL_FAKE_WATER   =  16.00000;
float FL_SUMMONED   =  32.00000;
float FL_LEDGEHOLD   =  64.00000;
float FL_TORNATO_SAFE   =  512.00000;
float FL2_DEADMEAT				= 1024;		//Tagged for death
float FL_CHAINED   =  2048.00000;
float FL2_CROUCHED   =  4096.00000;
float FL2_CROUCH_TOGGLE   =  8192.00000;
float MLS_MASKIN   =  7.00000;
float MLS_MASKOUT   =  248.00000;
float MLS_NONE   =  0.00000;
float MLS_FULLBRIGHT   =  1.00000;
float MLS_POWERMODE   =  2.00000;
float MLS_TORCH   =  3.00000;
float MLS_FIREFLICKER   =  4.00000;
float MLS_CRYSTALGOLEM   =  5.00000;
float MLS_ABSLIGHT   =  7.00000;
float SCALE_TYPE_MASKIN   =  24.00000;
float SCALE_TYPE_MASKOUT   =  231.00000;
float SCALE_TYPE_UNIFORM   =  0.00000;
float SCALE_TYPE_XYONLY   =  8.00000;
float SCALE_TYPE_ZONLY   =  16.00000;
float SCALE_ORIGIN_MASKIN   =  96.00000;
float SCALE_ORIGIN_MASKOUT   =  159.00000;
float SCALE_ORIGIN_CENTER   =  0.00000;
float SCALE_ORIGIN_BOTTOM   =  32.00000;
float SCALE_ORIGIN_TOP   =  64.00000;
float DRF_TRANSLUCENT   =  128.00000;
float AFL_CUBE_RIGHT   =  1.00000;
float AFL_CUBE_LEFT   =  2.00000;
float AFL_TORCH   =  4.00000;
float AFL_SUPERHEALTH   =  8.00000;
float MOVETYPE_NONE   =  0.00000;
float MOVETYPE_WALK   =  3.00000;
float MOVETYPE_STEP   =  4.00000;
float MOVETYPE_FLY   =  5.00000;
float MOVETYPE_TOSS   =  6.00000;
float MOVETYPE_PUSH   =  7.00000;
float MOVETYPE_NOCLIP   =  8.00000;
float MOVETYPE_FLYMISSILE   =  9.00000;
float MOVETYPE_BOUNCE   =  10.00000;
float MOVETYPE_BOUNCEMISSILE   =  11.00000;
float MOVETYPE_PUSHPULL   =  13.00000;
float MOVETYPE_SWIM   =  14.00000;
float PARTICLETYPE_STATIC   =  0.00000;
float PARTICLETYPE_GRAV   =  1.00000;
float PARTICLETYPE_FASTGRAV   =  2.00000;
float PARTICLETYPE_SLOWGRAV   =  3.00000;
float PARTICLETYPE_FIRE   =  4.00000;
float PARTICLETYPE_EXPLODE   =  5.00000;
float PARTICLETYPE_EXPLODE2   =  6.00000;
float PARTICLETYPE_BLOB   =  7.00000;
float PARTICLETYPE_BLOB2   =  8.00000;
float PARTICLETYPE_RAIN   =  9.00000;
float PARTICLETYPE_C_EXPLODE   =  10.00000;
float PARTICLETYPE_C_EXPLODE2   =  11.00000;
float PARTICLETYPE_SPIT   =  12.00000;
float PARTICLETYPE_FIREBALL   =  13.00000;
float PARTICLETYPE_ICE   =  14.00000;
float PARTICLETYPE_SPELL   =  15.00000;
float HULL_IMPLICIT   =  0.00000;
float HULL_POINT   =  1.00000;
float HULL_PLAYER   =  2.00000;
float HULL_SCORPION   =  3.00000;
float HULL_CROUCH   =  4.00000;
float HULL_HYDRA   =  5.00000;
float HULL_GOLEM   =  6.00000;
float HULL_OLD   =  0.00000;
float HULL_SMALL   =  1.00000;
float HULL_NORMAL   =  2.00000;
float HULL_BIG   =  3.00000;
float SOLID_NOT   =  0.00000;
float SOLID_TRIGGER   =  1.00000;
float SOLID_BBOX   =  2.00000;
float SOLID_SLIDEBOX   =  3.00000;
float SOLID_BSP   =  4.00000;
float SOLID_PHASE   =  5.00000;
float RANGE_MELEE   =  0.00000;
float RANGE_NEAR   =  1.00000;
float RANGE_MID   =  2.00000;
float RANGE_FAR   =  3.00000;
float DEAD_NO   =  0.00000;
float DEAD_DYING   =  1.00000;
float DEAD_DEAD   =  2.00000;
float DEAD_RESPAWNABLE   =  3.00000;
float DAMAGE_NO   =  0.00000;
float DAMAGE_YES   =  1.00000;
float DAMAGE_AIM = 2;
float DAMAGE_NO_GRENADE   =  2.00000;
float INV_NONE   =  0.00000;
float INV_TORCH   =  1.00000;
float INV_HP_BOOST   =  2.00000;
float INV_SUPER_HP_BOOST   =  3.00000;
float INV_MANA_BOOST   =  4.00000;
float INV_TELEPORT   =  5.00000;
float INV_TOME   =  6.00000;
float INV_SUMMON   =  7.00000;
float INV_INVISIBILITY   =  8.00000;
float INV_GLYPH   =  9.00000;
float INV_HASTE   =  10.00000;
float INV_BLAST   =  11.00000;
float INV_POLYMORPH   =  12.00000;
float INV_FLIGHT   =  13.00000;
float INV_CUBEOFFORCE   =  14.00000;
float INV_INVINCIBILITY   =  15.00000;
float ARTIFACT_TORCH   =  1.00000;
float ARTIFACT_HP_BOOST   =  2.00000;
float ARTIFACT_SUPER_HP_BOOST   =  3.00000;
float ARTIFACT_MANA_BOOST   =  4.00000;
float ARTIFACT_TELEPORT   =  5.00000;
float ARTIFACT_TOME   =  6.00000;
float ARTIFACT_SUMMON   =  7.00000;
float ARTIFACT_INVISIBILITY   =  8.00000;
float ARTIFACT_GLYPH   =  9.00000;
float ARTIFACT_HASTE   =  10.00000;
float ARTIFACT_BLAST   =  11.00000;
float ARTIFACT_POLYMORPH   =  12.00000;
float ARTIFACT_FLIGHT   =  13.00000;
float ARTIFACT_CUBEOFFORCE   =  14.00000;
float ARTIFACT_INVINCIBILITY   =  15.00000;
float ARTIFACT_SPELL_ACCELERATOR   =  16.00000;
float ARTIFACT_SPELL_PRISM   =  17.00000;
float ARTIFACT_SPELL_AMPLIFIER   =  18.00000;
float ARTIFACT_SPELL_MAGNIFIER   =  19.00000;
float ARTIFACT_SPELL_TRAP   =  20.00000;
float RING_NONE   =  0.00000;
float RING_FLIGHT   =  1.00000;
float RING_WATER   =  2.00000;
float RING_REGENERATION   =  4.00000;
float RING_TURNING   =  8.00000;
float ART_NONE   =  0.00000;
float ART_HASTE   =  1.00000;
float ART_INVINCIBILITY   =  2.00000;
float ART_TOMEOFPOWER   =  4.00000;
float ART_INVISIBILITY   =  8.00000;
float ARTFLAG_FROZEN   =  128.00000;
float ARTFLAG_STONED   =  256.00000;
float ARTFLAG_DIVINE_INTERVENTION   =  512.00000;
float GLOBAL_SKIN_STONE   =  100.00000;
float GLOBAL_SKIN_ICE   =  101.00000;
float CLASS_NONE   =  0.00000;
float CLASS_PALADIN   =  1.00000;
float CLASS_CRUSADER   =  2.00000;
float CLASS_NECROMANCER   =  3.00000;
float CLASS_ASSASSIN   =  4.00000;
float CLASS_GRUNT   =  1.00000;
float CLASS_HENCHMAN   =  2.00000;
float CLASS_LEADER   =  3.00000;
float CLASS_BOSS   =  4.00000;
float CLASS_FINAL_BOSS   =  5.00000;
float MAX_HEALTH   =  200.00000;
float MODE_NORMAL   =  0.00000;
float MODE_CAMERA   =  1.00000;
float AS_STRAIGHT   =  1.00000;
float AS_SLIDING   =  2.00000;
float AS_MELEE   =  3.00000;
float AS_MISSILE   =  4.00000;
float AS_WAIT   =  5.00000;
float AS_FERRY   =  6.00000;
float IT_WEAPON1   =  4096.00000;
float IT_WEAPON2   =  1.00000;
float IT_WEAPON3   =  2.00000;
float IT_WEAPON4   =  4.00000;
float IT_WEAPON5   =  5.00000;
float IT_TESTWEAP   =  8.00000;
float IT_WEAPON4_1   =  16.00000;
float IT_WEAPON4_2   =  32.00000;
float IT_GAUNTLETS   =  4096.00000;
float IT_AXE   =  4096.00000;
float IT_SHOTGUN   =  1.00000;
float IT_SUPER_SHOTGUN   =  2.00000;
float IT_NAILGUN   =  4.00000;
float IT_SUPER_NAILGUN   =  8.00000;
float IT_GRENADE_LAUNCHER   =  16.00000;
float IT_ROCKET_LAUNCHER   =  32.00000;
float IT_LIGHTNING   =  64.00000;
float IT_EXTRA_WEAPON   =  128.00000;
float IT_ARMOR1   =  8192.00000;
float IT_ARMOR2   =  16384.00000;
float IT_ARMOR3   =  32768.00000;
float IT_SUPERHEALTH   =  65536.00000;
float IT_INVISIBILITY   =  524288.00000;
float IT_INVULNERABILITY   =  1048576.00000;
float IT_SUIT   =  2097152.00000;
float IT_QUAD   =  4194304.00000;
float FLIGHT_TIME   =  30.00000;
float WATER_TIME   =  30.00000;
float ABSORPTION_TIME   =  30.00000;
float REGEN_TIME   =  30.00000;
float TURNING_TIME   =  30.00000;
float HASTE_TIME   =  15.00000;
float TOME_TIME   =  30.00000;
float IT_TRACTOR_BEAM   =  128.00000;
float RESPAWN_TIME   =  30.00000;
float WEAPON1_BASE_DAMAGE   =  12.00000;
float WEAPON1_ADD_DAMAGE   =  12.00000;
float WEAPON1_PWR_BASE_DAMAGE   =  30.00000;
float WEAPON1_PWR_ADD_DAMAGE   =  20.00000;
float WEAPON1_PUSH   =  5.00000;
float GLYPH_BASE_DAMAGE   =  100.00000;
float GLYPH_ADD_DAMAGE   =  20.00000;
float BLAST_RADIUS   =  200.00000;
float BLASTDAMAGE   =  2.00000;
float DMG_ARCHER_PUNCH   =  4.00000;
float DMG_MUMMY_PUNCH   =  8.00000;
float DMG_MUMMY_BITE   =  2.00000;
float THINGTYPE_GREYSTONE   =  1.00000;
float THINGTYPE_WOOD   =  2.00000;
float THINGTYPE_METAL   =  3.00000;
float THINGTYPE_FLESH   =  4.00000;
float THINGTYPE_FIRE   =  5.00000;
float THINGTYPE_CLAY   =  6.00000;
float THINGTYPE_LEAVES   =  7.00000;
float THINGTYPE_HAY   =  8.00000;
float THINGTYPE_BROWNSTONE   =  9.00000;
float THINGTYPE_CLOTH   =  10.00000;
float THINGTYPE_WOOD_LEAF   =  11.00000;
float THINGTYPE_WOOD_METAL   =  12.00000;
float THINGTYPE_WOOD_STONE   =  13.00000;
float THINGTYPE_METAL_STONE   =  14.00000;
float THINGTYPE_METAL_CLOTH   =  15.00000;
float THINGTYPE_WEBS   =  16.00000;
float THINGTYPE_GLASS   =  17.00000;
float THINGTYPE_ICE   =  18.00000;
float THINGTYPE_CLEARGLASS   =  19.00000;
float THINGTYPE_REDGLASS   =  20.00000;
float CONTENT_EMPTY   =  -1.00000;
float CONTENT_SOLID   =  -2.00000;
float CONTENT_WATER   =  -3.00000;
float CONTENT_SLIME   =  -4.00000;
float CONTENT_LAVA   =  -5.00000;
float CONTENT_SKY   =  -6.00000;
float STATE_TOP   =  0.00000;
float STATE_BOTTOM   =  1.00000;
float STATE_UP   =  2.00000;
float STATE_DOWN   =  3.00000;
float STATE_MOVING   =  4.00000;
vector VEC_ORIGIN   =  '0.00000 0.00000 0.00000';
vector VEC_HULL_MIN   =  '-16.00000 -16.00000 -24.00000';
vector VEC_HULL_MAX   =  '16.00000 16.00000 32.00000';
vector VEC_HULL2_MIN   =  '-32.00000 -32.00000 -24.00000';
vector VEC_HULL2_MAX   =  '32.00000 32.00000 64.00000';
float SVC_TEMPENTITY   =  23.00000;
float SVC_KILLEDMONSTER   =  27.00000;
float SVC_FOUNDSECRET   =  28.00000;
float SVC_INTERMISSION   =  30.00000;
float SVC_FINALE   =  31.00000;
float SVC_CDTRACK   =  32.00000;
float SVC_SELLSCREEN   =  33.00000;
float SVC_SET_VIEW_FLAGS   =  40.00000;
float SVC_CLEAR_VIEW_FLAGS   =  41.00000;
float SVC_SET_VIEW_TINT   =  46.00000;
float XF_TORCH_GLOW = 1.00000;
float XF_GLOW = 2.00000;
float XF_MISSILE_GLOW = 4.00000;
float XF_COLOR_LIGHT = 8.00000;
float CE_RAIN   =  1.00000;
float CE_FOUNTAIN   =  2.00000;
float CE_QUAKE   =  3.00000;
float CE_WHITE_SMOKE   =  4.00000;
float CE_BLUESPARK   =  5.00000;
float CE_YELLOWSPARK   =  6.00000;
float CE_SM_CIRCLE_EXP   =  7.00000;
float CE_BG_CIRCLE_EXP   =  8.00000;
float CE_SM_WHITE_FLASH   =  9.00000;
float CE_WHITE_FLASH   =  10.00000;
float CE_YELLOWRED_FLASH   =  11.00000;
float CE_BLUE_FLASH   =  12.00000;
float CE_SM_BLUE_FLASH   =  13.00000;
float CE_RED_FLASH   =  14.00000;
float CE_SM_EXPLOSION   =  15.00000;
float CE_LG_EXPLOSION   =  16.00000;
float CE_FLOOR_EXPLOSION   =  17.00000;
float CE_RIDER_DEATH   =  18.00000;
float CE_BLUE_EXPLOSION   =  19.00000;
float CE_GREEN_SMOKE   =  20.00000;
float CE_GREY_SMOKE   =  21.00000;
float CE_RED_SMOKE   =  22.00000;
float CE_SLOW_WHITE_SMOKE   =  23.00000;
float CE_REDSPARK   =  24.00000;
float CE_GREENSPARK   =  25.00000;
float CE_TELESMK1   =  26.00000;
float CE_TELESMK2   =  27.00000;
float CE_ICE_HIT   =  28.00000;
float CE_MEDUSA_HIT   =  29.00000;
float CE_MEZZO_REFLECT   =  30.00000;
float CE_FLOOR_EXPLOSION2   =  31.00000;
float CE_XBOW_EXPLOSION   =  32.00000;
float CE_NEW_EXPLOSION   =  33.00000;
float CE_MAGIC_MISSILE_EXPLOSION   =  34.00000;
float CE_GHOST   =  35.00000;
float CE_BONE_EXPLOSION   =  36.00000;
float CE_REDCLOUD   =  37.00000;
float CE_TELEPORTERPUFFS   =  38.00000;
float CE_TELEPORTERBODY   =  39.00000;
float TE_SPIKE   =  0.00000;
float TE_SUPERSPIKE   =  1.00000;
float TE_GUNSHOT   =  2.00000;
float TE_EXPLOSION   =  3.00000;
float TE_TAREXPLOSION   =  4.00000;
float TE_LIGHTNING1   =  5.00000;
float TE_LIGHTNING2   =  6.00000;
float TE_WIZSPIKE   =  7.00000;
float TE_KNIGHTSPIKE   =  8.00000;
float TE_LIGHTNING3   =  9.00000;
float TE_LAVASPLASH   =  10.00000;
float TE_TELEPORT   =  11.00000;
float TE_STREAM_CHAIN   =  25.00000;
float TE_STREAM_SUNSTAFF1   =  26.00000;
float TE_STREAM_SUNSTAFF2   =  27.00000;
float TE_STREAM_LIGHTNING   =  28.00000;
float TE_STREAM_COLORBEAM   =  29.00000;
float TE_STREAM_ICECHUNKS   =  30.00000;
float TE_STREAM_GAZE   =  31.00000;
float TE_STREAM_FAMINE   =  32.00000;
float TE_LIGHT_PULSE   =  33.00000;
float STREAM_ATTACHED   =  16.00000;
float STREAM_TRANSLUCENT   =  32.00000;
float CHAN_AUTO   =  0.00000;
float CHAN_WEAPON   =  1.00000;
float CHAN_VOICE   =  2.00000;
float CHAN_ITEM   =  3.00000;
float CHAN_BODY   =  4.00000;
float ATTN_NONE   =  0.00000;
float ATTN_NORM   =  1.00000;
float ATTN_IDLE   =  2.00000;
float ATTN_STATIC   =  3.00000;
float UPDATE_GENERAL   =  0.00000;
float UPDATE_STATIC   =  1.00000;
float UPDATE_BINARY   =  2.00000;
float UPDATE_TEMP   =  3.00000;
float EF_BRIGHTFIELD   =  1.00000;
float EF_MUZZLEFLASH   =  2.00000;
float EF_BRIGHTLIGHT   =  4.00000;
float EF_TORCHLIGHT   =  6.00000;
float EF_DIMLIGHT   =  8.00000;
float EF_DARKLIGHT   =  16.00000;
float EF_DARKFIELD   =  32.00000;
float EF_LIGHT   =  64.00000;
float EF_NODRAW   =  128.00000;
float EF_TEX_STOPF = 256.00000;
float EF_TEX_STOPL = 528.00000;
float MSG_BROADCAST   =  0.00000;
float MSG_ONE   =  1.00000;
float MSG_ALL   =  2.00000;
float MSG_INIT   =  3.00000;
float STEP_HEIGHT   =  18.00000;
float AI_DECIDE   =  0.00000;
float AI_STAND   =  1.00000;
float AI_WALK   =  2.00000;
float AI_CHARGE   =  4.00000;
float AI_WANDER   =  8.00000;
float AI_MELEE_ATTACK   =  16.00000;
float AI_MISSILE_ATTACK   =  32.00000;
float AI_MISSILE_REATTACK   =  64.00000;
float AI_PAIN   =  128.00000;
float AI_PAIN_CLOSE   =  256.00000;
float AI_PAIN_FAR   =  512.00000;
float AI_DEAD   =  1024.00000;
float AI_TURNLOOK   =  2048.00000;
float AI_DEAD_GIB   =  4096.00000;
float AI_DEAD_TWITCH   =  8192.00000;
float AF_NORMAL   =  0.00000;
float AF_BEGINNING   =  1.00000;
float AF_END   =  2.00000;
float CHUNK_MAX   =  30.00000;
float MAX_LEVELS   =  10.00000;
float SFL_EPISODE_1   =  1.00000;
float SFL_EPISODE_2   =  2.00000;
float SFL_EPISODE_3   =  4.00000;
float SFL_EPISODE_4   =  8.00000;
float SFL_NEW_UNIT   =  16.00000;
float SFL_NEW_EPISODE   =  32.00000;
float SFL_CROSS_TRIGGER_1   =  256.00000;
float SFL_CROSS_TRIGGER_2   =  512.00000;
float SFL_CROSS_TRIGGER_3   =  1024.00000;
float SFL_CROSS_TRIGGER_4   =  2048.00000;
float SFL_CROSS_TRIGGER_5   =  4096.00000;
float SFL_CROSS_TRIGGER_6   =  8192.00000;
float SFL_CROSS_TRIGGER_7   =  16384.00000;
float SFL_CROSS_TRIGGER_8   =  32768.00000;
float SFL_CROSS_TRIGGERS   =  65280.00000;
float attck_cnt   =  0.00000;
float WF_NORMAL_ADVANCE   =  0.00000;
float WF_CYCLE_STARTED   =  1.00000;
float WF_CYCLE_WRAPPED   =  2.00000;
float WF_LAST_FRAME   =  3.00000;
float WORLDTYPE_CASTLE   =  0.00000;
float WORLDTYPE_EGYPT   =  1.00000;
float WORLDTYPE_MESO   =  2.00000;
float WORLDTYPE_ROMAN   =  3.00000;
float IMP   =  1.00000;
float ARCHER   =  2.00000;
float WIZARD   =  4.00000;
float SCORPION   =  8.00000;
float SPIDER   =  16.00000;
float ONDEATH   =  32.00000;
float QUIET   =  64.00000;
float TRIGGERONLY   =  128.00000;
float JUMP   =  4.00000;
float PLAY_DEAD   =  8.00000;
float NO_DROP   =  32.00000;
float FLOATING   =  1.00000;
float BARREL_DOWNHILL   =  1.00000;
float BARREL_NO_DROP   =  2.00000;
float ON_SIDE   =  4.00000;
float BARREL_SINK   =  8.00000;
float BARREL_UNBREAKABLE   =  16.00000;
float BARREL_NORMAL   =  32.00000;
float BARREL_EXPLODING   =  64.00000;
float BARREL_INDESTRUCTIBLE   =  128.00000;
float GRADUAL   =  32.00000;
float TOGGLE_REVERSE   =  64.00000;
float KEEP_START   =  128.00000;
float NO_RESPAWN   =  0.00000;
float RESPAWN   =  1.00000;
float RING_REGENERATION_MAX   =  150.00000;
float RING_FLIGHT_MAX   =  60.00000;
float RING_WATER_MAX   =  60.00000;
float RING_TURNING_MAX   =  60.00000;
float SVC_SETVIEWPORT   =  5.00000;
float SVC_SETVIEWANGLES   =  10.00000;
float ACT_STAND   =  0.00000;
float ACT_RUN   =  1.00000;
float ACT_SWIM_FLY   =  2.00000;
float ACT_ATTACK   =  3.00000;
float ACT_PAIN   =  4.00000;
float ACT_JUMP   =  5.00000;
float ACT_CROUCH_STAND   =  6.00000;
float ACT_CROUCH_MOVE   =  7.00000;
float ACT_DEAD   =  8.00000;
float ACT_DECAP   =  9.00000;
float MAX_BLOOD_COUNT = 64.00000;
float MISSIONPACK           = 0;
float ONWALL   =  32.00000;

void (vector a)makevectors = #1;

void (entity a, vector b)setorigin = #2;

void (entity a, string b)setmodel = #3;

void (entity a, vector b, vector c)setsize = #4;

void (float a, float b)lightstylestatic = #5;

void ()debugbreak = #6;

void ()random = #7;

void (entity a, float b, string c, float d, float e)sound = #8;

vector (vector a)normalize = #9;

void (string a)error = #10;

void (string a)objerror = #11;

float (vector a)vlen = #12;

float (vector a)vectoyaw = #13;

entity ()spawn = #14;

void (entity a)remove = #15;

void (vector a, vector b, float c, entity d)traceline = #16;

entity ()checkclient = #17;

entity (entity a, .string b, string c)find = #18;

void (string a)precache_sound = #19;

void (string a)precache_model = #20;

void (entity a, string b)stuffcmd = #21;

entity (vector a, float b)findradius = #22;

void (string a)bprint = #23;

void (entity a, string b)sprint = #24;

void (string a)dprint = #25;

string (float a)ftos = #26;

string (vector a)vtos = #27;

void ()coredump = #28;

void ()traceon = #29;

void ()traceoff = #30;

void ()eprint = #31;

float (float a, float b, float c)walkmove = #32;

void (vector a, vector b, vector c, vector d, float e, entity f)tracearea = #33;

float ()droptofloor = #34;

void (float a, string b)lightstyle = #35;

float (float a)rint = #36;

float (float a)floor = #37;

float (float a)ceil = #38;

void ()checkbottom = #40;

float (vector a)pointcontents = #41;

void (vector a, vector b, vector c, float d, float e, float f)particle2 = #42;

float (float a)fabs = #43;
vector (entity prm1, float prm2) aim2 = #44;

vector (entity a, vector b, float c)aim = #44;

float (string a)cvar = #45;

void (string a)localcmd = #46;

entity (entity a)nextent = #47;

void (vector a, vector b, float c, float d)particle = #48;

void ()ChangeYaw = #49;

float (vector a)vhlen = #50;

vector (vector a)vectoangles = #51;

void (float a, float b)WriteByte = #52;

void (float a, float b)WriteChar = #53;

void (float a, float b)WriteShort = #54;

void (float a, float b)WriteLong = #55;

void (float a, float b)WriteFloat = #56;

void (float a, float b)WriteCoord = #56;

void (float a, float b)WriteAngle = #57;

void ()WriteString = #58;

void (float a, entity b)WriteEntity = #59;

void (string a, float b)dprintf = #60;

float (float a)cos = #61;

float (float a)sin = #62;

float (float a, float b)AdvanceFrame = #63;

void (string a, vector b)dprintv = #64;

float (float a, float b)RewindFrame = #65;

void (entity a, float b)setclass = #66;

void (float a)movetogoal = #67;

void (string a)precache_file = #68;

void (entity a)makestatic = #69;

void (string a, string b)changelevel = #70;

float (float a)lightstylevalue = #71;

void (string a, string b)cvar_set = #72;

// void (entity a, string b)centerprint = #73;

void (...)centerprint = #73;

void (vector a, string b, float c, float d)ambientsound = #74;

void (string a)precache_model2 = #75;

void (string a)precache_sound2 = #76;

void (string a)precache_file2 = #77;

void (entity a)setspawnparms = #78;

void (float a, float b)plaque_draw = #79;

void (vector a, vector b, vector c, vector d, float e, float f)rain_go = #80;

void (vector a, float b, float c, float d)particleexplosion = #81;

float (float a, float b, float c, float d)movestep = #82;

float (float a, float b)advanceweaponframe = #83;

void ()sqrt = #84;

void ()particle3 = #85;

void (vector a, float b, float c, float d, float e)particle4 = #86;

void (entity a, string b)setpuzzlemodel = #87;

void (...)starteffect = #88;

void ()endeffect = #89;

void (string a)precache_puzzle_model = #90;

vector (vector a, vector b)concatv = #91;

string (float a)getstring = #92;

entity ()spawn_temp = #93;

vector (vector a)v_factor = #94;

vector (vector a, vector b)v_factorrange = #95;

void (string a)precache_sound3 = #96;

void (string a)precache_model3 = #97;

void (string a)precache_file3 = #98;

void (float text_id, float mode)updateInfoPlaque = #100;
void (entity e, float chan)stopSound = #106;
void (string a, float b)set_extra_flags = #107;
void (string a, float b, float c, float d, float e)set_fx_color = #108;
float (string a)strhash = #109;
