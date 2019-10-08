import React from 'react';
import './MessageLogForm.scss';
import { type } from 'os';

const MESSAGEABLE_TYPES = [
  {value: "User", display: "User"},
  {value: "Volunteer", display: "Volunteer"},
  {value: "Requester", display: "Requester"},
  {value: "BoxRequest", display: "Box Request"}
]

const MessageLogForm = () => {
  
  // TODO: replace messageable id dropdown with real data once we can fetch it from the db
  return (
    <main className="container">
      <h2 className="message-log__header">New Message Log</h2>
      <section>
        <div className="message-log__form">
          <div className="field">
            <label>Messageable Type</label>
            <select>
              {MESSAGEABLE_TYPES.map((type) => <option key={type.value} value={type.value}>{type.display}</option>)}
            </select>
          </div>
          <div>
            <label>Messageable ID</label>
            <select>
              <option key="1" value="1">1</option>
              <option key="2" value="2">2</option>
              <option key="3" value="3">3</option>
            </select>
          </div>
        </div>
        <div class="field">
          <label>Content</label>
          <input type="text" id="content"></input>
        </div>
        <div class="field">
          <label>Delivery Type</label>
          <input type="text" id="delivery_type"></input>
        </div>
        <div class="field">
          <label>Delivery Status</label>
          <input type="text" id="delivery_status"></input>
        </div>
        <div class="field">
          <label>Sent To</label>
          <input type="text" id="sent_to_id"></input>
        </div>
        <div class="field">
          <label>Sent By</label>
          <input type="text" id="sent_by_id"></input>
        </div>
        <button type="submit" value="submit">Submit</button>
      </section>
    </main>
  )
}

export default MessageLogForm;