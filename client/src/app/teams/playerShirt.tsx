import React from 'react';
import PlayerShirtImage from '../public/PlayerShirt.png';

function PlayerShirt() {
  return (
    <div style={{ display: 'flex' }}>
      <img src={PlayerShirtImage} alt="Player Shirt" />
    </div>
  );
}

export default PlayerShirt; 
