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