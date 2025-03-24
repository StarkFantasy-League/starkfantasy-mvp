use starknet::ContractAddress;
#[derive(Model, Copy, Drop, Serde)]
struct User {
    #[key]
    id: ContractAddress,
    username: felt252,
    tournaments_won: u16,
    created_at: u64,
    last_connection: u64,
}

#[cfg(test)]
mod tests {
    use super::User;
    use starknet::ContractAddress;

    #[test]
    fn test_user_creation() {
        let user1 = User {
            id: ContractAddress::from(0x1234_u64),
            username: 252u8.into(),
            tournaments_won: 3_u16,
            created_at: 1710000000_u64,
            last_connection: 1710500000_u64,
        };
        assert(user1.id == ContractAddress::from(0x1234_u64), "Wrong user id");
        assert(user1.username == 252u8.into(), "Wrong username");
        assert(user1.tournaments_won == 3_u16, "Wrong tournaments_won");
        assert(user1.created_at == 1710000000_u64, "Wrong created_at");
        assert(user1.last_connection == 1710500000_u64, "Wrong last_connection");
    }

    #[test]
    fn test_user_equality() {
        let user1 = User {
            id: ContractAddress::from(0x1234_u64),
            username: 252u8.into(),
            tournaments_won: 3_u16,
            created_at: 1710000000_u64,
            last_connection: 1710500000_u64,
        };

        let user2 = User {
            id: ContractAddress::from(0x1234_u64),
            username: 252u8.into(),
            tournaments_won: 3_u16,
            created_at: 1710000000_u64,
            last_connection: 1710500000_u64,
        };

        let user3 = User {
            id: ContractAddress::from(0x5678_u64),
            username: 253u8.into(),
            tournaments_won: 5_u16,
            created_at: 1711000000_u64,
            last_connection: 1711500000_u64,
        };

        assert(user1.id == user2.id, "User IDs should match");
        assert(user1.username == user2.username, "Usernames should match");
        assert(user1.id != user3.id, "User IDs should differ");
        assert(user1.username != user3.username, "Usernames should differ");
    }
}
