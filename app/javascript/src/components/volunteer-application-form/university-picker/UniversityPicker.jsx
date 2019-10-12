import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import Select from 'react-select';

class UniversityPicker extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { selectedUniversity, universityOptions } = this.props

    return (
      <Select
        placeholder='Select university...'
        value={selectedUniversity}
        onChange={this.props.onChange}
        options={universityOptions}
        selected={selectedUniversity}
        isSearchable='true'
      />
    );
  }
}

export default UniversityPicker
