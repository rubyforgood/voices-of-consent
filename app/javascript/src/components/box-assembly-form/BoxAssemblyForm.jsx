import React, { useEffect, useState } from 'react';
import ItemChecker from './item-checker';
import './BoxAssemblyForm.scss';

const BoxAssemblyForm = () => {
  const [items, updateItems] = useState(null);
  const [isAssembled, updateIsAssembled] = useState(false);

  useEffect(() => {
    // API call to return predetermined box items.
    fetch(`${window.location.pathname}.json`)
      .then(response => response.json())
      .then((data) => {
        const unassembledBoxItems = data.map((item) => {
          return { id: item.id, type: item.inventory_type.name, count: item.quantity }
        })
        // We want to give each item a bool representing
        // being added to a box already.
        const unassembledItemChecklist = unassembledBoxItems.map((item) => {
          item.checked = false;
          return item;
        })
        updateItems(unassembledItemChecklist);
      });
  }, [])

  // This will run on every update to the items to determine
  // if the box is fully assembled and ready to ship.
  useEffect(() => {
    if(items){
      const uncheckedItems = items.filter(item => !item.checked);
      if(!uncheckedItems.length){
        updateIsAssembled(true);
      }
      else {
        updateIsAssembled(false);
      }
    }
  }, [items])

  const updateAssemblyStatus = (index) => {
    const updatedItems = items.map((item, i) => {
      if(i === index) {
        item.checked = !item.checked;
      }
      return item;
    })
    console.log("CHRIS: updated items= ", updatedItems);
    updateItems(updatedItems);
  }


  return (
    <main className="box-assembly">
      <h2 className="box-assembly__header">Box Packing Checklist</h2>
      <section className="text-box">
        <p>Please check items as you add them to the box.</p>
      </section>
      <section className="box-assembly__item-checker">
        {
          items &&
            items.map((item, i) => (
              <ItemChecker 
                key={ i }
                updateCheckStatus={ () => {
                  updateAssemblyStatus(i);
                }}
                { ...item }
              />
            ))
        }
      </section>
      <section className="next-steps">
        <button
          className={`${ isAssembled ? 'active' : '' }` }
          disabled={ !items }
          onClick={() => {
            // TODO: AJAX Call
            console.log(items)
          }}
        >{ !isAssembled ? 'Waiting' : 'The box is ready to go' }</button>
      </section>
    </main>
  )
}

export default BoxAssemblyForm;