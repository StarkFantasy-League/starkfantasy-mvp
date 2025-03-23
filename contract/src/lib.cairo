pub mod systems {
    pub mod actions;
}

pub mod models {
    pub mod user;
    pub mod position;
    pub mod direction;
    pub mod directions_available;
    pub mod formation;
    pub mod moves;
    pub mod vec2;
}

#[cfg(test)]
pub mod tests;
