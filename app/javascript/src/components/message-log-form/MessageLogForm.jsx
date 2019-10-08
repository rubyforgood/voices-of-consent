import React from 'react';
import PropTypes from 'prop-types'
import './MessageLogForm.scss';

const MESSAGEABLE_TYPES = [
  {value: "User", display: "User"},
  {value: "Volunteer", display: "Volunteer"},
  {value: "Requester", display: "Requester"},
  {value: "BoxRequest", display: "Box Request"}
]

class MessageLogForm extends React.Component {
  constructor(props) {
    super(props),
    this.state = {
      isFormSubmitting: false,
      message_log: {
        messageable_type: "",
        messageable_id: "",
        content: "",
        delivery_type: "",
        delivery_status: "",
        sent_to_id: "",
        sent_by_id: ""
      },
    }
  }

  handleChange = (event) => {
    this.setState({ message_log: { ...this.state.message_log, [event.target.name]: event.target.value } });
  }

  handleSubmit = () => {
    this.setState({ isFormSubmitting: true })
    console.log(this.state.message_log)
  }
  
  // TODO: replace messageable id dropdown with real data once we can fetch it from the db
  render() {
    const { message_log } = this.state;
    return (
      <main className="container">
        <h2 className="message-log__header">New Message Log</h2>
        <section>
          <div className="message-log__form">
            <div className="field">
              <label>Messageable Type</label>
              <select
                name="messageable_type"
                value={message_log.messageable_type}
                onChange={this.handleChange}>
                <option value="" disabled>Select Messageable Type</option>
                {MESSAGEABLE_TYPES.map((type) => <option key={type.value} value={type.value}>{type.display}</option>)}
              </select>
            </div>
            <div>
              <label>Messageable ID</label>
              <select
                name="messageable_id"
                value={message_log.messageable_id}
                onChange={this.handleChange}>
                <option value="" disabled>Select Messageable ID</option>
                <option key="1" value="1">1</option>
                <option key="2" value="2">2</option>
                <option key="3" value="3">3</option>
              </select>
            </div>
          </div>
          <div class="field">
            <label>Content</label>
            <input
              type="text"
              id="content"
              name="content"
              value={message_log.content}
              onChange={this.handleChange} />
          </div>
          <div class="field">
            <label>Delivery Type</label>
            <input
              type="text"
              id="delivery_type"
              name="delivery_type"
              value={message_log.delivery_type}
              onChange={this.handleChange} />
          </div>
          <div class="field">
            <label>Delivery Status</label>
            <input
              type="text"
              id="delivery_status"
              name="delivery_status"
              value={message_log.delivery_status}
              onChange={this.handleChange} />
          </div>
          <div class="field">
            <label>Sent To</label>
            <input
              type="text"
              id="sent_to_id"
              name="sent_to_id"
              value={message_log.sent_to_id}
              onChange={this.handleChange} />
          </div>
          <div class="field">
            <label>Sent By</label>
            <input
              type="text"
              id="sent_by_id"
              name="sent_by_id"
              value={message_log.sent_by_id}
              onChange={this.handleChange} />
          </div>
          <button
            type="submit"
            value="submit"
            onClick={this.handleSubmit}>Submit</button>
        </section>
      </main>
    )
  }
}

export default MessageLogForm