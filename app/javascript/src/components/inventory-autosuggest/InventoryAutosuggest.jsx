import React from 'react'
import { keyHandler } from '../../utilities';

const InventoryAutosuggest = ({inventoryItems, searchInput, updateSearchInput, addItem}) => {
  console.log("InventoryAutosuggest")
  const possibleItems = inventoryItems.filter(itemType => {
    const regex = new RegExp(`^(${searchInput})`, 'i');
    return regex.test(itemType);
  })
    return (
      <ul className="inventory-autosuggest">
        {
          possibleItems.length 
            ?
              possibleItems.map((itemType, index) => (
                <li 
                  key={ index }
                  tabIndex="0"
                  className="inventory-autosuggest__item"
                  onClick={ () => {
                    updateSearchInput('')
                    addItem(itemType) 
                  }}
                  onKeyPress={ keyHandler({
                    fn: () => {
                    updateSearchInput('')
                    addItem(itemType) 
                  }
                  }) }
                >{ itemType }</li>
              ))
            : <li
                className="inventory-autosuggest__item"
                tabIndex="0"
                onClick={ () => {
                  updateSearchInput("")
                  addItem(searchInput)
                }}
                onKeyPress={
                   keyHandler({
                     fn: () => {
                  updateSearchInput("")
                  addItem(searchInput)
                }
                   })
                }
              >Add new item...</li>
        }
      </ul>
    )
  }

export default InventoryAutosuggest;