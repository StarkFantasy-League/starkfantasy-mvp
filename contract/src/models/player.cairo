use starkfantasy::types::player_position::PlayerPosition;
use starkfantasy::types::player_status::PlayerStatus;


#[derive(Copy, Drop, Serde, Debug, PartialEq, Introspect)]
#[dojo::model]
struct Player{
    #[key] id: u64,
    external_id: felt252,
    name: felt252,
    position: PlayerPosition, 
    real_team: felt252,
    image_url: felt252,
    country: felt252,
    price: u32,
    status: PlayerStatus, 
    total_points: u32,
}

#[cfg(test)]
mod tests {
    use super::Player;
    use super::PlayerPosition;
    use super::PlayerStatus;

    fn generate_player() -> Player {
        Player {
            id: 1_u64,
            external_id: 123456_felt252,
            name: 'Lionel Messi',
            position: PlayerPosition::Forward,
            real_team: 'Paris Saint-Germain',
            image_url: 'https://example.com/messi.jpg',
            country: 'Argentina',
            price: 1000000_u32,
            status: PlayerStatus::Available,
            total_points: 200_u32,
        }
    }

    #[test]
    fn test_player_creation() {
        let player = Player {
            id: 1_u64,
            external_id: 123456_felt252,
            name: 'Lionel Messi',
            position: PlayerPosition::Forward,
            real_team: 'Paris Saint-Germain',
            image_url: 'https://example.com/messi.jpg',
            country: 'Argentina',
            price: 1000000_u32,
            status: PlayerStatus::Available,
            total_points: 200_u32,
        };

        assert(player.id == 1_u64, 'Wrong player ID');
        assert(player.external_id == 123456_felt252, 'Wrong external ID');
        assert(player.name == 'Lionel Messi', 'Wrong player name');
        assert(player.position == PlayerPosition::Forward, 'Wrong player position');
        assert(player.real_team == 'Paris Saint-Germain', 'Wrong real team');
        assert(player.image_url == 'https://example.com/messi.jpg', 'Wrong image URL');
        assert(player.country == 'Argentina', 'Wrong country');
        assert(player.price == 1000000_u32, 'Wrong price');
        assert(player.status == PlayerStatus::Available, 'Wrong status');
        assert(player.total_points == 200_u32, 'Wrong total points');
    }

    #[test]
    fn test_player_equality() {
        let player1 = generate_player();

        // Create another player with the same attributes
        let player2 = generate_player();


        assert(player1 == player2, 'Players should be equal');
    }

    #[test]
    fn test_player_inequality() {
        let player1 = generate_player();

        let player2 = Player {
            id: 2_u64,
            external_id: 654321_felt252,
            name: 'Cristiano Ronaldo',
            position: PlayerPosition::Forward,
            real_team: 'Al Nassr',
            image_url: 'https://example.com/ronaldo.jpg',
            country: 'Portugal',
            price: 1200000_u32,
            status: PlayerStatus::Injured,
            total_points: 150_u32,
        };

        assert(player1 != player2, 'Players should not be equal');
    }

    #[test]
    fn test_player_status() {
        let mut player = generate_player();

        // Change the status to Injured
        player.status = PlayerStatus::Injured;

        // Check if the status is updated correctly
        assert(player.status == PlayerStatus::Injured, 'Player should be injured');
    }

    #[test]
    fn test_player_position() {
        let player = generate_player();

        // Check if the position is set correctly
        assert(player.position == PlayerPosition::Forward, 'Player should be a forward');
    }

    #[test]
    fn test_player_price() {
        let player = generate_player();
        
        // Check if the price is set correctly
        assert(player.price == 1000000_u32, 'Player price should be 1000000');
    }

    #[test]
    fn test_player_total_points() {
        let player = generate_player();

        // Check if the total points are set correctly
        assert(player.total_points == 200_u32, 'Player points should be 200');
    }

    #[test]
    fn test_player_country() {
        let player = generate_player();

        // Check if the country is set correctly
        assert(player.country == 'Argentina', 'Country must be Argentina');
    }

    #[test]
    fn test_player_real_team() {
        let player = generate_player();

        // Check if the real team is set correctly
        assert(player.real_team == 'Paris Saint-Germain', 'Expected: Paris Saint-Germain');
    }

    #[test]
    fn test_player_image_url() {
        let player = generate_player();

        // Check if the image URL is set correctly
        assert(player.image_url == 'https://example.com/messi.jpg', 'Link does not match');
    }

    #[test]
    fn test_player_external_id() {
        let player = generate_player();

        // Check if the external ID is set correctly
        assert(player.external_id == 123456_felt252, 'External ID should be 123456');
    }

    #[test]
    fn test_player_name() {
        let player = generate_player();

        // Check if the name is set correctly
        assert(player.name == 'Lionel Messi', 'Name should be Lionel Messi');
    }

    #[test]
    fn test_player_id() {
        let player = generate_player();

        // Check if the ID is set correctly
        assert(player.id == 1_u64, 'Player ID should be 1');
    }
}