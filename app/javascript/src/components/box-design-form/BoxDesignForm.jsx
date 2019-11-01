import React , { useState, useEffect } from 'react'
import ItemPicker from '../item-picker'
import './BoxDesignForm.scss'
import CreatableSelect from 'react-select/creatable'


const BoxDesign = () => {
  const [allItems, updateAllItems] = useState([])
  const [items, updateItems] = useState([])
  const [searchInput, updateSearchInput] = useState("")
  const [selectableItems, updateSelectableItems] = useState([])

  useEffect(() => {
    // API call to return available inventory items.
    fetch('/inventory_types.json')
      .then(response => response.json())
      .then((data) => {
        const allTypes = data.map(({ name }) => name)
        const selectTypes = data.map((type) => {
          return { value: type.name, label: type.name }
        })
        updateAllItems(allTypes)
        updateSelectableItems(selectTypes)
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
    const removedItem = items.filter((_, index) => index === targetIndex)[0].item;
    const updatedItems = items.filter((_, index) => index !== targetIndex);
    updateItems(updatedItems)
    if (allItems.includes(removedItem)) {
      const expandedSelectableItems = selectableItems.concat([{value: removedItem, label: removedItem}])
      return updateSelectableItems(expandedSelectableItems)
    }
  }

  const addItem = (item) => {
    const updatedItems = [ ...items, { item, count: 1 }]
    updateItems(updatedItems)
  }

  return (
    <main className="box-design">
      <section>
        <form className="box-design__form">
          <CreatableSelect
            name="item"
            id="box-design-inventory-search"
            aria-label="Inventory Search Input"
            placeholder="Search Inventory"
            value={ searchInput }
            options={ selectableItems }
            isClearable
            onChange = { e => {
              updateSearchInput('')
              addItem(e.value)
              const reducedSelectableItems = selectableItems.filter(itemType =>
                itemType.value != e.value
              );
              updateSelectableItems(reducedSelectableItems)
            }}
          />

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
                  <p>Thanks so much for your help. Please click the following
                     button below if you are ready to progress this box to the
                     next step.</p>
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

export default BoxDesign
