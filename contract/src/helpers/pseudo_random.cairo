use core::pedersen::pedersen;
use starknet::{get_block_timestamp, get_block_number};

/// The PseudoRandom module provides deterministic randomness for Dojo games,
/// allowing developers to generate random values for game mechanics based on
/// Starknet block data like timestamp and block number for entropy.
#[generate_trait]
pub impl PseudoRandom of PseudoRandomTrait {
    /// Generates a pseudo-random u8 value within the specified range [min, max] (inclusive).
    ///
    /// # Arguments
    ///
    /// * `min` - The minimum value (inclusive)
    /// * `max` - The maximum value (inclusive)
    /// * `salt` - An optional salt value to add more entropy
    ///
    /// # Returns
    ///
    /// A pseudo-random u8 value between min and max (inclusive)
    ///
    /// # Example
    ///
    /// ```
    /// use starkfantasy::helpers::pseudo_random::PseudoRandom;
    ///
    /// // Generate a random number between 1 and 100
    /// let random_value = PseudoRandom::generate_random_u8(1, 100, 0);
    /// ```
    fn generate_random_u8(min: u8, max: u8, salt: felt252) -> u8 {
        // Validate input range
        assert(min <= max, 'Min must be <= max');

        // Get entropy sources from Starknet
        let timestamp = get_block_timestamp();
        let block_number = get_block_number();

        // Combine entropy sources with salt
        let hash = pedersen(pedersen(timestamp.into(), block_number.into()), salt);
        
        // Convert the hash to a u8 value
        let hash_u8: u8 = (hash % 256).try_into().unwrap();
        
        // Scale the result to fit within the provided range
        min + (hash_u8 % (max - min + 1))
    }
    
    /// Generates a pseudo-random u32 value within the specified range [min, max] (inclusive).
    ///
    /// # Arguments
    ///
    /// * `min` - The minimum value (inclusive)
    /// * `max` - The maximum value (inclusive)
    /// * `salt` - An optional salt value to add more entropy
    ///
    /// # Returns
    ///
    /// A pseudo-random u32 value between min and max (inclusive)
    fn generate_random_u32(min: u32, max: u32, salt: felt252) -> u32 {
        // Validate input range
        assert(min <= max, 'Min must be <= max');

        // Get entropy sources from Starknet
        let timestamp = get_block_timestamp();
        let block_number = get_block_number();

        // Combine entropy sources with salt
        let hash = pedersen(pedersen(timestamp.into(), block_number.into()), salt);
        
        // Convert the hash to a u32 value (take the lower 32 bits)
        let hash_u32: u32 = (hash % 0x100000000).try_into().unwrap();
        
        // Scale the result to fit within the provided range
        let range = max - min + 1;
        min + (hash_u32 % range)
    }
    
    /// Generates a pseudo-random u64 value within the specified range [min, max] (inclusive).
    ///
    /// # Arguments
    ///
    /// * `min` - The minimum value (inclusive)
    /// * `max` - The maximum value (inclusive)
    /// * `salt` - An optional salt value to add more entropy
    ///
    /// # Returns
    ///
    /// A pseudo-random u64 value between min and max (inclusive)
    fn generate_random_u64(min: u64, max: u64, salt: felt252) -> u64 {
        // Validate input range
        assert(min <= max, 'Min must be <= max');

        // Get entropy sources from Starknet
        let timestamp = get_block_timestamp();
        let block_number = get_block_number();

        // Combine entropy sources with salt
        let hash = pedersen(pedersen(timestamp.into(), block_number.into()), salt);
        
        // Convert the hash to a u64 value
        let hash_u64: u64 = (hash % 0x10000000000000000).try_into().unwrap();
        
        // Scale the result to fit within the provided range
        let range = max - min + 1;
        min + (hash_u64 % range)
    }
}

#[cfg(test)]
mod tests {
    use super::PseudoRandom;
    use starknet::testing::set_block_timestamp;
    use starknet::testing::set_block_number;

    #[test]
    fn test_generate_random_u8_in_range() {
        // Set deterministic block values for testing
        set_block_timestamp(1000);
        set_block_number(500);
        
        // Generate random numbers with different ranges
        let random1 = PseudoRandom::generate_random_u8(1, 10, 0);
        let random2 = PseudoRandom::generate_random_u8(50, 100, 0);
        let random3 = PseudoRandom::generate_random_u8(200, 255, 0);
        
        // Check that values are within the specified ranges
        assert(random1 >= 1 && random1 <= 10, 'Value out of range 1-10');
        assert(random2 >= 50 && random2 <= 100, 'Value out of range 50-100');
        assert(random3 >= 200 && random3 <= 255, 'Value out of range 200-255');
    }

    #[test]
    fn test_generate_random_u8_consistency() {
        // Set deterministic block values for testing
        set_block_timestamp(1000);
        set_block_number(500);
        
        // Generate random numbers with the same inputs
        let random1 = PseudoRandom::generate_random_u8(1, 100, 0);
        let random2 = PseudoRandom::generate_random_u8(1, 100, 0);
        
        // They should be identical since inputs are the same
        assert(random1 == random2, 'Should generate same value');
        
        // Generate with different salt
        let random3 = PseudoRandom::generate_random_u8(1, 100, 123);
        
        // Should be different with different salt
        assert(random1 != random3, 'Should be different with salt');
    }

    #[test]
    fn test_generate_random_u8_edge_cases() {
        // Test with min = max
        let random = PseudoRandom::generate_random_u8(42, 42, 0);
        assert(random == 42, 'Should return exactly 42');
        
        // Test with full range (0-255)
        let random_full = PseudoRandom::generate_random_u8(0, 255, 0);
        assert(random_full >= 0 && random_full <= 255, 'Should be in full range');
    }
    
    #[test]
    fn test_generate_random_u32() {
        // Set deterministic block values for testing
        set_block_timestamp(1000);
        set_block_number(500);
        
        // Generate random u32 numbers
        let random1 = PseudoRandom::generate_random_u32(1, 1000, 0);
        let random2 = PseudoRandom::generate_random_u32(1, 1000, 1);
        
        // Check that values are within the specified range
        assert(random1 >= 1 && random1 <= 1000, 'Value out of range 1-1000');
        assert(random2 >= 1 && random2 <= 1000, 'Value out of range 1-1000');
        
        // Different salts should produce different results
        assert(random1 != random2, 'Different salts -> different values');
    }
    
    #[test]
    fn test_generate_random_u64() {
        // Set deterministic block values for testing
        set_block_timestamp(1000);
        set_block_number(500);
        
        // Generate random u64 numbers
        let random1 = PseudoRandom::generate_random_u64(1, 10000, 0);
        let random2 = PseudoRandom::generate_random_u64(1, 10000, 2);
        
        // Check that values are within the specified range
        assert(random1 >= 1 && random1 <= 10000, 'Value out of range 1-10000');
        assert(random2 >= 1 && random2 <= 10000, 'Value out of range 1-10000');
        
        // Different salts should produce different results
        assert(random1 != random2, 'Different salts -> different values');
    }
    
    #[test]
    #[should_panic(expected: ('Min must be <= max',))]
    fn test_invalid_range() {
        // This should panic because min > max
        PseudoRandom::generate_random_u8(100, 50, 0);
    }
} 