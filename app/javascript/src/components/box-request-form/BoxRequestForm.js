import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import TextInput from './text-input'
import './BoxRequestForm.scss'

class BoxRequestForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      abuseTypeOptions: ["Emotional", "Physical", "Sexual", "All of the Above"],
      attemptedSubmit: false,
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
        question_re_affect: '',
        question_re_referral_source: '',
        question_re_current_situation: '',
        question_re_if_not_self_completed: '',
        is_safe: null,
        is_interested_in_counseling_services: null,
        is_interested_in_health_services: null,
        is_underage: null,
        abuse_types: [],
      },
    }

    this.handleChange = this.handleChange.bind(this);
    this.handleRadioChange = this.handleRadioChange.bind(this);
    this.handleCheckBoxChange = this.handleCheckBoxChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ boxRequest: { ...this.state.boxRequest, [event.target.name]: event.target.value} });
  }

  handleRadioChange(event) {
    let updatedChoice = event.target.id.includes("true") ? true : false;
    this.setState({ boxRequest: { ...this.state.boxRequest, [event.target.name]: updatedChoice} });
  }

  handleCheckBoxChange(event) {
    const abuseType = event.target.value;
    const { abuse_types } = this.state.boxRequest;
    let updatedTypes = [...abuse_types];

    if (updatedTypes.includes(abuseType)) {
        const index = updatedTypes.indexOf(5);
        updatedTypes.splice(index, 1);
      } else {
        updatedTypes.push(abuseType);
      }

    this.setState({ boxRequest: { ...this.state.boxRequest, abuse_types: updatedTypes } });
  }

  handleSubmit(event) {
    this.setState({ attemptedSubmit: true })
    event.preventDefault();

    if (this.missingRequiredFields()) {
      console.log('Missing fields.')
      return;
    }

    const token = document.getElementsByName('csrf-token')[0].content;

    window.fetch(location.origin + '/box_request_triage', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
       'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token
      },
      body: JSON.stringify(this.state)
    });
  }

  missingRequiredFields() {
    const {
      first_name,
      last_name,
      email,
      street_address,
      city,
      state,
      zip,
      ok_to_mail,
      ok_to_call,
      ok_to_text,
      ok_to_email,
      question_re_affect,
      question_re_referral_source,
      question_re_current_situation,
      is_safe,
      is_interested_in_counseling_services,
      is_interested_in_health_services,
      is_underage,
      abuse_types,
    } = this.state.boxRequest;

    const requiredFields = [first_name, last_name, email, street_address, city, state, zip, question_re_affect,
      question_re_referral_source, question_re_current_situation, is_safe, ok_to_mail, ok_to_call, ok_to_text,
      ok_to_email, is_interested_in_counseling_services, is_interested_in_health_services, is_underage];

    return requiredFields.includes(null) || requiredFields.includes('') || abuse_types.length === 0;
  }

  renderRequiredAlert() {
    return (
      <div class="row alert alert-danger required-field" role="alert">
        This field is required.
      </div>
    );
  }

  renderMissingFieldsAlert() {
    return (
      <div class="alert alert-danger required-fields-submit-alert" role="alert">
        Please fill out all the required fields.
      </div>
    );
  }

  renderAbuseTypes() {
    const abuseTypes = this.state.abuseTypeOptions.map((type) =>
      <div class="row form-check">
        <input class="form-check-input" type="checkbox" value={type} id="abuse_types" onChange={this.handleCheckBoxChange} />
        <label class="form-check-label" for="abuse_types">{type}</label>
      </div>
    );

    return abuseTypes;
  }
  render() {
    const { boxRequest } = this.state;

    return (
      <div class="container">
        <form onSubmit={this.handleSubmit}>
          <div class="row section-top section-label">Name *</div>
          { this.state.attemptedSubmit && (boxRequest.first_name == '' || boxRequest.last_name == '') ? this.renderRequiredAlert() : null }
          <div class="row">
            <div class="col-md">
              <input type="text" class="row form-control" name="first_name" value={boxRequest.first_name} onChange={this.handleChange} />
              <label class="row sub-text">First Name</label>
            </div>
            <div class="col-md">
              <input type="text" class="row form-control" name="last_name" value={boxRequest.last_name} onChange={this.handleChange} />
              <label class="row sub-text">Last Name</label>
            </div>
          </div>
          <div class="row section-top">
            <label class="section-label">Email Address *</label>
            <input type="text" class="form-control" name="email" value={boxRequest.email} onChange={this.handleChange} />
          </div>
          { this.state.attemptedSubmit && boxRequest.email == '' ? this.renderRequiredAlert() : null }
          <div class="row">
            <label class="following-question">Okay to email *?</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ok_to_email" id="ok_to_email_true" onChange={this.handleRadioChange} />
              <label class="form-check-label" for="ok_to_email">yes</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ok_to_email" id="ok_to_email_false" onChange={this.handleRadioChange} />
              <label class="form-check-label" for="ok_to_email_false">no</label>
            </div>
          </div>
          { this.state.attemptedSubmit && boxRequest.ok_to_email == null ? this.renderRequiredAlert() : null }

          <label class="row section-top">Type of abuse you have faced *</label>
          { this.state.attemptedSubmit && boxRequest.abuse_types.length === 0 ? this.renderRequiredAlert() : null }
          { this.renderAbuseTypes() }

          <div class="row section-top" >
            <label>Briefly describe your current situation. Is the abuse current? Do you live with your abuser? Do you have kids affected by the abuse? *</label>
            <textarea type="text" class="form-control" name="question_re_current_situation" value={boxRequest.question_re_current_situation} onChange={this.handleChange} />
          </div>
          { this.state.attemptedSubmit && boxRequest.question_re_current_situation == '' ? this.renderRequiredAlert() : null }

          <div class="row section-top">
            <label>How did this abuse affect your life? *</label>
            <textarea type="text" class="form-control" name="question_re_affect" value={boxRequest.question_re_affect} onChange={this.handleChange} />
          </div>
          { this.state.attemptedSubmit && boxRequest.question_re_affect == '' ? this.renderRequiredAlert() : null }

          <label class="row section-top">Do you feel safe now? *</label>
          { this.state.attemptedSubmit && boxRequest.is_safe == null ? this.renderRequiredAlert() : null }
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
          { this.state.attemptedSubmit && boxRequest.is_interested_in_counseling_services == null ? this.renderRequiredAlert() : null }
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
          { this.state.attemptedSubmit && boxRequest.is_interested_in_health_services == null ? this.renderRequiredAlert() : null }
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
          { this.state.attemptedSubmit && boxRequest.is_underage == null ? this.renderRequiredAlert() : null }
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
            { this.state.attemptedSubmit && boxRequest.question_re_referral_source == null ? this.renderRequiredAlert() : null }
            <input type="text" class="form-control" name="question_re_referral_source" value={boxRequest.question_re_referral_source} onChange={this.handleChange} />
          </div>
          { this.state.attemptedSubmit && boxRequest.question_re_referral_source == '' ? this.renderRequiredAlert() : null }

          <div class="row section-top section-label">Address *</div>
          { this.state.attemptedSubmit && (boxRequest.street_address === '' || boxRequest.city === '' || boxRequest.state === '' || boxRequest.zip === '') ? this.renderRequiredAlert() : null }
          <div class="row sub-text">
            <input type="text" class="form-control" name="street_address" value={boxRequest.street_address} onChange={this.handleChange} />
            <label>Address 1</label>
          </div>
          <div class="row">
            <div class="col-9">
              <div class="row sub-text">
                <input type="text" class="form-control" name="city" value={boxRequest.city} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">City</div>
              </label>
            </div>
            <div class="col-3">
              <div class="row sub-text">
                <input type="text" class="form-control" name="state" value={boxRequest.state} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">State</div>
              </label>
            </div>
          </div>
          <div class="row">
            <div class="col-md">
              <div class="row">
                <input type="text" class="form-control" name="zip" value={boxRequest.zip} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">Zip Code</div>
              </label>
            </div>
            <div class="col-md">
              <div class="row">
                <input type="text" class="form-control" name="county" value={boxRequest.county} onChange={this.handleChange} />
              </div>
              <label>
                <div class="row sub-text">County</div>
              </label>
            </div>
          </div>
          <div class="row">
            <label class="following-question">Okay to mail *?</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ok_to_mail" id="ok_to_mail_true" onChange={this.handleRadioChange} />
              <label class="form-check-label" for="ok_to_mail">yes</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="ok_to_mail" id="ok_to_mail_false" onChange={this.handleRadioChange} />
              <label class="form-check-label" for="ok_to_mail_false">no</label>
            </div>
          </div>
          { this.state.attemptedSubmit && boxRequest.ok_to_mail == null ? this.renderRequiredAlert() : null }

          <div class="row section-top">
            <label class="section-label">Phone</label>
            <input type="text" class="form-control" name="phone" value={boxRequest.phone} onChange={this.handleChange} />
            <div class="col-md-3">
              <label class="following-question">Okay to call? *</label>
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
              <label class="following-question">Okay to text? *</label>
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
          { this.state.attemptedSubmit && (boxRequest.ok_to_text == null || boxRequest.ok_to_call == null) ? this.renderRequiredAlert() : null }

          <div class="row section-top">
            <label>Are you requesting this box for someone else? If so, please briefly explain. </label>
            <input type="text" class="form-control" name="question_re_if_not_self_completed" value={boxRequest.question_re_if_not_self_completed} onChange={this.handleChange} />
          </div>

          { this.state.attemptedSubmit && this.missingRequiredFields() ? this.renderMissingFieldsAlert() : null }
            <input type="submit" value="SUBMIT- SEND ME A SURVIVOR BOX" />
        </form>
      </div>
    );
  }
}

export default BoxRequestForm;
