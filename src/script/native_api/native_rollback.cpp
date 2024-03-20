#include "server.h"
#include "native_rollback.h"
#include "rollback_interface.h"
#include "lua_api/l_internal.h"

//Sean Ferguson


/*
// rollback_revert_actions_by(actor, seconds) -> bool, log messages
std::pair<bool, std::map<int, std::string>> nativeModApiRollback::n_rollback_revert_actions_by(Server *server, const std::string &actor, int seconds)
{
	IRollbackManager *rollback = server->getRollbackManager();
	std::map<int, std::string> log_map;

	// If rollback is disabled, tell it's not a success.
	if (rollback == NULL) {
		return {false, log_map};
	}

	std::list<RollbackAction> actions = rollback->getRevertActions(actor, seconds);
	std::list<std::string> log;
	bool success = m_server->rollbackRevertActions(actions, &log);

	// Copy the log into a map.
	unsigned long i = 0;
	for (auto iter = log.begin(); iter != log.end(); ++i, ++iter) {
		log_map[i] = *iter;
	}
	// Push boolean result
	return {success, log_map};
}
*/

std::pair<bool, std::list<RollbackAction>>
nativeModApiRollback::n_rollback_get_node_actions(
		Server *server, v3s16 pos, int range, time_t seconds, int limit)
{
	IRollbackManager *rollback = server->getRollbackManager();
	if (rollback == NULL) {
		return std::make_pair(false, std::list<RollbackAction>());
	}

	std::list<RollbackAction> actions =
			rollback->getNodeActors(pos, range, seconds, limit);

	return std::make_pair(true, actions);
}



std::pair<bool, std::list<std::string>>
nativeModApiRollback::n_rollback_revert_actions_by(
		Server *server, const std::string &actor, int seconds)
{
	IRollbackManager *rollback = server->getRollbackManager();
	if (rollback == nullptr) {
		return std::make_pair(false, std::list<std::string>());
	}
	std::list<RollbackAction> actions = rollback->getRevertActions(actor, seconds);
	std::list<std::string> log;
	// std::list<std::string> g;
	bool success = server->rollbackRevertActions(actions, &log);
	return std::make_pair(success, log);
}






