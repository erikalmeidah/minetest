#pragma once

#include "lua_api/l_base.h"
#include "server.h"
#include "object_properties.h"

//Sean Ferguson


class nativeObjectRef
{
public:
	static void nativeObjectRef::n_remove(ServerActiveObject *sao);

    static v3f nativeObjectRef::n_get_pos(ServerActiveObject *sao)

    static void nativeObjectRef::n_set_pos(ServerActiveObject *sao, const v3f &pos);

    static void nativeObjectRef::n_move_to(ServerActiveObject *sao, const v3f &pos, bool continuous);

    static float nativeObjectRef::n_punch(ServerActiveObject *sao, ServerActiveObject *puncher, float time_from_last_punch, const ToolCapabilities &toolcap, const v3f &dir);

    static void nativeObjectRef::n_right_click(ServerActiveObject *sao, ServerActiveObject *sao2);

    static void nativeObjectRef::n_set_hp(ServerActiveObject *sao, int hp, const PlayerHPChangeReason& reason);

    static int nativeObjectRef::n_get_hp(ServerActiveObject *sao);

    static InvRef nativeObjectRef::n_get_inventory(ServerActiveObject *sao);

    static std::string nativeObjectRef::n_get_wield_list(ServerActiveObject *sao);

    static int nativeObjectRef::n_get_wield_index(ServerActiveObject *sao);

    static ItemStack nativeObjectRef::n_get_wielded_item(ServerActiveObject *sao);

    static bool nativeObjectRef::n_set_wielded_item(ServerActiveObject *sao, const ItemStack &item);

    static std::pair<bool, ItemGroupList> nativeObjectRef::n_set_armor_groups(ServerActiveObject *sao, const ItemGroupList &groups);

    static std::map<std::string, int> nativeObjectRef::n_get_armor_groups(ServerActiveObject *sao);

    static void nativeObjectRef:n_set_animation(ServerActiveObject *sao, v2f frame_range, float frame_speed, float frame_blend, bool frame_loop);

    static void nativeObjectRef::n_get_animation(ServerActiveObject *sao, v2f *frames, float *frame_speed, float *frame_blend, bool *frame_loop);

    static void nativeObjectRef::n_set_local_animation(RemotePlayer *player, v2s32 frames[4], float frame_speed);

    static std::pair<std::array<v2s32, 4>, float> nativeObjectRef::n_get_local_animation(RemotePlayer *player);

    static void nativeObjectRef::n_set_eye_offset(RemotePlayer *player, const v3f &offset_first, const v3f &offset_third);

    static std::pair<v3f, v3f> nativeObjectRef::n_get_eye_offset(RemotePlayer *player);

    static bool nativeObjectRef::n_send_mapblock(ObjectRef *ref, v3s16 pos);

    static void nativeObjectRef::n_set_animation_frame_speed(ServerActiveObject *sao, float frame_speed);

    static void nativeObjectRef::n_set_bone_position(ServerActiveObject *sao, const std::string &bone, const v3f &position, const v3f &rotation);

    static void nativeObjectRef::n_get_bone_position(ServerActiveObject *sao, const std::string &bone, v3f *position, v3f *rotation);

    static std::tuple<bool, std::string, v3f, v3f, bool> nativeObjectRef::n_set_attach(ServerActiveObject *sao, ServerActiveObject *parent, const std::string &bone, const v3f &position, const v3f &rotation, bool force_visible);

    static int nativeObjectRef::n_get_attach(ServerActiveObject *sao, int *parent_id, std::string *bone, v3f *position, v3f *rotation, bool *force_visible);

    static std::unordered_set<int> nativeObjectRef::n_get_children(ServerActiveObject* sao);

    static void nativeModApiObject::n_set_detach(ServerActiveObject *sao);

    static void nativeObjectRef::n_set_properties(ServerActiveObject *sao, const ObjectProperties &prop);

    static std::pair<bool, ObjectProperties*> nativeObjectRef::n_get_properties(ServerActiveObject *sao);

    static bool nativeObjectRef::n_is_player(ObjectRef *ref);

    static bool nativeObjectRef::n_set_nametag_attributes(ServerActiveObject *sao, video::SColor nametag_color, video::SColor nametag_bgcolor, const std::string &nametag);

    static std::tuple<bool, Color, bool, Color, std::string> nativeObjectRef::n_get_nametag_attributes(ServerActiveObject *sao);

    static void nativeObjectRef::n_set_velocity(ObjectRef *ref, v3f vel);

    static void nativeObjectRef::n_add_velocity_lua_entity(LuaEntitySAO *entitysao, v3f vel);

    static void nativeObjectRef::n_add_velocity_player_sao(PlayerSAO *playersao, v3f vel);

    static v3f nativeObjectRef::n_get_velocity(ServerActiveObject *sao);

    static void nativeObjectRef::n_set_acceleration(ObjectRef *ref, v3f acceleration);

    static v3f nativeObjectRef::n_get_acceleration(LuaEntitySAO *entitysao);

    static void nativeObjectRef::n_set_rotation(ObjectRef *ref, v3f rotationDegrees);

    static void n_set_breath(ServerActiveObject *sao, u16 breath);

    static u16 n_get_breath(ServerActiveObject *sao);

    static void n_set_attribute(ServerActiveObject *sao, const std::string &attribute, const std::string &value);

    static std::string n_get_attribute(ServerActiveObject *sao, const std::string &attribute);

    static PlayerMetaRef *n_get_meta(ServerActiveObject *sao);

    static void n_set_fov(ServerActiveObject *sao, float degrees, bool is_multiplier, float transition_time);

    static PlayerFovSpec n_get_fov(ServerActiveObject *sao);

    static std::string n_get_player_name(ServerActiveObject *sao);

    static v3f n_get_look_dir(ServerActiveObject *sao);

    static float n_get_look_pitch(ServerActiveObject *sao);

    static float n_get_look_yaw(ServerActiveObject *sao);

    static float n_get_look_vertical(ServerActiveObject *sao);

    static float n_get_look_horizontal(ServerActiveObject *sao);

    static void n_set_look_vertical(ServerActiveObject *sao, float radians);

    static void n_set_look_horizontal(ServerActiveObject *sao, float radians);

    static void n_set_look_pitch(ServerActiveObject *sao, float radians); // DEPRECATED

    static void _set_look_yaw(ServerActiveObject *sao, float radians); // DEPRECATED

    static SkyboxParams table_to_skybox_params(lua_State *L, int index);

    static void push_sky_color_to_lua(lua_State *L, const SkyColor& color);

    static void n_set_sky(ServerActiveObject* sao, lua_State *L, int index);

    static void n_get_sky(ServerActiveObject* sao, lua_State *L);

    static void n_get_sky_color(ServerActiveObject* sao, lua_State *L);

    static void n_set_sun(RemotePlayer *player, const SunParams &params);

    static SunParams n_get_sun(RemotePlayer *player);

    static void n_set_moon(RemotePlayer *player, const MoonParams &params);

    static MoonParams n_get_moon(RemotePlayer *player);

    static void n_set_stars(ServerActiveObject *sao, const StarParams &params);

    static StarParams n_get_stars(ServerActiveObject *sao);

    static void n_set_clouds(ServerActiveObject *sao, const CloudParams &params);

    static CloudParams n_get_clouds(ServerActiveObject *sao);
};
