import React from 'react'

const InventoryAutosuggest = ({inventoryItems, searchInput, updateSearchInput, addItem}) => {
    const possibleItems = inventoryItems.filter(itemType => {
      const regex = new RegExp(`^(${ searchInput })`, 'i');
      return regex.test(itemType);
    })
    return (
      <ul>
        {
          possibleItems.length 
            ?
              possibleItems.map((itemType, index) => (
                <li 
                  key={ index }
                  onClick={ () => {
                    updateSearchInput('')
                    addItem(itemType) 
                  }}
                >{ itemType }</li>
              ))
            : <li 
                onClick={ () => {
                  updateSearchInput("")
                  addItem(searchInput)
                }}
              >Add new item...</li>
        }
      </ul>
    )
  }

export default InventoryAutosuggest;