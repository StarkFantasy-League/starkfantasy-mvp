use starknet::get_block_timestamp;
use starkfantasy::constants;
use starkfantasy::helpers::timestamp::Timestamp;

// Gameweek model to track Premier League gameweeks
#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Gameweek {
    #[key]
    pub gameweek_id: u16,
    pub start_timestamp: u64,
    pub end_timestamp: u64,
    pub status: u8, // 1-upcoming, 2-active, 3-completed
    pub season_id: u16,
}

#[generate_trait]
pub impl GameweekImpl of GameweekTrait {
    // Create a new gameweek
    fn create_gameweek(
        gameweek_id: u16,
        start_timestamp: u64,
        end_timestamp: u64,
        season_id: u16
    ) -> Gameweek {
        assert(start_timestamp < end_timestamp, 'Invalid gameweek timespan');
        
        // Set initial status based on current timestamp
        let current_timestamp = get_block_timestamp();
        let status = if current_timestamp < start_timestamp {
            constants::GAMEWEEK_STATUS_UPCOMING
        } else if current_timestamp >= start_timestamp && current_timestamp < end_timestamp {
            constants::GAMEWEEK_STATUS_ACTIVE
        } else {
            constants::GAMEWEEK_STATUS_COMPLETED
        };
        
        Gameweek {
            gameweek_id,
            start_timestamp,
            end_timestamp,
            status,
            season_id,
        }
    }
    
    // Check if the gameweek is currently active
    fn is_active(self: @Gameweek) -> bool {
        let current_timestamp = get_block_timestamp();
        (*self.status == constants::GAMEWEEK_STATUS_ACTIVE) || 
        (current_timestamp >= *self.start_timestamp && current_timestamp < *self.end_timestamp)
    }
    
    // Check if the gameweek has been completed
    fn is_completed(self: @Gameweek) -> bool {
        let current_timestamp = get_block_timestamp();
        (*self.status == constants::GAMEWEEK_STATUS_COMPLETED) || 
        (current_timestamp >= *self.end_timestamp)
    }
    
    // Update the gameweek status based on current time
    fn update_status(ref self: Gameweek) {
        let current_timestamp = get_block_timestamp();
        
        if current_timestamp < self.start_timestamp {
            self.status = constants::GAMEWEEK_STATUS_UPCOMING;
        } else if current_timestamp >= self.start_timestamp && current_timestamp < self.end_timestamp {
            self.status = constants::GAMEWEEK_STATUS_ACTIVE;
        } else {
            self.status = constants::GAMEWEEK_STATUS_COMPLETED;
        }
    }
    
    // Get time remaining until gameweek starts (in seconds)
    fn time_until_start(self: @Gameweek) -> u64 {
        let current_timestamp = get_block_timestamp();
        if current_timestamp >= *self.start_timestamp {
            return 0;
        }
        let time_remaining = *self.start_timestamp - current_timestamp;
        time_remaining
    }
    
    // Get time remaining until gameweek ends (in seconds)
    fn time_until_end(self: @Gameweek) -> u64 {
        let current_timestamp = get_block_timestamp();
        if current_timestamp >= *self.end_timestamp {
            return 0;
        }
        let time_remaining = *self.end_timestamp - current_timestamp;
        time_remaining
    }
}

#[cfg(test)]
mod tests {
    use super::{Gameweek, GameweekImpl};
    use starknet::get_block_timestamp;
    use starkfantasy::constants;
    
    #[test]
    #[available_gas(1000000)]
    fn test_gameweek_creation() {
        let current_time = get_block_timestamp();
        
        let gameweek = GameweekImpl::create_gameweek(
            1_u16,
            current_time + constants::SECONDS_PER_DAY,
            current_time + (constants::SECONDS_PER_DAY * 3),
            1_u16
        );
        
        assert(gameweek.gameweek_id == 1_u16, 'Wrong gameweek ID');
        assert(gameweek.season_id == 1_u16, 'Wrong season ID');
        assert(gameweek.status == constants::GAMEWEEK_STATUS_UPCOMING, 'Wrong initial status');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_gameweek_status_checks() {
        let current_time = get_block_timestamp();
        
        // Create upcoming gameweek
        let upcoming_gameweek = Gameweek {
            gameweek_id: 1_u16,
            start_timestamp: current_time + constants::SECONDS_PER_DAY,
            end_timestamp: current_time + (constants::SECONDS_PER_DAY * 3),
            status: constants::GAMEWEEK_STATUS_UPCOMING,
            season_id: 1_u16,
        };
        
        // Create active gameweek
        let active_gameweek = Gameweek {
            gameweek_id: 2_u16,
            start_timestamp: current_time - constants::SECONDS_PER_DAY,
            end_timestamp: current_time + constants::SECONDS_PER_DAY,
            status: constants::GAMEWEEK_STATUS_ACTIVE,
            season_id: 1_u16,
        };
        
        // Create completed gameweek
        let completed_gameweek = Gameweek {
            gameweek_id: 3_u16,
            start_timestamp: current_time - (constants::SECONDS_PER_DAY * 3),
            end_timestamp: current_time - constants::SECONDS_PER_DAY,
            status: constants::GAMEWEEK_STATUS_COMPLETED,
            season_id: 1_u16,
        };
        
        // Test is_active function
        assert(!GameweekImpl::is_active(@upcoming_gameweek), 'Upcoming should not be active');
        assert(GameweekImpl::is_active(@active_gameweek), 'Active should be active');
        assert(!GameweekImpl::is_active(@completed_gameweek), 'Completed should not be active');
        
        // Test is_completed function
        assert(!GameweekImpl::is_completed(@upcoming_gameweek), 'Upcoming should not be completed');
        assert(!GameweekImpl::is_completed(@active_gameweek), 'Active should not be completed');
        assert(GameweekImpl::is_completed(@completed_gameweek), 'Completed should be completed');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_update_status() {
        let current_time = get_block_timestamp();
        
        // Test with a gameweek that's upcoming but should be active
        let mut gameweek = Gameweek {
            gameweek_id: 4_u16,
            start_timestamp: current_time - (constants::SECONDS_PER_HOUR), // 1 hour ago
            end_timestamp: current_time + (constants::SECONDS_PER_HOUR), // 1 hour in future
            status: constants::GAMEWEEK_STATUS_UPCOMING, // Deliberately wrong status
            season_id: 1_u16,
        };
        
        GameweekImpl::update_status(ref gameweek);
        assert(gameweek.status == constants::GAMEWEEK_STATUS_ACTIVE, 'Status should be updated to active');
        
        // Test with a gameweek that's active but should be completed
        let mut gameweek = Gameweek {
            gameweek_id: 5_u16,
            start_timestamp: current_time - (constants::SECONDS_PER_DAY * 2), // 2 days ago
            end_timestamp: current_time - constants::SECONDS_PER_HOUR, // 1 hour ago
            status: constants::GAMEWEEK_STATUS_ACTIVE, // Deliberately wrong status
            season_id: 1_u16,
        };
        
        GameweekImpl::update_status(ref gameweek);
        assert(gameweek.status == constants::GAMEWEEK_STATUS_COMPLETED, 'Status should be updated to completed');
    }
    
    #[test]
    #[available_gas(1000000)]
    fn test_time_until_start_and_end() {
        let current_time = get_block_timestamp();
        
        let upcoming_gameweek = Gameweek {
            gameweek_id: 6_u16,
            start_timestamp: current_time + constants::SECONDS_PER_DAY, // 1 day in future
            end_timestamp: current_time + (constants::SECONDS_PER_DAY * 2), // 2 days in future
            status: constants::GAMEWEEK_STATUS_UPCOMING,
            season_id: 1_u16,
        };
        
        let time_to_start = GameweekImpl::time_until_start(@upcoming_gameweek);
        assert(time_to_start > 0, 'Time until start should be positive');
        assert(time_to_start <= constants::SECONDS_PER_DAY, 'Time until start should be <= 1 day');
        
        let time_to_end = GameweekImpl::time_until_end(@upcoming_gameweek);
        assert(time_to_end > constants::SECONDS_PER_DAY, 'Time until end should be > 1 day');
        assert(time_to_end <= constants::SECONDS_PER_DAY * 2, 'Time until end should be <= 2 days');
    }
} 