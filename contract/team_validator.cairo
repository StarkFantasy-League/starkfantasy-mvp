from starkware.cairo.common.math_utils import assert_le

# Constants for position limits
const MAX_PLAYERS: felt = 11
const MAX_SAME_TEAM: felt = 3
const POSITION_COUNTS: Dict[str, felt] = {
    "GK": 1,
    "DEF": 5,
    "MID": 5,
    "FWD": 3
}

# Validate position counts
func validate_position_counts(team: Dict[str, felt]) -> felt:
    for position, count in POSITION_COUNTS.items():
        if team.get(position, 0) != count:
            return 0  # Invalid position count
    return 1  # Valid position counts

# Validate team diversity (max 3 players from the same team)
func validate_team_diversity(team_counts: Dict[str, felt]) -> felt:
    for _, count in team_counts.items():
        if count > MAX_SAME_TEAM:
            return 0  # Exceeds same-team limit
    return 1  # Valid team diversity

# Validate complete team (exactly 11 players)
func validate_complete_team(total_players: felt) -> felt:
    if total_players != MAX_PLAYERS:
        return 0  # Invalid total players
    return 1  # Valid total players

# Comprehensive validation
func is_valid_team(team: Dict[str, felt], team_counts: Dict[str, felt], total_players: felt) -> felt:
    if validate_position_counts(team) == 0:
        return 0  # Invalid position counts
    if validate_team_diversity(team_counts) == 0:
        return 0  # Invalid team diversity
    if validate_complete_team(total_players) == 0:
        return 0  # Invalid total players
    return 1  # Team is valid
