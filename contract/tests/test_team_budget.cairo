%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.testing.cairo_test_utils import expect_revert
from src.team_budget import (
    initialize_budget,
    update_budget,
    can_afford,
    get_remaining_budget,
)

@external
func test_initialize_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    initialize_budget(42, 100_000_000)
    let (remaining_budget) = get_remaining_budget(42)
    assert remaining_budget == 100_000_000, "Initialization failed."
    return ()
end

@external
func test_update_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    initialize_budget(42, 100_000_000)
    update_budget(42, 95_000_000)
    let (remaining_budget) = get_remaining_budget(42)
    assert remaining_budget == 5_000_000, "Budget update failed."
    return ()
end

@external
func test_can_afford{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    initialize_budget(42, 100_000_000)
    let (can_afford_result) = can_afford(42, 95_000_000)
    assert can_afford_result == 1, "Affordability check failed."
    let (can_afford_result_fail) = can_afford(42, 105_000_000)
    assert can_afford_result_fail == 0, "Affordability check failed."
    return ()
end

@external
func test_insufficient_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    initialize_budget(42, 100_000_000)
    expect_revert(update_budget(42, 105_000_000))
    return ()
end
