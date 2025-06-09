use starknet::ContractAddress;
use starkfantasy::helpers::pseudo_random::PseudoRandom;

#[starknet::interface]
trait IActions<TContractState> {
    fn simulate_random_draw(self: @TContractState, salt: felt252) -> u8;
}

#[dojo::contract]
mod actions {
    use starknet::ContractAddress;
    use starkfantasy::helpers::pseudo_random::PseudoRandom;

    #[abi(embed_v0)]
    impl ActionsImpl of super::IActions<ContractState> {
        /// Simulates a random draw using the PseudoRandom helper
        /// 
        /// # Arguments
        /// 
        /// * `salt` - An optional salt to add more entropy
        /// 
        /// # Returns
        /// 
        /// A random number between 1 and 100
        fn simulate_random_draw(self: @ContractState, salt: felt252) -> u8 {
            // Convert felt252 salt to u256 first, then to u16
            let salt_u256: u256 = salt.into();
            let salt_u16: u16 = (salt_u256 % 65536).try_into().unwrap();
            
            // Generate a random number between 1 and 100
            // Using unique_id=1, salt=salt_u16, min=1, max=100
            let random_number = PseudoRandom::generate_random_u8(1_u16, salt_u16, 1_u8, 100_u8);
            
            random_number
        }
    }
}
