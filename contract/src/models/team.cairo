use starknet::{ContractAddress};

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Team {
    #[key]
    id: u64,
    #[key]
    user_address: ContractAddress,
    tournament_id: u64,
    name: felt252,
    created_at: u64,
    updated_at: u64,
    total_points: u32,
    budget_remaining: u32,
    formation: felt252,
}

#[cfg(test)]
mod tests {
    use super::Team;
    use starknet::{ContractAddress, contract_address_const};

    #[test]
    #[available_gas(300000)]
    fn test_team_initialization() {
        let user_address: ContractAddress = contract_address_const::<0x123>();

        let team = Team {
            id: 1,
            user_address,
            tournament_id: 101,
            name: 'Team A',
            created_at: 1700000000,
            updated_at: 1700000000,
            total_points: 0,
            budget_remaining: 1000,
            formation: '4-4-2',
        };

        assert_eq!(team.id, 1, "Team ID should be 1");
        assert_eq!(team.user_address, user_address, "User address should match");
        assert_eq!(team.tournament_id, 101, "Tournament ID should be 101");
        assert_eq!(team.total_points, 0, "Initial total points should be 0");
        assert_eq!(team.budget_remaining, 1000, "Initial budget should be 1000");
    }

    #[test]
    #[available_gas(300000)]
    fn test_teams_with_different_users() {
        let user1_address: ContractAddress = contract_address_const::<0x123>();
        let user2_address: ContractAddress = contract_address_const::<0x456>();

        let team1 = Team {
            id: 1,
            user_address: user1_address,
            tournament_id: 101,
            name: 'Team X',
            created_at: 1700000001,
            updated_at: 1700000001,
            total_points: 10,
            budget_remaining: 800,
            formation: '4-3-3',
        };

        let team2 = Team {
            id: 2,
            user_address: user2_address,
            tournament_id: 101,
            name: 'Team Y',
            created_at: 1700000002,
            updated_at: 1700000002,
            total_points: 15,
            budget_remaining: 750,
            formation: '3-5-2',
        };

        assert!(team1.user_address != team2.user_address, "Teams should belong to different users");
        assert!(team1.id != team2.id, "Teams should have different IDs");
    }

    #[test]
    #[available_gas(300000)]
    fn test_team_with_zero_budget() {
        let user_address: ContractAddress = contract_address_const::<0x123>();

        let team = Team {
            id: 3,
            user_address,
            tournament_id: 102,
            name: 'Team Zero',
            created_at: 1700000003,
            updated_at: 1700000003,
            total_points: 5,
            budget_remaining: 0,
            formation: '5-3-2',
        };

        assert_eq!(team.budget_remaining, 0, "Budget should be 0");
    }
}
