#pragma once

#include "lua_api/l_base.h"
#include "server.h"
#include "rollback_interface.h"

//Sean Ferguson


class nativeModApiRollback
{
public:
	static std::pair<bool, std::list<RollbackAction>> n_rollback_get_node_actions(
			Server *server, v3s16 pos, int range, time_t seconds, int limit);

	static std::pair<bool, std::list<std::string>>
	nativeModApiRollback::n_rollback_revert_actions_by(
			Server *server, const std::string &actor, int seconds);
};