// Starknet import
use starknet::{ContractAddress, contract_address_const};

// Zero address
pub fn ZERO_ADDRESS() -> ContractAddress {
    contract_address_const::<0x0>()
}

// Seconds per day
pub const SECONDS_PER_DAY: u64 = 86400;

// Seconds per hour
pub const SECONDS_PER_HOUR: u64 = 3600;

// Tournament status
pub const TOURNAMENT_STATUS_UPCOMING: u8 = 1;
pub const TOURNAMENT_STATUS_ACTIVE: u8 = 2;
pub const TOURNAMENT_STATUS_FINISHED: u8 = 3;
pub const TOURNAMENT_STATUS_CANCELLED: u8 = 4;

// Gameweek status
pub const GAMEWEEK_STATUS_UPCOMING: u8 = 1;
pub const GAMEWEEK_STATUS_ACTIVE: u8 = 2;
pub const GAMEWEEK_STATUS_COMPLETED: u8 = 3;

// Starkfantasy System Configuration Constants
// This file centralizes all fixed values and configuration parameters 
// used throughout the fantasy football platform.

// =====================================
// Tournament Constants
// =====================================

/// The default maximum number of teams a user can create
pub const DEFAULT_MAX_TEAMS_PER_USER: u8 = 1;

/// The default maximum number of players allowed in a team
pub const DEFAULT_MAX_PLAYERS_PER_TEAM: u8 = 11; // 11 starters MVP

/// The minimum number of players required to form a valid team
pub const MIN_PLAYERS_PER_TEAM: u8 = 11;

/// The default team budget limit in tokens
pub const DEFAULT_TEAM_BUDGET: u64 = 100_000_000;

// =====================================
// Player Position Limits
// =====================================

/// Maximum number of goalkeepers allowed in a team
pub const MAX_GOALKEEPERS: u8 = 1;

/// Maximum number of defenders allowed in a team
pub const MAX_DEFENDERS: u8 = 5;

/// Maximum number of midfielders allowed in a team
pub const MAX_MIDFIELDERS: u8 = 5;

/// Maximum number of forwards allowed in a team
pub const MAX_FORWARDS: u8 = 3;

// =====================================
// Scoring Constants
// =====================================

/// Points awarded for a goal scored by a goalkeeper
pub const POINTS_PER_GOAL_GK: u16 = 8;

/// Points awarded for a goal scored by a defender
pub const POINTS_PER_GOAL_DEF: u16 = 6;

/// Points awarded for a goal scored by a midfielder
pub const POINTS_PER_GOAL_MID: u16 = 5;

/// Points awarded for a goal scored by a forward
pub const POINTS_PER_GOAL_FWD: u16 = 4;

/// Points awarded for an assist
pub const POINTS_PER_ASSIST: u16 = 3;

/// Points awarded to a goalkeeper for a clean sheet
pub const POINTS_PER_CLEAN_SHEET_GK: u16 = 4;

/// Points awarded to a defender for a clean sheet
pub const POINTS_PER_CLEAN_SHEET_DEF: u16 = 4;

/// Points awarded to a midfielder for a clean sheet
pub const POINTS_PER_CLEAN_SHEET_MID: u16 = 1;

/// Points deducted for a yellow card
pub const POINTS_PER_YELLOW_CARD: u16 = 1; // negative

/// Points deducted for a red card
pub const POINTS_PER_RED_CARD: u16 = 3; // negative

/// Points awarded to a goalkeeper for each save
pub const POINTS_PER_SAVE: u16 = 1;

/// Points awarded for saving a penalty
pub const POINTS_PER_PENALTY_SAVE: u16 = 5;

/// Multiplier applied to the team captain's points
pub const POINTS_CAPTAIN_MULTIPLIER: u16 = 2;

// =====================================
// Time Constants (in seconds)
// =====================================

/// One hour in seconds
pub const ONE_HOUR: u64 = 3600;

/// One day in seconds
pub const ONE_DAY: u64 = 86400;

/// One week in seconds
pub const ONE_WEEK: u64 = 604800;

// =====================================
// League Constants
// =====================================

/// Minimum number of teams required to start a league
pub const MIN_TEAMS_PER_LEAGUE: u16 = 2;

/// Maximum number of teams allowed in a standard league
pub const MAX_TEAMS_PER_LEAGUE: u16 = 20;

/// Maximum number of teams allowed in a tournament
pub const MAX_TEAMS_PER_TOURNAMENT: u16 = 64;

// =====================================
// Transfer Window Constants
// =====================================

/// Maximum number of transfers allowed per gameweek
pub const MAX_TRANSFERS_PER_GAMEWEEK: u8 = 2;

/// Points penalty for each additional transfer
pub const POINTS_PER_EXTRA_TRANSFER: u16 = 4; // negative 
