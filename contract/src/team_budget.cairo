%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_le

@storage_var
func team_budget(team_id: felt) -> (total_budget: felt, spent_amount: felt, remaining_budget: felt):
end

@external
func initialize_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    team_id: felt, total_budget: felt
):
    let (spent_amount, remaining_budget) = team_budget.read(team_id)
    assert spent_amount == 0, "Budget already initialized."
    assert remaining_budget == 0, "Budget already initialized."
    team_budget.write(team_id, total_budget, 0, total_budget)
    return ()
end

@external
func update_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    team_id: felt, cost: felt
):
    let (total_budget, spent_amount, remaining_budget) = team_budget.read(team_id)
    assert_le(cost, remaining_budget), "Insufficient budget."
    let new_spent_amount = spent_amount + cost
    let new_remaining_budget = remaining_budget - cost
    team_budget.write(team_id, total_budget, new_spent_amount, new_remaining_budget)
    return ()
end

@view
func can_afford{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    team_id: felt, player_cost: felt
) -> (can_afford: felt):
    let (_, _, remaining_budget) = team_budget.read(team_id)
    if player_cost <= remaining_budget:
        return (1)
    else:
        return (0)
    end
end

@view
func get_remaining_budget{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    team_id: felt
) -> (remaining_budget: felt):
    let (_, _, remaining_budget) = team_budget.read(team_id)
    return (remaining_budget)
end
