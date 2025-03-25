// Starknet import
use starknet::{ContractAddress, contract_address_const};

// Zero address
pub fn ZERO_ADDRESS() -> ContractAddress {
    contract_address_const::<0x0>()
}

// Seconds per day
pub const SECONDS_PER_DAY: u64 = 86400;

// Tournament status
pub const TOURNAMENT_STATUS_UPCOMING: u8 = 1;
pub const TOURNAMENT_STATUS_ACTIVE: u8 = 2;
pub const TOURNAMENT_STATUS_FINISHED: u8 = 3;
pub const TOURNAMENT_STATUS_CANCELLED: u8 = 4;

// Reward per place %
pub const FIRST_PLACE_REWARD: u256 = 50;
pub const SECOND_PLACE_REWARD: u256 = 30;
pub const THIRD_PLACE_REWARD: u256 = 20;
