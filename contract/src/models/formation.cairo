use core::traits::Into;

#[derive(Copy, Drop, Serde, PartialEq)]
pub enum Formation {
    F442, // 4-4-2
    F433, // 4-3-3
    F352, // 3-5-2
    F343, // 3-4-3
    F4231 // 4-2-3-1
}

pub impl IntoFormationFelt252 of Into<Formation, felt252> {
    #[inline(always)]
    fn into(self: Formation) -> felt252 {
        match self {
            Formation::F442 => '4-4-2',
            Formation::F433 => '4-3-3',
            Formation::F352 => '3-5-2',
            Formation::F343 => '3-4-3',
            Formation::F4231 => '4-2-3-1',
        }
    }
}

pub impl IntoFormationU8 of Into<Formation, u8> {
    #[inline(always)]
    fn into(self: Formation) -> u8 {
        match self {
            Formation::F442 => 1,
            Formation::F433 => 2,
            Formation::F352 => 3,
            Formation::F343 => 4,
            Formation::F4231 => 5,
        }
    }
}

pub impl IntoU8Formation of Into<u8, Formation> {
    #[inline(always)]
    fn into(self: u8) -> Formation {
        match self {
            0 => panic!("Invalid formation ID"),
            1 => Formation::F442,
            2 => Formation::F433,
            3 => Formation::F352,
            4 => Formation::F343,
            5 => Formation::F4231,
            _ => panic!("Invalid formation ID"),
        }
    }
}

// TODO: implement this function when the PlayerPosition enum is implemented.
// Function to validate if a team's PlayerPositions match the expectedformation
// pub fn is_valid_formation(positions: Array<PlayerPosition>, formation: Formation) -> bool {
//
// }

#[cfg(test)]
mod tests {
    use super::{Formation};
    use core::traits::Into;

    #[test]
    fn test_formation_to_felt252() {
        let formation = Formation::F442;
        let formation_str: felt252 = formation.into();
        assert(formation_str == '4-4-2', 'F442 should be 4-4-2');

        let formation = Formation::F433;
        let formation_str: felt252 = formation.into();
        assert(formation_str == '4-3-3', 'F433 should be 4-3-3');

        let formation = Formation::F352;
        let formation_str: felt252 = formation.into();
        assert(formation_str == '3-5-2', 'F352 should be 3-5-2');

        let formation = Formation::F343;
        let formation_str: felt252 = formation.into();
        assert(formation_str == '3-4-3', 'F343 should be 3-4-3');

        let formation = Formation::F4231;
        let formation_str: felt252 = formation.into();
        assert(formation_str == '4-2-3-1', 'F4231 should be 4-2-3-1');
    }

    #[test]
    fn test_formation_to_u8() {
        let formation = Formation::F442;
        let formation_u8: u8 = formation.into();
        assert(formation_u8 == 1, 'F442 should be 1');

        let formation = Formation::F433;
        let formation_u8: u8 = formation.into();
        assert(formation_u8 == 2, 'F433 should be 2');

        let formation = Formation::F352;
        let formation_u8: u8 = formation.into();
        assert(formation_u8 == 3, 'F352 should be 3');

        let formation = Formation::F343;
        let formation_u8: u8 = formation.into();
        assert(formation_u8 == 4, 'F343 should be 4');

        let formation = Formation::F4231;
        let formation_u8: u8 = formation.into();
        assert(formation_u8 == 5, 'F4231 should be 5');
    }

    #[test]
    fn test_u8_to_formation() {
        let u8_value: u8 = 1;
        let formation: Formation = u8_value.into();
        assert(formation == Formation::F442, '1 should be F442');

        let u8_value: u8 = 2;
        let formation: Formation = u8_value.into();
        assert(formation == Formation::F433, '2 should be F433');

        let u8_value: u8 = 3;
        let formation: Formation = u8_value.into();
        assert(formation == Formation::F352, '3 should be F352');

        let u8_value: u8 = 4;
        let formation: Formation = u8_value.into();
        assert(formation == Formation::F343, '4 should be F343');

        let u8_value: u8 = 5;
        let formation: Formation = u8_value.into();
        assert(formation == Formation::F4231, '5 should be F4231');
    }

    #[test]
    #[should_panic(expected: ("Invalid formation ID",))]
    fn test_invalid_u8_to_formation() {
        let u8_value: u8 = 10;
        let _formation: Formation = u8_value.into();
    }
}
