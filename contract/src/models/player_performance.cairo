use starknet::ContractAddress;

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct PlayerPerformance {
    #[key]
    pub player: ContractAddress,
    pub tournament_id: u64,
    pub match_external_id: felt252,
    pub match_date: u64,
    pub goals: u8,
    pub assists: u8,
    pub yellow_cards: u8,
    pub red_cards: u8,
    pub clean_sheet: bool,
    pub saves: u8,
    pub points: u16,
}
