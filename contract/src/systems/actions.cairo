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
            // Generate a random number between 1 and 100
            let random_number = PseudoRandom::generate_random_u8(1, 100, salt);
            
            // Return the random number
            random_number
        }
    }
}
