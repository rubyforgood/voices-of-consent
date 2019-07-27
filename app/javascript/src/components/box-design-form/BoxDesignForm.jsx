import React , { useState, useEffect } from 'react'
import ItemPicker from '../item-picker'
import './BoxDesignForm.scss';
import InventoryAutosuggest from '../inventory-autosuggest';
import { itemTypes as mockItemTypes } from '../../mocks/mockData';

const initialState = [
  {
    item: 'toothbrush',
    count: 1,
  },
  {
    item: 'soap',
    count: 10,
  },
  {
    item: 'Nintendo Switch',
    count: 1,
  },
]

const BoxDesign = () => {
  const [availableItems, updateAvailableItems] = useState([])
  const [items, updateItems] = useState(initialState)
  const [searchInput, updateSearchInput] = useState("")

  useEffect(() => {
    // Mock API call to return available inventory items.
    updateAvailableItems(mockItemTypes)
  }, [])

  const updateItemCount = (targetIndex) => (newValue) => {
    const updatedItems = items.map((item, index) => {
      if(targetIndex === index){
        return {
          ...item,
          count: newValue >= 0 ? newValue : 0,
        }
      }
      return item;
    })
    updateItems(updatedItems);
  }

  const removeItem = (targetIndex) => {
    const updatedItems = items.filter((_, index) => index !== targetIndex);
    updateItems(updatedItems)
  }

  const addItem = (item) => {
    const updatedItems = [ ...items, { item, count: 1 }]
    updateItems(updatedItems)
  }

  return (
    <>
      <section>
        <h2>Box Design</h2>
        <form 
          onSubmit={ e => {
            e.preventDefault()
            addItem(searchInput)
          }}
        >
          <label>
            Inventory Search:
              <input 
                type="text" 
                name = "item"
                placeholder="Search Inventory"
                value={ searchInput }
                autoComplete="off"
                onChange={ e => {
                  updateSearchInput(e.target.value)
                  } }
              />
          </label>
          {
            searchInput &&
              <InventoryAutosuggest 
                inventoryItems={availableItems}
                searchInput={searchInput}
                updateSearchInput={updateSearchInput}
                addItem={addItem}
              />
          }
        </form>
          {
            items.map(({ item, count }, index) => {
              return <ItemPicker 
                key={ index } 
                name={ item } 
                count={ count } 
                updateCount={ updateItemCount(index) }
                removeItem={ () => removeItem(index) }
              />
            })
          }
      </section>
      <section>
        <button
          onClick={() => {
            console.log(items)
          }}
        >Submit</button>
      </section>
    </>
  )
  }

export default BoxDesign;