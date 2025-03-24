use core::traits::Into;

#[derive(Copy, Drop, Serde)]
pub enum PlayerPosition {
    Goalkeeper,
    Defender,
    Midfielder,
    Forward,
    Unknown
}

pub impl IntoPlayerPositionFelt252 of Into<PlayerPosition, felt252> {
    #[inline(always)]
    fn into(self: PlayerPosition) -> felt252 {
        match self {
            PlayerPosition::Goalkeeper => 'Goalkeeper',
            PlayerPosition::Defender => 'Defender',
            PlayerPosition::Midfielder => 'Midfielder',
            PlayerPosition::Forward => 'Forward',
            PlayerPosition::Unknown => '',
        }
    }
}

pub impl IntoPlayerPositionU8 of Into<PlayerPosition, u8> {
    #[inline(always)]
    fn into(self: PlayerPosition) -> u8 {
        match self {
            PlayerPosition::Unknown => 0,
            PlayerPosition::Goalkeeper => 1,
            PlayerPosition::Defender => 2,
            PlayerPosition::Midfielder => 3,
            PlayerPosition::Forward => 4,
        }
    }
}

pub impl IntoU8PlayerPosition of Into<u8, PlayerPosition> {
    #[inline(always)]
    fn into(self: u8) -> PlayerPosition {
        match self {
            0 => PlayerPosition::Unknown,
            1 => PlayerPosition::Goalkeeper,
            2 => PlayerPosition::Defender,
            3 => PlayerPosition::Midfielder,
            4 => PlayerPosition::Forward,
            _ => PlayerPosition::Unknown,
        }
    }
}

// Unit Tests
#[cfg(test)]
mod tests {
    use core::traits::Into;
    use super::{PlayerPosition, IntoPlayerPositionFelt252, IntoPlayerPositionU8, IntoU8PlayerPosition};

    #[test]
    fn test_player_position_to_felt252() {
        // Verificar la conversión de cada posición a felt252
        let goalkeeper_str = Into::<PlayerPosition, felt252>::into(PlayerPosition::Goalkeeper);
        let defender_str = Into::<PlayerPosition, felt252>::into(PlayerPosition::Defender);
        let midfielder_str = Into::<PlayerPosition, felt252>::into(PlayerPosition::Midfielder);
        let forward_str = Into::<PlayerPosition, felt252>::into(PlayerPosition::Forward);
        let unknown_str = Into::<PlayerPosition, felt252>::into(PlayerPosition::Unknown);
        
        assert(goalkeeper_str == 'Goalkeeper', 'Goalkeeper conversion failed');
        assert(defender_str == 'Defender', 'Defender conversion failed');
        assert(midfielder_str == 'Midfielder', 'Midfielder conversion failed');
        assert(forward_str == 'Forward', 'Forward conversion failed');
        assert(unknown_str == '', 'Unknown conversion failed');
    }

    #[test]
    fn test_player_position_to_u8() {
        // Verificar la conversión de cada posición a u8
        let goalkeeper_num = Into::<PlayerPosition, u8>::into(PlayerPosition::Goalkeeper);
        let defender_num = Into::<PlayerPosition, u8>::into(PlayerPosition::Defender);
        let midfielder_num = Into::<PlayerPosition, u8>::into(PlayerPosition::Midfielder);
        let forward_num = Into::<PlayerPosition, u8>::into(PlayerPosition::Forward);
        let unknown_num = Into::<PlayerPosition, u8>::into(PlayerPosition::Unknown);
        
        assert(goalkeeper_num == 1_u8, 'Goalkeeper to u8 failed');
        assert(defender_num == 2_u8, 'Defender to u8 failed');
        assert(midfielder_num == 3_u8, 'Midfielder to u8 failed');
        assert(forward_num == 4_u8, 'Forward to u8 failed');
        assert(unknown_num == 0_u8, 'Unknown to u8 failed');
    }

    #[test]
    fn test_u8_to_player_position() {
        // Verificar la conversión de u8 a cada posición
        let from_1 = Into::<u8, PlayerPosition>::into(1_u8);
        let from_2 = Into::<u8, PlayerPosition>::into(2_u8);
        let from_3 = Into::<u8, PlayerPosition>::into(3_u8);
        let from_4 = Into::<u8, PlayerPosition>::into(4_u8);
        let from_0 = Into::<u8, PlayerPosition>::into(0_u8);
        let from_100 = Into::<u8, PlayerPosition>::into(100_u8);
        
        assert(
            match from_1 {
                PlayerPosition::Goalkeeper => true,
                _ => false,
            },
            'u8 to Goalkeeper failed'
        );
        
        assert(
            match from_2 {
                PlayerPosition::Defender => true,
                _ => false,
            },
            'u8 to Defender failed'
        );
        
        assert(
            match from_3 {
                PlayerPosition::Midfielder => true,
                _ => false,
            },
            'u8 to Midfielder failed'
        );
        
        assert(
            match from_4 {
                PlayerPosition::Forward => true,
                _ => false,
            },
            'u8 to Forward failed'
        );
        
        assert(
            match from_0 {
                PlayerPosition::Unknown => true,
                _ => false,
            },
            'u8 to Unknown (0) failed'
        );
        
        // Probar un valor fuera de rango (debería convertirse a Unknown)
        assert(
            match from_100 {
                PlayerPosition::Unknown => true,
                _ => false,
            },
            'u8 out of range Unknown'
        );
    }
} 