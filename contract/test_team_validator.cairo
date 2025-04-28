from team_validator import validate_position_counts, validate_team_diversity, validate_complete_team, is_valid_team

func test_validate_position_counts():
    let team = {"GK": 1, "DEF": 5, "MID": 5, "FWD": 3}
    assert validate_position_counts(team) == 1  # Valid team
    let invalid_team = {"GK": 2, "DEF": 4, "MID": 3, "FWD": 2}
    assert validate_position_counts(invalid_team) == 0  # Invalid team

func test_validate_team_diversity():
    let team_counts = {"Man City": 3, "Liverpool": 2}
    assert validate_team_diversity(team_counts) == 1  # Valid diversity
    let invalid_team_counts = {"Man City": 4}
    assert validate_team_diversity(invalid_team_counts) == 0  # Invalid diversity

func test_validate_complete_team():
    assert validate_complete_team(11) == 1  # Valid total players
    assert validate_complete_team(10) == 0  # Invalid total players

func test_is_valid_team():
    let team = {"GK": 1, "DEF": 5, "MID": 5, "FWD": 3}
    let team_counts = {"Man City": 3, "Liverpool": 2}
    assert is_valid_team(team, team_counts, 11) == 1  # Valid team
    let invalid_team = {"GK": 2, "DEF": 4, "MID": 3, "FWD": 2}
    assert is_valid_team(invalid_team, team_counts, 11) == 0  # Invalid team
