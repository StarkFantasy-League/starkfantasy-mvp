#[test]
fn test_player_performance_initialization() {
    let player = ContractAddress::from_felt252(123456789_felt252);

    let performance = PlayerPerformance {
        player,
        tournament_id: 0,
        match_external_id: 0_felt252,
        match_date: 0,
        goals: 0,
        assists: 0,
        yellow_cards: 0,
        red_cards: 0,
        clean_sheet: false,
        saves: 0,
        points: 0
    };

    assert(performance.goals == 0, "Goals should be initialized to 0");
    assert(performance.points == 0, "Points should be initialized to 0");
}
