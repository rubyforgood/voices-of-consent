import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import TextInput from './text-input'
import './BoxRequestForm.scss'

class BoxRequestForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      boxRequest: {
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        street_address: '',
        city: '',
        state: '',
        zip: '',
        county: '',
        ok_to_email: null,
        ok_to_text: null,
        ok_to_call: null,
        ok_to_mail: null,
        summary: '',
        question_re_affect: '',
        question_re_referral_source: '',
        question_re_current_situation: '',
        question_re_if_not_self_completed: '',
        is_safe: null,
        is_interested_in_counseling_services: null,
        is_interested_in_health_services: null,
        is_underage: null,
      },
    }

    this.handleChange = this.handleChange.bind(this);
    this.handleRadioChange = this.handleRadioChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ boxRequest: { ...this.state.boxRequest, [event.target.name]: event.target.value} });
  }

  handleRadioChange(event) {
    let updatedChoice = event.target.id.includes("true") ? true : false;
    this.setState({ boxRequest: { ...this.state.boxRequest, [event.target.name]: updatedChoice} });
  }

  handleSubmit(event) {
    event.preventDefault();
    console.log(this.state);
  }

  render() {
    return (
      <div class="container">
        <form onSubmit={this.handleSubmit}>
          <div class="row section-top section-label">Name *</div>
          <div class="row">
            <div class="col-md">
              <input type="text" class="row form-control" name="first_name" value={this.state.boxRequest.first_name} onChange={this.handleChange} />
              <label class="row sub-text">First Name</label>
            </div>
            <div class="col-md">
              <input type="text" class="row form-control" name="last_name" value={this.state.boxRequest.last_name} onChange={this.handleChange} />
              <label class="row sub-text">Last Name</label>
            </div>
          </div>
          <div class="row section-top">
            <label class="section-label">Email Address *</label>
            <input type="text" class="form-control" name="email" value={this.state.boxRequest.email} onChange={this.handleChange} />
          </div>

          <label class="row section-top">Type of abuse you have faced *</label>
            <div class="row form-check">
              <input class="form-check-input" type="checkbox" />
              <label class="form-check-label" for="defaultCheck1">
                Emotional
              </label>
            </div>
            <div class="row form-check">
              <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" />
              <label class="form-check-label" for="defaultCheck2">
                Physical
              </label>
            </div>
            <div class="row form-check">
              <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" />
              <label class="form-check-label" for="defaultCheck2">
                Sexual
              </label>
            </div>
            <div class="row form-check">
              <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" />
              <label class="form-check-label" for="defaultCheck2">
                All of the Above
              </label>
            </div>

          <div class="row section-top" >
            <label>Briefly describe your current situation. Is the abuse current? Do you live with your abuser? Do you have kids affected by the abuse? *</label>
            <textarea type="text" class="form-control" name="question_re_current_situation" value={this.state.boxRequest.question_re_current_situation} onChange={this.handleChange} />
          </div>

          <div class="row section-top">
            <label>How did this abuse affect your life? *</label>
            <textarea type="text" class="form-control" name="question_re_affect" value={this.state.boxRequest.question_re_affect} onChange={this.handleChange} />
          </div>

          <label class="row section-top">Do you feel safe now? *</label>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_safe_true" name="is_safe" class="custom-control-input" onChange={this.handleRadioChange}/>
              <label class="custom-control-label radio-box" for="is_safe_true">yes</label>
            </div>
          </div>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_safe_false" name="is_safe" class="custom-control-input" onChange={this.handleRadioChange}/>
              <label class="custom-control-label radio-box" for="is_safe_false">no</label>
            </div>
          </div>

          <label class="row section-top">Are you interested in learning about free counseling services? *</label>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_interested_in_counseling_services_true" name="is_interested_in_counseling_services" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_interested_in_counseling_services_true">yes</label>
            </div>
          </div>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_interested_in_counseling_services_false" name="is_interested_in_counseling_services" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_interested_in_counseling_services_false">no</label>
            </div>
          </div>

          <label class="row section-top">Are you interested in learning about free health services? *</label>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_interested_in_health_services_true" name="is_interested_in_health_services" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_interested_in_health_services_true">yes</label>
            </div>
          </div>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_interested_in_health_services_false" name="is_interested_in_health_services" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_interested_in_health_services_false">no</label>
            </div>
          </div>

          <label class="row section-top">What is is your age? *</label>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_underage_true" name="is_underage" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_underage_true">0-12 years old</label>
            </div>
          </div>
          <div class="row">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="is_underage_false" name="is_underage" class="custom-control-input" onChange={this.handleRadioChange} />
              <label class="custom-control-label radio-box" for="is_underage_false">13+ years old</label>
            </div>
          </div>

          <div class="row section-top">
            <label>How did you hear about us? *</label>
            <input type="text" class="form-control" name="question_re_referral_source" value={this.state.boxRequest.question_re_referral_source} onChange={this.handleChange} />
          </div>

          <div class="row section-top section-label">Address *</div>
          <div class="row sub-text">
            <input type="text" class="form-control" name="street_address" value={this.state.boxRequest.street_address} onChange={this.handleChange} />
            <label>Address 1</label>
          </div>

          <div class="row">
            <div class="col-9">
              <div class="row sub-text">
                <input type="text" class="form-control" name="city" value={this.state.boxRequest.city} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">City</div>
              </label>
            </div>
            <div class="col-3">
              <div class="row sub-text">
                <input type="text" class="form-control" name="state" value={this.state.boxRequest.state} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">State</div>
              </label>
            </div>
          </div>
          <div class="row">
            <div class="col-md">
              <div class="row">
                <input type="text" class="form-control" name="zip" value={this.state.boxRequest.zip} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">Zip Code</div>
              </label>
            </div>
            <div class="col-md">
              <div class="row">
                <input type="text" class="form-control" name="county" value={this.state.boxRequest.county} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">County</div>
              </label>
            </div>
          </div>
          
          <div class="row section-top">
            <label class="section-label">Phone</label>
            <input type="text" class="form-control" name="phone" value={this.state.boxRequest.phone} onChange={this.handleChange} />
            <div class="col-md-3">
              <label class="following-question">Okay to call?</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="ok_to_call" id="ok_to_call_true" onChange={this.handleRadioChange} />
                <label class="form-check-label" for="ok_to_call">yes</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="ok_to_call" id="ok_to_call_false" onChange={this.handleRadioChange} />
                <label class="form-check-label" for="ok_to_call_false">no</label>
              </div>
            </div>
            <div class="col-md-3">
              <label class="following-question">Okay to text?</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="ok_to_text" id="ok_to_text_true" onChange={this.handleRadioChange} />
                <label class="form-check-label" for="ok_to_text_true">yes</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="ok_to_text" id="ok_to_text_false" onChange={this.handleRadioChange} />
                <label class="form-check-label" for="ok_to_text_false">no</label>
              </div>
            </div>
          </div>

          <div class="row">
            <input type="submit" value="SUBMIT- SEND ME A SURVIVOR BOX" />
          </div>
        </form>
      </div>
    );
  }
}

export default BoxRequestForm;
