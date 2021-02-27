import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import './VolunteerFeedbackForm.scss'
import Select from 'react-select'

const VolunteerFeedbackForm = () => {
  const category_options = [
    "New BoxRequest form",
    "BoxRequest Review phase",
    "Box Design phase",
    "BoxItem Research phase",
    "Box Assembly phase",
    "Box Shipment phase",
    "Box Followup phase",
    "Inventory Management",
    "Attendance/Meeting Management"
  ]
  const [category, setCategory] = useState(null)
  const [description, setDescription] = useState('')
  const [sendingData, setSendingData] = useState(false)
  const [requestErrors, setRequestErrors] = useState(null)
  const [requestSuccess, setRequestSuccess] = useState(false)

  const handleSelectChange = (event) => {
    setCategory(event.target.value)
  }

  const handleDescriptionChange = (event) => {
    setDescription(event.target.value)
  }

  const clearForm = (_event) => {
    setCategory(null)
    setDescription('')
  }

  const handleFormSubmit = (event) => {
    event.preventDefault();
    const token = document.getElementsByName('csrf-token')[0].content
    const url = `${location.origin}/feedbacks/volunteers`
    setSendingData(true)
    setRequestErrors(null);
    setRequestSuccess(false);

    let params = {
      feedback: {
        description: description,
        category: category
      }
    }

    console.log(params);

    fetch(url, {
      method: 'POST',
      body: JSON.stringify(params),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token
      }
    }).then((response) => {
      if( !response.ok ) { 
        throw response 
      } else {
        setRequestSuccess(true)
      }
    }).catch((error) => {
      error.json().then( errMessages => {
        setRequestErrors(errMessages)
      })
    }).finally( setSendingData(false) )
  
  }

  const showResponseMessage = () => {
    if(requestErrors != null) {
      return  (
        <span><i className="fas fa-exclamation-triangle"></i> Whoops, something went wrong, please, try again</span>
      )
    }

    if (requestSuccess) {
      return  (
        <span><i className="fas fa-check"></i> Feedback sent with success, thank you!</span>
      )
    }
  }

  const responseMessageClass = () => {
    if (requestErrors != null && !requestSuccess) {
      return 'text-center text-danger'
    }

    if (requestSuccess) {
      return 'text-center text-success'
    }
  }

  const showDescriptionErrors = () => {
    if(requestErrors != null && requestErrors.description != null) {
      return (
        <div className='text-danger'>
          <small>{ requestErrors.description.join(', ') }</small>
        </div>
      )
    }
  }

  const showCategoryErrors = () => {
    if(requestErrors != null && requestErrors.category != null) {
      return (
        <div className='text-danger'>
          <small>{ requestErrors.category.join(', ') }</small>
        </div>
      )
    }
  }
  
  return(
    <main className='volunteer-feedback'>
      <section>
        <div className="form-info">Thank you for providing your feedback to Voices of Consent</div>
      <hr/>
      <div className={ responseMessageClass() }> { showResponseMessage() } </div>
      <form onSubmit={handleFormSubmit} className='volunteer-feedback__form'>
        <div className="row form-item">
          <div className="col-12">
            <label htmlFor="Cateogry">Category</label>
            <select 
              id="category"
              name="category"
              className={ requestErrors!= null && requestErrors.category != null ? 'feedback-description form-control is-invalid' : 'form-control' }
              onChange={handleSelectChange}>
              <option value="">Please, select one option</option>
              { category_options.map( (opt, index) => <option key={index} value={opt}>{opt}</option> )}
            </select> 
            { showCategoryErrors() }
          </div>
        </div>

        <div className='row form-item'>
          <div className='col-12'>
            <label htmlFor="Cateogry">Description</label>
            <textarea 
              className={ requestErrors!= null && requestErrors.description != null ? 'feedback-description form-control is-invalid' : 'feedback-description form-control' }
              name='description'
              onChange={handleDescriptionChange}
              defaultValue={description}></textarea>
            { showDescriptionErrors() }
          </div>
        </div>

        <div className='row form-item'>
          <div className='col-md-6'>
            <button
              className='btn btn-secondary btn-lg'
              type='reset'
              onClick={clearForm}
            >Clear</button>
          </div>

          <div className='col-md-6'>
            <button
              className='btn btn-primary btn-lg float-right'
              type='submit'
              disabled={ sendingData }
            >{ sendingData ? '...' : 'Submit' } </button>
          </div>
        </div>
      </form>
      </section>
    </main>
  )
}

export default VolunteerFeedbackForm;
