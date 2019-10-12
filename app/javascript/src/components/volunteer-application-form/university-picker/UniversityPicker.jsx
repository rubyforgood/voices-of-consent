import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import Select from 'react-select';

class UniversityPicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedOption: null,
      universityOptions: []
    }
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidMount() {
    const { universityOptions } = this.state;

    fetch('/locations.json?location_type=university')
      .then(response => response.json())
      .then((data) => {
        const universities = data.map((university) => ({ label: university.name, value: university.id }))
        this.setState({ universityOptions: [...universities, ...universityOptions] })
      });
  }

  handleChange(selectedOption) {
    this.setState({ selectedOption });
    this.props.onChange(({ name: 'university_location_id', value: selectedOption.value }))
  }

  render() {
    const { selectedOption, universityOptions } = this.state;

    return (
      <Select
        placeholder='Select university...'
        value={selectedOption}
        onChange={this.handleChange}
        options={universityOptions}
        selected={selectedOption}
      />
    );
  }
}

export default UniversityPicker
