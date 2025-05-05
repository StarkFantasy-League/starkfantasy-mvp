use starkfantasy::models::gameweek::Gameweek;

/// Provides utility functions for working with gameweeks
mod GameweekHelper {
    use starknet::get_block_timestamp;
    use starkfantasy::models::gameweek::Gameweek;

    /// Get the current active gameweek from a list of gameweeks
    /// If no active gameweek is found, returns the next upcoming gameweek
    /// Returns None if no suitable gameweek is found
    fn get_current_gameweek<T, +Drop<T>, +Copy<T>>(gameweeks: Array<Gameweek>) -> Option<Gameweek> {
        let current_timestamp = get_block_timestamp();
        
        // Try to find an active gameweek first
        let mut closest_upcoming: Option<Gameweek> = Option::None;
        let mut min_time_to_start: u64 = 0xFFFFFFFFFFFFFFFF_u64; // Max u64 value
        
        let mut i: u32 = 0;
        let mut active_gameweek: Option<Gameweek> = Option::None;
        
        loop {
            if i >= gameweeks.len() {
                break;
            }
            
            let gameweek = *gameweeks.at(i);
            
            // Check if gameweek is active
            if current_timestamp >= gameweek.start_timestamp && current_timestamp < gameweek.end_timestamp {
                active_gameweek = Option::Some(gameweek);
                break;
            }
            
            // If not active, check if it's upcoming and closer than current closest
            if current_timestamp < gameweek.start_timestamp {
                let time_to_start = gameweek.start_timestamp - current_timestamp;
                
                if time_to_start < min_time_to_start {
                    min_time_to_start = time_to_start;
                    closest_upcoming = Option::Some(gameweek);
                }
            }
            
            i += 1;
        };
        
        // If an active gameweek was found, return it
        if active_gameweek.is_some() {
            return active_gameweek;
        }
        
        // Return the closest upcoming gameweek if no active gameweek was found
        closest_upcoming
    }
    
    /// Get all gameweeks for a specific season
    fn get_gameweeks_for_season<T, +Drop<T>, +Copy<T>>(
        all_gameweeks: Array<Gameweek>, season_id: u16
    ) -> Array<Gameweek> {
        let mut season_gameweeks: Array<Gameweek> = ArrayTrait::new();
        
        let mut i: u32 = 0;
        loop {
            if i >= all_gameweeks.len() {
                break;
            }
            
            let gameweek = *all_gameweeks.at(i);
            if gameweek.season_id == season_id {
                season_gameweeks.append(gameweek);
            }
            
            i += 1;
        };
        
        season_gameweeks
    }
} 