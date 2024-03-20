#include "server.h"
#include "native_object.h"
#include "lua_api/l_internal.h"

//Sean Ferguson

//6-14
void nativeObjectRef::n_remove(ServerActiveObject *sao) {
    sao->clearChildAttachments();
    sao->clearParentAttachment();

    verbosestream << "ObjectRef::n_remove(): id=" << sao->getId() << std::endl;
    sao->markForRemoval();
}

v3f nativeObjectRef::n_get_pos(ServerActiveObject *sao)
{
	if (sao != nullptr) {
		return sao->getBasePosition();
	}
	v3f temp;
	return temp;
}

void nativeObjectRef::n_set_pos(ServerActiveObject *sao, const v3f &pos) {
    sao->setPos(pos);
}

void nativeObjectRef::n_move_to(ServerActiveObject *sao, const v3f &pos, bool continuous) {
    sao->moveTo(pos, continuous);
}

//6-17
float nativeObjectRef::n_punch(ServerActiveObject *sao, ServerActiveObject *puncher, float time_from_last_punch, const ToolCapabilities &toolcap, const v3f &dir) {
    dir.normalize();
    u16 src_original_hp = sao->getHP();
    u16 dst_origin_hp = puncher->getHP();

    u16 wear = sao->punch(dir, &toolcap, puncher, time_from_last_punch);

    // If the punched is a player, and its HP changed
    if (src_original_hp != sao->getHP() && sao->getType() == ACTIVEOBJECT_TYPE_PLAYER) {
        getServer(L)->SendPlayerHPOrDie((PlayerSAO *)sao, PlayerHPChangeReason(PlayerHPChangeReason::PLAYER_PUNCH, puncher));
    }

    // If the puncher is a player, and its HP changed
    if (dst_origin_hp != puncher->getHP() && puncher->getType() == ACTIVEOBJECT_TYPE_PLAYER) {
        getServer(L)->SendPlayerHPOrDie((PlayerSAO *)puncher, PlayerHPChangeReason(PlayerHPChangeReason::PLAYER_PUNCH, sao));
    }

    return wear;
}

//Might not be changable
void nativeObjectRef::n_right_click(ServerActiveObject *sao, ServerActiveObject *sao2) {
    sao->rightClick(sao2);
}

void nativeObjectRef::n_set_hp(ServerActiveObject *sao, int hp, const PlayerHPChangeReason& reason) {
    sao->setHP(hp, reason);
    if (sao->getType() == ACTIVEOBJECT_TYPE_PLAYER)
        getServer(L)->SendPlayerHPOrDie((PlayerSAO *)sao, reason);
    if (reason.hasLuaReference())
        luaL_unref(L, LUA_REGISTRYINDEX, reason.lua_reference);
}

int nativeObjectRef::n_get_hp(ServerActiveObject *sao) {
    if (sao == nullptr) {
        // Default hp is 1
        return 1;
    }

    return sao->getHP();
}

InvRef nativeObjectRef::n_get_inventory(ServerActiveObject *sao)
{
	InventoryLocation loc = sao->getInventoryLocation();
	if (getServerInventoryMgr(sao->getEnv())->getInventory(loc) != nullptr)
		return InvRef::create(sao->getEnv(), loc);
	else
		return InvRef();
}

//6-22
std::string nativeObjectRef::n_get_wield_list(ServerActiveObject *sao) {
    if (sao == nullptr)
        return "";

    return sao->getWieldList();
}

int nativeObjectRef::n_get_wield_index(ServerActiveObject *sao)
{
    if (sao == nullptr)
        return -1;

    int wieldIndex = sao->getWieldIndex() + 1;
    return wieldIndex;
}

ItemStack nativeObjectRef::n_get_wielded_item(ServerActiveObject *sao) {
    ItemStack selected_item;
    sao->getWieldedItem(&selected_item, nullptr);
    return selected_item;
}

bool nativeObjectRef::n_set_wielded_item(ServerActiveObject *sao, const ItemStack &item)
{
    return sao->setWieldedItem(item);
}

//6-23
std::pair<bool, ItemGroupList> nativeObjectRef::n_set_armor_groups(ServerActiveObject *sao, const ItemGroupList &groups)
{
    if (sao == nullptr)
        return std::make_pair(false, ItemGroupList());

    if (sao->getType() == ACTIVEOBJECT_TYPE_PLAYER) {
        if (!g_settings->getBool("enable_damage") && !itemgroup_get(groups, "immortal")) {
            groups["immortal"] = 1;
        }
    }

    sao->setArmorGroups(groups);
    return std::make_pair(true, groups);
}

std::map<std::string, int> nativeObjectRef::n_get_armor_groups(ServerActiveObject *sao)
{
	// Assuming ServerActiveObject has a function getArmorGroups() that returns the armor groups.
	// Replace 'getArmorGroups()' with the actual function name if different.
	return sao->getArmorGroups();
}

//7-1
void nativeObjectRef:n_set_animation(ServerActiveObject *sao, v2f frame_range, float frame_speed, float frame_blend, bool frame_loop)
{
    sao->setAnimation(frame_range, frame_speed, frame_blend, frame_loop);
}

void nativeObjectRef::n_get_animation(ServerActiveObject *sao, v2f *frames, float *frame_speed, float *frame_blend, bool *frame_loop)
{
	sao->getAnimation(frames, frame_speed, frame_blend, frame_loop);
}

void nativeObjectRef::n_set_local_animation(RemotePlayer *player, v2s32 frames[4], float frame_speed)
{
	getServer(L)->setLocalPlayerAnimations(player, frames, frame_speed);
}

std::pair<std::array<v2s32, 4>, float> nativeObjectRef::n_get_local_animation(RemotePlayer *player)
{
    std::array<v2s32, 4> frames;
    float frame_speed;
    player->getLocalAnimations(frames.data(), &frame_speed);
    return std::make_pair(frames, frame_speed);
}

//Might not be changable
void nativeObjectRef::n_set_eye_offset(RemotePlayer *player, const v3f &offset_first, const v3f &offset_third)
{
    getServer(player)->setPlayerEyeOffset(player, offset_first, offset_third);
}

//7-4
std::pair<v3f, v3f> nativeObjectRef::n_get_eye_offset(RemotePlayer *player)
{
	return std::make_pair(player->eye_offset_first, player->eye_offset_third);
}

bool nativeObjectRef::n_send_mapblock(ObjectRef *ref, v3s16 pos)
{
	RemotePlayer *player = getplayer(ref);
	if (player == nullptr)
		return false;

	session_t peer_id = player->getPeerId();
	return getServer(ref)->SendBlock(peer_id, pos);
}

void nativeObjectRef::n_set_animation_frame_speed(ServerActiveObject *sao, float frame_speed)
{
    sao->setAnimationSpeed(frame_speed);
}

void nativeObjectRef::n_set_bone_position(ServerActiveObject *sao, const std::string &bone, const v3f &position, const v3f &rotation)
{
    sao->setBonePosition(bone, position, rotation);
}

void nativeObjectRef::n_get_bone_position(ServerActiveObject *sao, const std::string &bone, v3f *position, v3f *rotation)
{
	sao->getBonePosition(bone, position, rotation);
}

//7-8
//double check this one later
std::tuple<bool, std::string, v3f, v3f, bool> nativeObjectRef::n_set_attach(ServerActiveObject *sao, ServerActiveObject *parent, const std::string &bone, const v3f &position, const v3f &rotation, bool force_visible)
{
	if (sao == nullptr || parent == nullptr)
		return std::make_tuple(false, "", v3f(0, 0, 0), v3f(0, 0, 0), false);
	if (sao == parent)
		throw LuaError("ObjectRef::set_attach: attaching object to itself is not allowed.");

	int parent_id;
	std::string current_bone;
	v3f current_position;
	v3f current_rotation;
	bool current_force_visible;

	sao->getAttachment(&parent_id, &current_bone, &current_position, &current_rotation, &current_force_visible);
	if (parent_id) {
		ServerActiveObject *old_parent = sao->getEnv()->getActiveObject(parent_id);
		old_parent->removeAttachmentChild(sao->getId());
	}

	sao->setAttachment(parent->getId(), bone, position, rotation, force_visible);
	parent->addAttachmentChild(sao->getId());

	return std::make_tuple(true, current_bone, current_position, current_rotation, current_force_visible);
}

//7-9
int nativeObjectRef::n_get_attach(ServerActiveObject *sao, int *parent_id, std::string *bone, v3f *position, v3f *rotation, bool *force_visible)
{
    sao->getAttachment(parent_id, bone, position, rotation, force_visible);
    return (*parent_id != 0) ? 1 : 0;
}

std::unordered_set<int> nativeObjectRef::n_get_children(ServerActiveObject* sao)
{
    if (sao == nullptr)
        return std::unordered_set<int>();

    return sao->getAttachmentChildIds();
}

void nativeModApiObject::n_set_detach(ServerActiveObject *sao)
{
    sao->clearParentAttachment();
}

//7-14
void nativeObjectRef::n_set_properties(ServerActiveObject *sao, const ObjectProperties &prop)
{
    // No map lock required for this function, as it should be called from other C++ functions
    if (sao == nullptr)
        return;

    ObjectProperties *objProp = sao->accessObjectProperties();
    if (objProp == nullptr)
        return;

    *objProp = prop;
    sao->notifyObjectPropertiesModified();
}

std::pair<bool, ObjectProperties*> nativeObjectRef::n_get_properties(ServerActiveObject *sao)
{
	if (sao == nullptr)
		return std::make_pair(false, nullptr);

	ObjectProperties *prop = sao->accessObjectProperties();
	if (prop == nullptr)
		return std::make_pair(false, nullptr);

	return std::make_pair(true, prop);
}

//7-20
bool nativeObjectRef::n_is_player(ObjectRef *ref)
{
    return (getplayer(ref) != nullptr);
}

bool nativeObjectRef::n_set_nametag_attributes(ServerActiveObject *sao, video::SColor nametag_color, video::SColor nametag_bgcolor, const std::string &nametag)
{
	if (!sao)
		return false;

	ObjectProperties *prop = sao->accessObjectProperties();
	if (!prop)
		return false;

	prop->nametag_color = nametag_color;
	prop->nametag_bgcolor = (nametag_bgcolor.getAlpha() == 0) ? nullopt : nametag_bgcolor;
	prop->nametag = nametag;

	return true;
}

//7-21
std::tuple<bool, Color, bool, Color, std::string> nativeObjectRef::n_get_nametag_attributes(ServerActiveObject *sao)
{
	NO_MAP_LOCK_REQUIRED;
	if (sao == nullptr)
		return std::make_tuple(false, Color(255, 255, 255, 255), false, Color(0, 0, 0, 0), "");

	ObjectProperties *prop = sao->accessObjectProperties();
	if (!prop)
		return std::make_tuple(false, Color(255, 255, 255, 255), false, Color(0, 0, 0, 0), "");

	Color color = prop->nametag_color;

	bool hasBgColor = (prop->nametag_bgcolor != boost::none);
	Color bgcolor = hasBgColor ? prop->nametag_bgcolor.get() : Color(0, 0, 0, 0);

	std::string text = prop->nametag;
	return std::make_tuple(true, color, hasBgColor, bgcolor, text);
}

void nativeObjectRef::n_set_velocity(ObjectRef *ref, v3f vel)
{
    LuaEntitySAO *sao = getluaobject(ref);
    if (sao == nullptr)
        return;

    sao->setVelocity(vel);
}

//7-29
// l_native_add_vel:
void nativeObjectRef::n_add_velocity_lua_entity(LuaEntitySAO *entitysao, v3f vel)
{
    entitysao->addVelocity(vel);
}

void nativeObjectRef::n_add_velocity_player_sao(PlayerSAO *playersao, v3f vel)
{
    playersao->setMaxSpeedOverride(vel);
    getServer(playersao->getLua())->SendPlayerSpeed(playersao->getPeerID(), vel);
}
///////////////////////


//Double check this one
v3f nativeObjectRef::n_get_velocity(ServerActiveObject *sao)
{
    if (sao == nullptr)
        return v3f(0, 0, 0);

    if (sao->getType() == ACTIVEOBJECT_TYPE_LUAENTITY)
    {
        LuaEntitySAO *entitysao = dynamic_cast<LuaEntitySAO*>(sao);
        return entitysao->getVelocity();
    }
    else if (sao->getType() == ACTIVEOBJECT_TYPE_PLAYER)
    {
        RemotePlayer *player = dynamic_cast<PlayerSAO*>(sao)->getPlayer();
        return player->getSpeed() / BS;
    }

    return v3f(0, 0, 0);
}

void nativeObjectRef::n_set_acceleration(ObjectRef *ref, v3f acceleration)
{
    LuaEntitySAO *entitysao = getluaobject(ref);
    if (entitysao == nullptr)
        return;

    entitysao->setAcceleration(acceleration);
}

//8-3
v3f nativeObjectRef::n_get_acceleration(LuaEntitySAO *entitysao)
{
    if (entitysao == nullptr)
        return v3f(0, 0, 0);

    return entitysao->getAcceleration();
}

void nativeObjectRef::n_set_rotation(ObjectRef *ref, v3f rotationDegrees)
{
    LuaEntitySAO *entitysao = getluaobject(ref);
    if (entitysao == nullptr)
        return;

    v3f rotationRadians = rotationDegrees * core::DEGTORAD;

    entitysao->setRotation(rotationRadians);
}

void nativeObjectRef::n_set_breath(ServerActiveObject *sao, u16 breath)
{
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
		playersao->setBreath(breath);
	}
}

u16 nativeObjectRef::n_get_breath(ServerActiveObject *sao)
{
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
		return playersao->getBreath();
	}
	return 0; // Or a suitable default value if playersao is nullptr
}




void nativeObjectRef::n_set_attribute(ServerActiveObject *sao, const std::string &attribute,
		const std::string &value)
{
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
		if (value.empty()) {
			playersao->getMeta().removeString(attribute);
		} else {
			playersao->getMeta().setString(attribute, value);
		}
	}
}

std::string nativeObjectRef::n_get_attribute(ServerActiveObject *sao, const std::string &attribute)
{
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
		std::string value;
		if (playersao->getMeta().getStringToRef(attribute, value)) {
			return value;
		}
	}
	return "";
}

PlayerMetaRef *nativeObjectRef::n_get_meta(ServerActiveObject *sao)
{
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
		return &playersao->getMeta();
	}
	return nullptr;
}


void nativeObjectRef::n_set_fov(ServerActiveObject *sao, float degrees, bool is_multiplier,
		float transition_time)
{
	RemotePlayer *player = dynamic_cast<RemotePlayer *>(sao);
	if (player) {
		player->setFov({degrees, is_multiplier, transition_time});
		// Assuming you have access to the server instance
		// getServer()->SendPlayerFov(player->getPeerId());  // Adjust as needed
	}
}

PlayerFovSpec nativeObjectRef::n_get_fov(ServerActiveObject *sao)
{
	RemotePlayer *player = dynamic_cast<RemotePlayer *>(sao);
	if (player) {
		return player->getFov();
	}
	return {}; // Return a default or error value as appropriate for your system
}

namespace nativeObjectRef
{

std::string nativeObjectRef::n_get_player_name(ServerActiveObject *sao)
{
	RemotePlayer *player = dynamic_cast<RemotePlayer *>(sao);
	if (player) {
		return player->getName();
	}
	return "";
}

}


// Declaration
v3f nativeObjectRef::n_get_look_dir(ServerActiveObject *sao);

// Definition
v3f nativeObjectRef::n_get_look_dir(ServerActiveObject *sao) {
    PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
    if (!playersao) {
	// Return a zero vector or a suitable default if playersao is nullptr
	return v3f(0, 0, 0);
    }

    float pitch = playersao->getRadLookPitchDep();
    float yaw = playersao->getRadYawDep();
    return v3f(std::cos(pitch) * std::cos(yaw), std::sin(pitch), std::cos(pitch) *
std::sin(yaw));
}



float nativeObjectRef::n_get_look_pitch(ServerActiveObject *sao) {
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getRadLookPitchDep();
	}
	return 0.0; // Or a suitable default value.
}

float nativeObjectRef::n_get_look_yaw(ServerActiveObject *sao) {
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getRadYawDep();
	}
	return 0.0; // Or a suitable default value.
}

float nativeObjectRef::n_get_look_vertical(ServerActiveObject *sao) {
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getRadLookPitch();
	}
	return 0.0; // Or a suitable default value.
}

float nativeObjectRef::n_get_look_horizontal(ServerActiveObject *sao) {
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getRadRotation().Y;
	}
	return 0.0; // Or a suitable default value.
}


void nativeObjectRef::n_set_look_vertical(ServerActiveObject *sao, float radians) {
    PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
    if (playersao) {
	playersao->setLookPitchAndSend(radians * core::RADTODEG);
    }
}

void nativeObjectRef::n_set_look_horizontal(ServerActiveObject *sao, float radians) {
    PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
    if (playersao) {
	playersao->setPlayerYawAndSend(radians * core::RADTODEG);
    }
}

// DEPRECATED
void nativeObjectRef::n_set_look_pitch(ServerActiveObject *sao, float radians) {
    PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
    if (playersao) {
	playersao->setLookPitchAndSend(radians * core::RADTODEG);
    }
}

// DEPRECATED
void nativeObjectRef::_set_look_yaw(ServerActiveObject *sao, float radians) {
    PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
    if (playersao) {
	playersao->setPlayerYawAndSend(radians * core::RADTODEG);
    }
}




    // Conversion: Lua table -> SkyboxParams
SkyboxParams nativeObjectRef::table_to_skybox_params(lua_State *L, int index) {
	SkyboxParams params;
	// Assume table is at the top of the stack.

	// Extract bgcolor from the table
	lua_getfield(L, index, "bgcolor");
	params.bgcolor = read_ARGB8(L, -1); // Convert Lua color to C++ color.
	lua_pop(L, 1);

	// Similar conversions for other members of SkyboxParams...
	// ...

	return params;
}

    // Conversion: SkyColor -> Lua table
void nativeObjectRef::push_sky_color_to_lua(lua_State *L, const SkyColor& color) {
	lua_newtable(L);
	// Assuming SkyColor has members like day_sky, day_horizon, etc.
	push_ARGB8(L, color.day_sky);
	lua_setfield(L, -2, "day_sky");
	// ... similar pushes for other members ...
}

void nativeObjectRef::n_set_sky(ServerActiveObject* sao, lua_State *L, int index) {
	RemotePlayer* player = dynamic_cast<RemotePlayer*>(sao);
	if (!player) {
	    lua_pushstring(L, "Invalid player object.");
	    lua_error(L);
	    return;
	}

	SkyboxParams params = table_to_skybox_params(L, index);
	player->setSky(params);
}

void nativeObjectRef::n_get_sky(ServerActiveObject* sao, lua_State *L) {
	RemotePlayer* player = dynamic_cast<RemotePlayer*>(sao);
	if (!player) {
	    lua_pushstring(L, "Invalid player object.");
	    lua_error(L);
	    return;
	}

	SkyboxParams params = player->getSkyParams();
	// Convert params to Lua table and push to Lua stack.
	// This function assumes you have the conversion functions ready.
	skybox_params_to_table(L, params);
}

void nativeObjectRef::n_get_sky_color(ServerActiveObject* sao, lua_State *L) {
	RemotePlayer* player = dynamic_cast<RemotePlayer*>(sao);
	if (!player) {
	    lua_pushstring(L, "Invalid player object.");
	    lua_error(L);
	    return;
	}

	SkyColor color = player->getSkyParams().sky_color;
	// Convert color to Lua table and push to Lua stack.
	push_sky_color_to_lua(L, color);
}


// Native version of set_sun
void nativeObjectRef::n_set_sun(RemotePlayer *player, const SunParams &params) {
    if (player) {
	player->getServer()->setSun(player, params);
    }
}

// Native version of get_sun
SunParams nativeObjectRef::n_get_sun(RemotePlayer *player) {
    if (player) {
	return player->getSunParams();
    }
    // Return default or null SunParams if player is nullptr. Adjust as necessary.
    return SunParams();
}

// Native version of set_moon
void nativeObjectRef::n_set_moon(RemotePlayer *player, const MoonParams &params) {
    if (player) {
	player->getServer()->setMoon(player, params);
    }
}

// Native version of get_moon
MoonParams nativeObjectRef::n_get_moon(RemotePlayer *player) {
    if (player) {
	return player->getMoonParams();
    }
    // Return default or null MoonParams if player is nullptr. Adjust as necessary.
    return MoonParams();
}


    // For set_stars, considering it has a struct StarParams for its parameter
void nativeObjectRef::n_set_stars(ServerActiveObject *sao, const StarParams &params){
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    playersao->setStarParams(params);
	}
}

    // For get_stars, assuming it returns StarParams
StarParams nativeObjectRef::n_get_stars(ServerActiveObject *sao){
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getStarParams();
	}
	return StarParams(); // Returning default StarParams
}

    // For set_clouds, considering it has a struct CloudParams for its parameter
void nativeObjectRef::n_set_clouds(ServerActiveObject *sao, const CloudParams &params){
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    playersao->setCloudParams(params);
	}
}

    // For get_clouds, assuming it returns CloudParams
CloudParams nativeObjectRef::n_get_clouds(ServerActiveObject *sao){
	PlayerSAO *playersao = dynamic_cast<PlayerSAO *>(sao);
	if (playersao) {
	    return playersao->getCloudParams();
	}
	return CloudParams(); // Returning default CloudParams
}

