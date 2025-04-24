use starknet::get_block_timestamp;
use starkfantasy::helpers::timestamp::Timestamp;
use starkfantasy::constants;

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct Tournament {
    #[key]
    pub id: u64,
    pub name: felt252,
    pub description: felt252,
    pub entry_fee: u256,
    pub start_timestamp: u64,
    pub end_timestamp: u64,
    pub status: u8,  // 1-upcoming, 2-active, 3-finished
    pub max_teams_per_user: u8,
    pub max_players_per_team: u8,
    pub budget_limit: u32,
    pub total_prize_pool: u256,
    pub total_participants: u32,
    pub min_participants: u32,
}

#[generate_trait]
pub impl TournamentImpl of TournamentTrait {
    fn create_tournament(
        id: u64,
        name: felt252,
        description: felt252,
        entry_fee: u256,
        start_timestamp: u64,
        end_timestamp: u64,
        max_teams_per_user: u8,
        max_players_per_team: u8,
        budget_limit: u32,
        min_participants: u32
    ) -> Tournament {
        
        assert(start_timestamp < end_timestamp, 'Invalid tournament timespan');
        assert(start_timestamp > get_block_timestamp(), 'Start time in the past');
        assert(max_teams_per_user > 0, 'Max teams must be positive');
        assert(max_players_per_team > 0, 'Max players must be positive');
        
        
        Tournament {
            id,
            name,
            description,
            entry_fee,
            start_timestamp,
            end_timestamp,
            status: constants::TOURNAMENT_STATUS_UPCOMING,
            max_teams_per_user,
            max_players_per_team,
            budget_limit,
            total_prize_pool: 0_u256,
            total_participants: 0_u32,
            min_participants
        }
    }
    
    // Update tournament information (only the owner can do this)
    fn update_tournament(
        ref self: Tournament, 
        name: felt252,
        description: felt252,
        start_timestamp: u64,
        end_timestamp: u64,
        max_teams_per_user: u8,
        max_players_per_team: u8,
        budget_limit: u32,
        min_participants: u32
    ) {
        assert(self.status == constants::TOURNAMENT_STATUS_UPCOMING, 'Cannot update active/finished');
        assert(start_timestamp < end_timestamp, 'Invalid tournament timespan');
        assert(start_timestamp > get_block_timestamp(), 'Start time in the past');
        
        self.name = name;
        self.description = description;
        self.start_timestamp = start_timestamp;
        self.end_timestamp = end_timestamp;
        self.max_teams_per_user = max_teams_per_user;
        self.max_players_per_team = max_players_per_team;
        self.budget_limit = budget_limit;
        self.min_participants = min_participants;
    }
    
    // === State management methods ===
    
    // Check if the tournament can start
    fn can_start(self: @Tournament) -> bool {
        let current_timestamp = get_block_timestamp();
        *self.status == constants::TOURNAMENT_STATUS_UPCOMING && 
        current_timestamp >= *self.start_timestamp && 
        *self.total_participants >= *self.min_participants
    }
    
    // Update tournament status based on current status
    fn update_status(ref self: Tournament) {
        let current_timestamp = get_block_timestamp();
        
        if self.status == constants::TOURNAMENT_STATUS_UPCOMING {
            if current_timestamp >= self.start_timestamp && self.total_participants >= self.min_participants {
                self.status = constants::TOURNAMENT_STATUS_ACTIVE;
            } else if current_timestamp >= self.start_timestamp && self.total_participants < self.min_participants {
                // If the start date has arrived but there are not enough participants
                self.status = constants::TOURNAMENT_STATUS_CANCELLED;
            }
        } else if self.status == constants::TOURNAMENT_STATUS_ACTIVE && current_timestamp >= self.end_timestamp {
            self.status = constants::TOURNAMENT_STATUS_FINISHED;
        }
    }
    
    // === Participation methods ===
    
    // Register participant (increases counter and prize pool)
    fn register_participant(ref self: Tournament) {
        assert(self.status == constants::TOURNAMENT_STATUS_UPCOMING, 'Registration closed');
        self.total_participants += 1;
        self.total_prize_pool += self.entry_fee;
    }
    
    // === Auxiliary and query methods ===
    
    // Check if a user can register for the tournament
    fn can_register(self: @Tournament) -> bool {
        *self.status == constants::TOURNAMENT_STATUS_UPCOMING && 
        get_block_timestamp() < *self.start_timestamp
    }
    
    // Get days remaining until start
    fn days_until_start(self: @Tournament) -> u32 {
        let current_timestamp = get_block_timestamp();
        if current_timestamp >= *self.start_timestamp {
            return 0;
        }
        Timestamp::unix_timestamp_to_day(*self.start_timestamp - current_timestamp)
    }
    
    // Get days left until the end of the tournament
    fn days_until_end(self: @Tournament) -> u32 {
        let current_timestamp = get_block_timestamp();
        if current_timestamp >= *self.end_timestamp {
            return 0;
        }
        Timestamp::unix_timestamp_to_day(*self.end_timestamp - current_timestamp)
    }
    
    // Check if the tournament is active
    fn is_active(self: @Tournament) -> bool {
        *self.status == constants::TOURNAMENT_STATUS_ACTIVE
    }
}

#[cfg(test)]
mod tests {
    use super::{Tournament, TournamentImpl};
    use starknet::get_block_timestamp;
    use starkfantasy::constants;
    use starkfantasy::helpers::timestamp::Timestamp;

    // Helper function to create a test tournament
    fn create_test_tournament() -> Tournament {
        let current_time = get_block_timestamp();
        
        Tournament {
            id: 1_u64,
            name: 'Test Tournament',
            description: 'Tournament for testing',
            entry_fee: 100_u256,
            start_timestamp: current_time + constants::SECONDS_PER_DAY, // One day in the future
            end_timestamp: current_time + (constants::SECONDS_PER_DAY * 7), // One week in the future
            status: constants::TOURNAMENT_STATUS_UPCOMING,
            max_teams_per_user: 3_u8,
            max_players_per_team: 11_u8,
            budget_limit: 1000_u32,
            total_prize_pool: 0_u256,
            total_participants: 0_u32,
            min_participants: 2_u32,
        }
    }

    #[test]
    #[available_gas(1000000)]
    fn test_tournament_creation() {
        let current_time = get_block_timestamp();
        
        let tournament = TournamentImpl::create_tournament(
            1_u64,
            'Test Tournament',
            'Tournament for testing',
            100_u256,
            current_time + constants::SECONDS_PER_DAY,
            current_time + (constants::SECONDS_PER_DAY * 7),
            3_u8,
            11_u8,
            1000_u32,
            2_u32
        );
        
        assert(tournament.name == 'Test Tournament', 'Name should match');
        assert(tournament.entry_fee == 100_u256, 'Entry fee should match');
        assert(tournament.status == constants::TOURNAMENT_STATUS_UPCOMING, 'Status should be upcoming');
        assert(tournament.total_participants == 0_u32, 'Participants should be 0');
        assert(tournament.total_prize_pool == 0_u256, 'Prize pool should be 0');
    }

    #[test]
    #[available_gas(1000000)]
    #[should_panic(expected: ('Start time in the past',))]
    fn test_tournament_creation_past_start_time() {
        let current_time = get_block_timestamp();
        
        // Calculate a safe past time
        let past_time: u64 = if current_time > constants::SECONDS_PER_DAY {
            current_time - constants::SECONDS_PER_DAY
        } else {
            0_u64
        };
        
        // Attempt to create a tournament with a past start date
        TournamentImpl::create_tournament(
            1_u64,
            'Past Tournament',
            'This should fail',
            100_u256,
            past_time,
            current_time + constants::SECONDS_PER_DAY,
            3_u8,
            11_u8,
            1000_u32,
            2_u32
        );
    }

    #[test]
    #[available_gas(1000000)]
    fn test_update_tournament() {
        let mut tournament = create_test_tournament();
        let current_time = get_block_timestamp();
        
        TournamentImpl::update_tournament(
            ref tournament,
            'Updated Tournament',
            'Updated description',
            current_time + (constants::SECONDS_PER_DAY * 2),
            current_time + (constants::SECONDS_PER_DAY * 10),
            5_u8,
            15_u8,
            2000_u32,
            5_u32
        );
        
        assert(tournament.name == 'Updated Tournament', 'Name should be updated');
        assert(tournament.description == 'Updated description', 'Description should be updated');
        assert(tournament.max_teams_per_user == 5_u8, 'Max teams should be updated');
        assert(tournament.budget_limit == 2000_u32, 'Budget limit should be updated');
    }

    #[test]
    #[available_gas(1000000)]
    #[should_panic(expected: ('Cannot update active/finished',))]
    fn test_update_active_tournament() {
        let mut tournament = create_test_tournament();
        tournament.status = constants::TOURNAMENT_STATUS_ACTIVE;
        let current_time = get_block_timestamp();
        
        // Attempt to update an active tournament
        TournamentImpl::update_tournament(
            ref tournament,
            'Updated Tournament',
            'This should fail',
            current_time + constants::SECONDS_PER_DAY,
            current_time + (constants::SECONDS_PER_DAY * 7),
            3_u8,
            11_u8,
            1000_u32,
            2_u32
        );
    }

    #[test]
    #[available_gas(1000000)]
    fn test_participant_registration() {
        let mut tournament = create_test_tournament();
        
        // Register a participant
        TournamentImpl::register_participant(ref tournament);
        
        assert(tournament.total_participants == 1_u32, 'Should have 1 participant');
        assert(tournament.total_prize_pool == 100_u256, 'Prize pool should be 100');
        
        // Register another participant
        TournamentImpl::register_participant(ref tournament);
        
        assert(tournament.total_participants == 2_u32, 'Should have 2 participants');
        assert(tournament.total_prize_pool == 200_u256, 'Prize pool should be 200');
    }
    
    #[test]
    #[available_gas(1000000)]
    #[should_panic(expected: ('Registration closed',))]
    fn test_register_to_active_tournament() {
        let mut tournament = create_test_tournament();
        tournament.status = constants::TOURNAMENT_STATUS_ACTIVE;
        
        // Attempt to register for an active tournament
        TournamentImpl::register_participant(ref tournament);
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_can_start() {
        let mut tournament = create_test_tournament();
        
        // A tournament without participants cannot start
        assert(!TournamentImpl::can_start(@tournament), 'Should not be able to start');
        
        // Register participants
        TournamentImpl::register_participant(ref tournament);
        TournamentImpl::register_participant(ref tournament);
        
        // A tournament with a future start date cannot start
        assert(!TournamentImpl::can_start(@tournament), 'Still should not start');
        
        // Simulate that the start date has arrived
        tournament.start_timestamp = get_block_timestamp(); // Now
        
        // Now it should be able to start
        assert(TournamentImpl::can_start(@tournament), 'Should be able to start');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_update_status() {
        let mut tournament = create_test_tournament();
        
        // Register enough participants
        TournamentImpl::register_participant(ref tournament);
        TournamentImpl::register_participant(ref tournament);
        
        // Simulate that the start date has arrived
        tournament.start_timestamp = get_block_timestamp(); // Now
        
        // Update status
        TournamentImpl::update_status(ref tournament);
        
        // It should have changed to active
        assert(tournament.status == constants::TOURNAMENT_STATUS_ACTIVE, 'Should be active');
        
        // Simulate that it has ended
        tournament.end_timestamp = get_block_timestamp(); // Now
        
        // Update status again
        TournamentImpl::update_status(ref tournament);
        
        // It should have changed to finished
        assert(tournament.status == constants::TOURNAMENT_STATUS_FINISHED, 'Should be finished');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_days_calculation() {
        let mut tournament = create_test_tournament();
        let current_time = get_block_timestamp();
        
        // Set exact start and end dates for testing
        tournament.start_timestamp = current_time + (constants::SECONDS_PER_DAY * 3); // 3 days in the future
        tournament.end_timestamp = current_time + (constants::SECONDS_PER_DAY * 10); // 10 days in the future
        
        // Verify days until start
        assert(TournamentImpl::days_until_start(@tournament) == 3_u32, 'Should be 3 days until start');
        
        // Verify days until end
        assert(TournamentImpl::days_until_end(@tournament) == 10_u32, 'Should be 10 days until end');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_is_active() {
        let mut tournament = create_test_tournament();
        
        // By default it is upcoming, not active
        assert(!TournamentImpl::is_active(@tournament), 'Should not be active');
        
        // Change to active
        tournament.status = constants::TOURNAMENT_STATUS_ACTIVE;
        
        // Now it should be active
        assert(TournamentImpl::is_active(@tournament), 'Should be active');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_can_register() {
        let mut tournament = create_test_tournament();
        
        // An upcoming tournament should allow registrations
        assert(TournamentImpl::can_register(@tournament), 'Should allow registration');
        
        // Change to active
        tournament.status = constants::TOURNAMENT_STATUS_ACTIVE;
        
        // It should not allow registrations
        assert(!TournamentImpl::can_register(@tournament), 'No registration when active');
        
        // Change back to upcoming but with a past start date
        tournament.status = constants::TOURNAMENT_STATUS_UPCOMING;
        
        // Calculate a safe past time
        let current_time: u64 = get_block_timestamp();
        let past_time: u64 = if current_time > 1_u64 {
            current_time - 1_u64
        } else {
            0_u64
        };

        tournament.start_timestamp = past_time;
        
        // It should not allow registrations
        assert(!TournamentImpl::can_register(@tournament), 'No registration after start');
    }
}
