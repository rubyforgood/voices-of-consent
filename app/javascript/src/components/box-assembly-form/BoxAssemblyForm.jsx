import React, { useEffect, useState } from 'react';
import ItemChecker from './item-checker';
import './BoxAssemblyForm.scss';

const BoxAssemblyForm = () => {
  const [items, updateItems] = useState(null);
  const [isAssembled, updateIsAssembled] = useState(false);
  const [selectedLocation, setLocation] = useState(null);
  const [submitedState, setSubmittedState] = useState(null);

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
        var submittedState = unassembledBoxItems.map(anItem=>anItem.checked);
        setSubmittedState(submittedState);
      });
  }, [])

  //Find a location to pull from:
  useEffect(() => {

    // API call to return predetermined box items.
    fetch(`/locations.json?location_type=storage_unit`)
      .then(response => response.json())
      .then((data) => {
        if (data && Array.isArray(data) && data.length > 0) {
          //Pick the first location
          console.debug("Setting location", data[0]);
          setLocation(data[0]);
        }
      });
  }, [])

  // This will run on every update to the items to determine
  // if the box is fully assembled and ready to ship.
  useEffect(() => {
    if (items) {
      const uncheckedItems = items.filter(item => !item.checked);
      if (!uncheckedItems.length) {
        updateIsAssembled(true);
      }
      else {
        updateIsAssembled(false);
      }
    }
  }, [items])

  const updateCheckboxState = (index) => {
    var newState = items.map((anItem, i) => {
      var returnItem = {};
      if (i === index) {
        returnItem.checked = !returnItem.checked;
      }

      return { id: anItem.id, type: anItem.type, count: anItem.count, checked: (i === index)? !anItem.checked : anItem.checked}
    });

    updateItems(newState);

  }

  const getInventoryTallyPromise = (inventory_tally_id, box_item_id, adjustment_quantity, index) => {
    const token = document.getElementsByName('csrf-token')[0].content
    var opts = {
      inventory_tally_id: inventory_tally_id,
      box_item_id: box_item_id,
      adjustment_quantity: adjustment_quantity
    }


    return fetch(`/inventory_adjustments.json/`, {
      method: 'POST',
      body: JSON.stringify(opts),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token
      }
    });
  };

  const tallySubmitted = () => {
    console.group("Check box state: ");
    console.debug("Items: ", items);
    console.debug("submitedState: ",submitedState);
    console.groupEnd();

    //Only do work if there is location
    if (selectedLocation) {

      var inventoryTallies =  items.map((anItem, index) => {
        if (anItem.checked != submitedState[index]) {
          return anItem;
        }
        return undefined;
      }).filter(Boolean);

      var inventoryPromises = inventoryTallies.map(anItem => {
          return fetch(`/inventory_tallies.json/?storage_location_id=` + selectedLocation.id + `&inventory_type_id` + `=` + anItem.id);
        })

      Promise.all(inventoryPromises).then(allResponse=>{
          return Promise.all(allResponse.map(aResp=>aResp.json()));
      }).then(json=>{
        var allInventoryTallies = [];
        for(var i=0; i<json.length;i++) {
          var subInventoryTallies = json[i].map(anObj=>{
            return {
              inventory_tally_id: anObj.id,
              box_item_id: inventoryTallies[i].id,
              adjustment_quantity: inventoryTallies[i].checked ? -1 : 1
            }
          })

          allInventoryTallies.push(...subInventoryTallies);
        }
        
        var updateTallyPromises = allInventoryTallies.map(aTally=>{
          return getInventoryTallyPromise(aTally.inventory_tally_id, aTally.box_item_id, aTally.adjustment_quantity);
        })

        Promise.all(updateTallyPromises).then(allResponse=>{
          return Promise.all(allResponse.map(aResp=>aResp.json()));
        }).then(json=>{
           //Update the checkbox state:
           var newSavedState = [...submitedState];
           for(var i = 0; i<json.length;i++) {
             var updatedId = inventoryTallies[i].id;
             var updatedIndex = items.findIndex(anItem=>anItem.id === updatedId)
             newSavedState[updatedIndex] = inventoryTallies[i].checked;
            
           }

           setSubmittedState(newSavedState);
        })

      })
    }

  }

  var locationReadout = (selectedLocation) ? <div>{selectedLocation.name}</div> : [];

  var buttonDisabled = !items ||  items.filter((anItem,index)=>{

    if(submitedState) {
      return anItem.checked === submitedState[index];
    }
    return true;
    
  }).length == items.length;

  return (
    <main className="box-assembly">
      <h2 className="box-assembly__header">4 Box Packing Checklist</h2>

      <section className="text-box">
        <p>Please check items as you add them to the box.</p>
      </section>
      <section className="text-box">
        {selectedLocation && <p>Items are coming from: {locationReadout}</p>}
      </section>
      <section className="box-assembly__item-checker">
        {
          items &&
          items.map((item, i) => (
            <ItemChecker
              enabled={selectedLocation ? true : false}
              key={i}
              updateCheckStatus={() => {
                updateCheckboxState(i);
              }}
              {...item}
            />
          ))
        }
      </section>
      <section className="next-steps">
        <button
          className={`${isAssembled ? 'active' : ''}`}
          disabled={buttonDisabled}
          onClick={tallySubmitted}
        >{!isAssembled ? 'Waiting' : 'The box is ready to go'}</button>
      </section>
    </main>
  )
}

export default BoxAssemblyForm;