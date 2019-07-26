import React, {useState} from 'react'

const ItemPicker = (props) => {
    let [count, setCount] = useState(0);
    const setItemCount = e => {
        e.preventDefault();
        console.log(count);
        setCount(count+1);
    }
    return (
      <section>
        <span>{count}</span><button onClick={setItemCount}>+</button>
      </section>
    )
  }

export default ItemPicker