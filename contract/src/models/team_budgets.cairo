use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct TeamBudget {
    #[key]
    pub team_id: u64,
    pub total_budget: u64,
    pub spent_amount: u64,
    pub remaining_budget: u64,
}

#[dojo::interface]
trait ITeamBudgetActions {
    fn initialize_team_budget(ref world: IWorldDispatcher, team_id: u64, total_budget: u64);
    fn update_budget(ref world: IWorldDispatcher, team_id: u64, cost: u64);
    fn can_afford(world: @IWorldDispatcher, team_id: u64, player_cost: u64) -> bool;
    fn get_remaining_budget(world: @IWorldDispatcher, team_id: u64) -> u64;
    fn refund_budget(ref world: IWorldDispatcher, team_id: u64, refund_amount: u64);
}

#[dojo::contract]
mod team_budget_actions {
    use super::{ITeamBudgetActions, TeamBudget};
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    #[abi(embed_v0)]
    impl TeamBudgetActionsImpl of ITeamBudgetActions<ContractState> {
        /// Initialize a new team budget with the specified total budget
        fn initialize_team_budget(ref world: IWorldDispatcher, team_id: u64, total_budget: u64) {
            let team_budget = TeamBudget {
                team_id,
                total_budget,
                spent_amount: 0,
                remaining_budget: total_budget,
            };
            
            set!(world, (team_budget));
        }

        /// Update budget when a player is purchased (increase spent amount)
        fn update_budget(ref world: IWorldDispatcher, team_id: u64, cost: u64) {
            let mut team_budget = get!(world, team_id, TeamBudget);
            
            // Ensure team can afford the cost
            assert(team_budget.remaining_budget >= cost, 'Insufficient budget');
            
            // Update budget values
            team_budget.spent_amount += cost;
            team_budget.remaining_budget -= cost;
            
            set!(world, (team_budget));
        }

        /// Check if team can afford a specific player cost
        fn can_afford(world: @IWorldDispatcher, team_id: u64, player_cost: u64) -> bool {
            let team_budget = get!(world, team_id, TeamBudget);
            team_budget.remaining_budget >= player_cost
        }

        /// Get the remaining budget for a team
        fn get_remaining_budget(world: @IWorldDispatcher, team_id: u64) -> u64 {
            let team_budget = get!(world, team_id, TeamBudget);
            team_budget.remaining_budget
        }

        /// Refund budget when a player is sold (decrease spent amount)
        fn refund_budget(ref world: IWorldDispatcher, team_id: u64, refund_amount: u64) {
            let mut team_budget = get!(world, team_id, TeamBudget);
            
            // Ensure refund doesn't exceed spent amount
            assert(team_budget.spent_amount >= refund_amount, 'Refund exceeds spent amount');
            
            // Update budget values
            team_budget.spent_amount -= refund_amount;
            team_budget.remaining_budget += refund_amount;
            
            // Ensure remaining budget doesn't exceed total budget
            assert(team_budget.remaining_budget <= team_budget.total_budget, 'Invalid budget state');
            
            set!(world, (team_budget));
        }
    }
}

#[cfg(test)]
mod tests {
    use super::{TeamBudget, ITeamBudgetActions, team_budget_actions};
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    const TEAM_ID: u64 = 42;
    const TOTAL_BUDGET: u64 = 100_000_000; // 100 million fantasy currency
    const PLAYER_COST: u64 = 95;

    fn setup_world() -> IWorldDispatcher {
        let mut models = array![team_budget::TEST_CLASS_HASH];
        spawn_test_world(models)
    }

    fn deploy_budget_contract(world: IWorldDispatcher) -> ContractAddress {
        deploy_contract(team_budget_actions::TEST_CLASS_HASH, array![].span())
    }

    #[test]
    #[available_gas(30000000)]
    fn test_initialize_team_budget() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);

        // Verify initialization
        let team_budget = get!(world, TEAM_ID, TeamBudget);
        assert(team_budget.team_id == TEAM_ID, 'Wrong team_id');
        assert(team_budget.total_budget == TOTAL_BUDGET, 'Wrong total_budget');
        assert(team_budget.spent_amount == 0, 'Wrong initial spent_amount');
        assert(team_budget.remaining_budget == TOTAL_BUDGET, 'Wrong initial remaining_budget');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_can_afford_success() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);

        // Test can afford - should return true
        let can_afford = actions.can_afford(@world, TEAM_ID, PLAYER_COST);
        assert(can_afford == true, 'Should be able to afford');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_can_afford_failure() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget with small amount
        actions.initialize_team_budget(world, TEAM_ID, 50);

        // Test can afford - should return false
        let can_afford = actions.can_afford(@world, TEAM_ID, PLAYER_COST);
        assert(can_afford == false, 'Should not be able to afford');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_update_budget() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);

        // Update budget after buying player
        actions.update_budget(world, TEAM_ID, PLAYER_COST);

        // Verify budget update
        let team_budget = get!(world, TEAM_ID, TeamBudget);
        assert(team_budget.spent_amount == PLAYER_COST, 'Wrong spent_amount after update');
        assert(team_budget.remaining_budget == TOTAL_BUDGET - PLAYER_COST, 'Wrong remaining_budget after update');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_get_remaining_budget() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);

        // Update budget
        actions.update_budget(world, TEAM_ID, PLAYER_COST);

        // Get remaining budget
        let remaining = actions.get_remaining_budget(@world, TEAM_ID);
        assert(remaining == TOTAL_BUDGET - PLAYER_COST, 'Wrong remaining budget');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_refund_budget() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize and spend some budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);
        actions.update_budget(world, TEAM_ID, PLAYER_COST);

        // Refund some amount
        let refund_amount = 50;
        actions.refund_budget(world, TEAM_ID, refund_amount);

        // Verify refund
        let team_budget = get!(world, TEAM_ID, TeamBudget);
        assert(team_budget.spent_amount == PLAYER_COST - refund_amount, 'Wrong spent after refund');
        assert(team_budget.remaining_budget == TOTAL_BUDGET - PLAYER_COST + refund_amount, 'Wrong remaining after refund');
    }

    #[test]
    #[available_gas(30000000)]
    #[should_panic(expected: ('Insufficient budget',))]
    fn test_update_budget_insufficient_funds() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget with small amount
        actions.initialize_team_budget(world, TEAM_ID, 50);

        // Try to spend more than available - should panic
        actions.update_budget(world, TEAM_ID, PLAYER_COST);
    }

    #[test]
    #[available_gas(30000000)]
    #[should_panic(expected: ('Refund exceeds spent amount',))]
    fn test_refund_exceeds_spent() {
        let world = setup_world();
        let contract_address = deploy_budget_contract(world);
        let actions = ITeamBudgetActionsDispatcher { contract_address };

        // Initialize team budget
        actions.initialize_team_budget(world, TEAM_ID, TOTAL_BUDGET);

        // Try to refund without spending - should panic
        actions.refund_budget(world, TEAM_ID, 100);
    }
}