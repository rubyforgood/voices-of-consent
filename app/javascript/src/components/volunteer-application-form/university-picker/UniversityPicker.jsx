import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import CreatableSelect from 'react-select/creatable';

class UniversityPicker extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { selectedUniversity, universityOptions, onChange, onCreate } = this.props

    return (
      <CreatableSelect
        placeholder='Select university...'
        value={selectedUniversity}
        onChange={onChange}
        onCreateOption={onCreate}
        options={universityOptions}
        selected={selectedUniversity}
        isSearchable='true'
      />
    );
  }
}

export default UniversityPicker
