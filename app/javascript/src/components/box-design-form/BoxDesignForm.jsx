import React , { useState, useEffect } from 'react'
import ItemPicker from '../item-picker'
import './BoxDesignForm.scss';
import InventoryAutosuggest from '../inventory-autosuggest';
import { keyHandler } from '../../utilities';


const BoxDesign = () => {
  const [availableItems, updateAvailableItems] = useState([])
  const [items, updateItems] = useState([])
  const [searchInput, updateSearchInput] = useState("")

  useEffect(() => {
    // API call to return available inventory items.
    fetch('/inventory_types.json')
      .then(response => response.json())
      .then((data) => {
        const fetchedItemTypes = data.map(({ name }) => name)
        updateAvailableItems(fetchedItemTypes)
      });
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
    <main className="box-design">
      <section>
        <form 
          className="box-design__form"
          onSubmit={ e => {
            e.preventDefault()
            updateSearchInput('')
            addItem(searchInput)
          }}
        >
          <input 
            type="text"
            id="box-design-inventory-search"
            aria-label="Inventory Search Input"
            name = "item"
            placeholder="Search Inventory"
            value={ searchInput }
            autoComplete="off"
            onChange={ e => {
              const sanitizedInput = e.target.value.replace(/\W/gi, "");
              updateSearchInput(sanitizedInput)
              } }
          />
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
            items.length 
              ? 
                <div className="box-design__item-picker">
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
                </div>
              : null
          }
      </section>
      <section className="box-design__text-box">
        {
          items.length 
            ? 
              (
                <>
                  <p>The next step is:</p>
                  <h2>Assembly of Care Box</h2>
                  <p>Thanks so much for your help. Please click the following button below if you are read to progress this box to the next step.</p>
                </>
              )
            : 
              null
        }
      </section>
      <section className="box-design__next-steps">
        <button
          className={`${ items.length ? 'active' : '' }` }
          disabled={ !items.length }
            onClick={() => {
              console.log(items)
            }}
        >{ !items.length ? 'Waiting' : 'The box is ready to go' }</button>
      </section>
    </main>
  )
  }

export default BoxDesign;
