use core::traits::Into;

#[derive(Copy, Drop, Serde, Debug, PartialEq, Introspect)]
pub enum PlayerStatus {
    Available,
    Injured,
    Suspended,
    NotAvailable,
}

pub impl PlayerStatusIntoFelt252 of Into<PlayerStatus, felt252> {
    #[inline(always)]
    fn into(self: PlayerStatus) -> felt252 {
        match self {
            PlayerStatus::Available => 'Available',
            PlayerStatus::Injured => 'Injured',
            PlayerStatus::Suspended => 'Suspended',
            PlayerStatus::NotAvailable => 'Not Available',
        }
    }
}

pub impl PlayerStatusIntoU8 of Into<PlayerStatus, u8> {
    #[inline(always)]
    fn into(self: PlayerStatus) -> u8 {
        match self {
            PlayerStatus::Available => 0,
            PlayerStatus::Injured => 1,
            PlayerStatus::Suspended => 2,
            PlayerStatus::NotAvailable => 3,
        }
    }
}

pub impl U8IntoPlayerStatus of Into<u8, PlayerStatus> {
    #[inline(always)]
    fn into(self: u8) -> PlayerStatus {
        match self {
            0 => PlayerStatus::Available,
            1 => PlayerStatus::Injured,
            2 => PlayerStatus::Suspended,
            3 => PlayerStatus::NotAvailable,
            _ => PlayerStatus::NotAvailable,
        }
    }
}

// Unit Tests
#[cfg(test)]
mod tests {
    use super::PlayerStatus;

    #[test]
    fn test_player_status_to_felt252() {
        // verify convertion from PlayerStatus to felt252
        assert_eq!(PlayerStatus::Available.into(), 'Available');
        assert_eq!(PlayerStatus::Injured.into(), 'Injured');
        assert_eq!(PlayerStatus::Suspended.into(), 'Suspended');
        assert_eq!(PlayerStatus::NotAvailable.into(), 'Not Available');
    }

    #[test]
    fn test_player_status_to_u8() {
        // verify convertion from PlayerStatus to u8
        assert_eq!(PlayerStatus::Available.into(), 0_u8);
        assert_eq!(PlayerStatus::Injured.into(), 1_u8);
        assert_eq!(PlayerStatus::Suspended.into(), 2_u8);
        assert_eq!(PlayerStatus::NotAvailable.into(), 3_u8);
    }

    #[test]
    fn test_u8_to_player_status() {
        // verify convertion from u8 to PlayerStatus
        assert_eq!(0_u8.into(), PlayerStatus::Available);
        assert_eq!(1_u8.into(), PlayerStatus::Injured);
        assert_eq!(2_u8.into(), PlayerStatus::Suspended);
        for player_status in 3_u8..255 {
            assert_eq!(player_status.into(), PlayerStatus::NotAvailable);
        }
    }
}
