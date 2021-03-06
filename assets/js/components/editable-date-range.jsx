import React, { Component } from "react";
import { Modal, DatePicker, TimePicker } from "antd";
import moment from "moment-timezone";

const friendly = {
  start_date: "Starting Date and Time",
  end_date: "Ending Date and Time",
  new_date: "Dates of Duplicate Event"
};

export default class EditableDate extends Component {
  state = {
    editing: false,
    newDate: undefined,
    newStart: undefined,
    newEnd: undefined
  };

  constructMoment = time => {
    // return moment(time).tz(this.props.time_zone);
    return time
      ? this.props.time_zone
        ? moment.tz(time, this.props.time_zone)
        : moment(time)
      : null;
  };

  combineDateAndTime = (date, time) => {
    date.hours(time.hours());
    date.minutes(time.minutes());
    return date;
  };

  componentWillMount() {
    this.state.newDate = this.constructMoment(this.props.start_date);
    this.state.newStart = this.constructMoment(this.props.start_date);
    this.state.newEnd = this.constructMoment(this.props.end_date);
  }

  onDateChange = newDate => this.setState({ newDate });
  onStartChange = newStart => this.setState({ newStart });
  onEndChange = newEnd => this.setState({ newEnd });

  onChange = e => this.setState({ newVal: e.target.value });

  editOn = () => {
    if (!this.props.disabled) {
      this.props.checkout();
      this.setState({ editing: true });
    }
  };

  handleClickOutside = () => {
    if (this.props.checkin) this.props.checkin();
    this.setState({ editing: false });
  };

  onSave = attr => () => {
    this.setState({ editing: false });

    const { newDate, newStart, newEnd } = this.state;
    const start_date = this.combineDateAndTime(newDate.clone(), newStart);
    const end_date = this.combineDateAndTime(newDate.clone(), newEnd);

    this.props.onSave([
      ["start_date", start_date.format()],
      ["end_date", end_date.format()]
    ]);
  };

  render = () => {
    const start_moment = this.constructMoment(this.props.start_date);
    const end_moment =
      this.constructMoment(this.props.end_date) ||
      start_moment.clone().add(2, "hours");

    return (
      <div onDoubleClick={this.editOn} style={{ cursor: "pointer" }}>
        <Modal
          title={`Edit ${friendly[this.props.attr]}`}
          visible={this.state.editing}
          onOk={this.onSave(this.props.attr)}
          onCancel={this.handleClickOutside}
        >
          <strong> Date: </strong>
          <DatePicker
            defaultValue={start_moment}
            disabledDate={disabledDate}
            onChange={this.onDateChange}
          />
          <br />
          <br />
          <strong> Start: </strong>
          <TimePicker
            defaultOpenValue={start_moment}
            onChange={this.onStartChange}
            use12Hours={true}
            format="hh:mm A"
            disabledMinutes={() =>
              new Array(60)
                .fill(null)
                .map((_, idx) => idx)
                .filter(i => i % 15 != 0)
            }
            hideDisabledOptions={true}
          />

          <strong> End: </strong>
          <TimePicker
            defaultOpenValue={end_moment}
            onChange={this.onEndChange}
            use12Hours={true}
            format="hh:mm A"
            disabledMinutes={() =>
              new Array(60)
                .fill(null)
                .map((_, idx) => idx)
                .filter(i => i % 15 != 0)
            }
            hideDisabledOptions={true}
          />
        </Modal>

        {start_moment.format("dddd, MMMM Do YYYY")}
        <br />
        <span style={{ userSelect: "none" }}>
          {`From ${start_moment.format("h:mm A")} to ${
            end_moment ? end_moment.format("h:mm A") : "unspecified"
          } in ${
            this.props.time_zone_display
              ? moment.tz.zone(this.props.time_zone_display).abbrs[0]
              : "Unknown (add a zip code)"
          }`}
        </span>
      </div>
    );
  };
}

function disabledDate(current) {
  // Can not select days before today and today
  return current && current < moment().endOf("day");
}
