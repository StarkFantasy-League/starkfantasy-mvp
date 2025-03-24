#[derive(Model, Copy, Drop, Serde)]
struct TeamPlayer {
    #[key]
    team_id: u64,
    #[key]
    player_id: u64,
    is_starter: bool,
    is_captain: bool,
    position_in_team: u8
}

#[cfg(test)]
mod tests {
    use super::TeamPlayer;

    #[test]
    fn test_team_player_creation() {
        // Test creating a regular team player
        let regular_player = TeamPlayer {
            team_id: 1_u64,
            player_id: 100_u64,
            is_starter: false,
            is_captain: false,
            position_in_team: 5_u8
        };

        assert(regular_player.team_id == 1_u64, 'Wrong team_id');
        assert(regular_player.player_id == 100_u64, 'Wrong player_id');
        assert(!regular_player.is_starter, 'Should not be starter');
        assert(!regular_player.is_captain, 'Should not be captain');
        assert(regular_player.position_in_team == 5_u8, 'Wrong position');

        // Test creating a captain starter player
        let captain_player = TeamPlayer {
            team_id: 2_u64,
            player_id: 201_u64,
            is_starter: true,
            is_captain: true,
            position_in_team: 1_u8
        };

        assert(captain_player.team_id == 2_u64, 'Wrong team_id');
        assert(captain_player.player_id == 201_u64, 'Wrong player_id');
        assert(captain_player.is_starter, 'Should be starter');
        assert(captain_player.is_captain, 'Should be captain');
        assert(captain_player.position_in_team == 1_u8, 'Wrong position');
    }

    #[test]
    fn test_team_player_equality() {
        let player1 = TeamPlayer {
            team_id: 1_u64,
            player_id: 100_u64,
            is_starter: true,
            is_captain: false,
            position_in_team: 1_u8
        };

        let player2 = TeamPlayer {
            team_id: 1_u64,
            player_id: 100_u64,
            is_starter: true,
            is_captain: false,
            position_in_team: 1_u8
        };

        let player3 = TeamPlayer {
            team_id: 1_u64,
            player_id: 101_u64,
            is_starter: true,
            is_captain: false,
            position_in_team: 1_u8
        };

        assert(player1.team_id == player2.team_id, 'Team IDs should match');
        assert(player1.player_id == player2.player_id, 'Player IDs should match');
        assert(player1.team_id == player3.team_id, 'Team IDs should match');
        assert(player1.player_id != player3.player_id, 'Player IDs should differ');
    }
} 