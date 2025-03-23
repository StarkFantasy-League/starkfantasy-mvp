use starknet::ContractAddress;

#[derive(Copy, Clone, Debug, PartialEq, Eq, Serde)]
#[dojo::model]
pub struct User {
    #[key]
    pub id: ContractAddress,  // Primary key in Dojo model

    pub username: Felt252,    // Corrected felt252 -> Felt252
    pub tournaments_won: u16,
    pub created_at: u64,
    pub last_connection: u64,
}
