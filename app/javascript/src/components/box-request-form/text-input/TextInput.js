const TextInput = (props) => {
    return (
      <div className="form-group">
        <label htmlFor={props.name} className="form-label">{props.title}</label>
        <input
          className="form-input"
          id={props.name}
          name={props.name}
          value={props.value}
          onChange={props.handleChange}
          placeholder={props.placeholder}
        />
      </div>
    );
}

export default TextInput;
