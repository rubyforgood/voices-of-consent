import React from 'react'

const ItemPicker = ({ name, count, updateCount, removeItem }) => {
    return (
      <section>
        <input
          type="number"
          value={ count }
          step="1"
          min="0"
          onChange={ e => {
            updateCount(e.target.value)
          }}
        />
        <span>{ name }</span>
        <button
          className="item-picker__button--remove"
          onClick={ e => {
            e.preventDefault();
            removeItem();
          }}
        >x</button>
      </section>
    )
  }

export default ItemPicker