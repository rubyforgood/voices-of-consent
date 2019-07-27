import React from 'react'

const ItemPicker = ({ name, count, updateCount, removeItem }) => (
  <div className="item-picker">
    <input
      type="number"
      value={ count }
      step="1"
      min="0"
      onChange={ e => {
        updateCount(e.target.value)
      }}
    />
    <span className="item-picker__name">{ name }</span>
    <button
      className="item-picker__remove-button"
      onClick={ e => {
        e.preventDefault();
        removeItem();
      }}
    >x</button>
  </div>
)

export default ItemPicker