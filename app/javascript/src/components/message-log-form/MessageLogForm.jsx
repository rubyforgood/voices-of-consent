import React from 'react'
import './MessageLogForm.scss'

const MESSAGEABLE_TYPES = [
  {value: "users", display: "User"},
  {value: "volunteers", display: "Volunteer"},
  {value: "requesters", display: "Requester"},
  {value: "box_requests", display: "Box Request"}
]

class MessageLogForm extends React.Component {
  constructor(props) {
    super(props),
    this.state = {
      isFormSubmitting: false,
      messageable_ids: [{ value: "", display: "No IDs on this type" }],
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
    this.setState({ message_log: { ...this.state.message_log, [event.target.name]: event.target.value } })
  }

  handleMessageableTypeChange = (event) => {
    this.setState({ message_log: { ...this.state.message_log, [event.target.name]: event.target.value } })

    const getMessageableIds = async () => {
      const response = await fetch(`${location.origin}/${event.target.value}.json`)
      const myJson = await response.json()
      if (myJson) {
        const messageable_ids = myJson.map(function (type) {
          return { value: type.id, display: type.id }
        })
        this.setState({ messageable_ids: messageable_ids })
      }
    }

    getMessageableIds()
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
                onChange={this.handleMessageableTypeChange}>
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
                {this.state.messageable_ids.map((type_id) => <option key={type_id.value} value={type_id.value}>{type_id.display}</option>)}
              </select>
            </div>
          </div>
          <div className="field">
            <label>Content</label>
            <input
              type="text"
              id="content"
              name="content"
              value={message_log.content}
              onChange={this.handleChange} />
          </div>
          <div className="field">
            <label>Delivery Type</label>
            <input
              type="text"
              id="delivery_type"
              name="delivery_type"
              value={message_log.delivery_type}
              onChange={this.handleChange} />
          </div>
          <div className="field">
            <label>Delivery Status</label>
            <input
              type="text"
              id="delivery_status"
              name="delivery_status"
              value={message_log.delivery_status}
              onChange={this.handleChange} />
          </div>
          <div className="field">
            <label>Sent To</label>
            <input
              type="text"
              id="sent_to_id"
              name="sent_to_id"
              value={message_log.sent_to_id}
              onChange={this.handleChange} />
          </div>
          <div className="field">
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