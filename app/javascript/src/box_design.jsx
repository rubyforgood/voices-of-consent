import React from 'react'
import ItemPicker from '../src/components/item_picker'

const BoxDesign = (props) => {
    return (
      <section>
          <h2>Box Design</h2>
          <form>
              <label>
                Inventory Search:
                  <input type="text" name = "item" />
              </label>
              <ItemPicker></ItemPicker>
          </form>
      </section>
    )
  }

export default BoxDesign;