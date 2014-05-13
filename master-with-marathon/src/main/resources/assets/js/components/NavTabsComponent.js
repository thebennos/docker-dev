/** @jsx React.DOM */

define([
  "React"
], function(React) {
  function noop() {}

  return React.createClass({
    getDefaultProps: function() {
      return {
        onTabClick: noop
      };
    },
    onTabClick: function(id, event) {
      event.preventDefault();
      this.props.onTabClick(id);
    },
    render: function() {
      var tabs = this.props.tabs.map(function(tab) {
        var tabClassName = (tab.id === this.props.activeTabId) ? "active" : "";

        return (
          <li className={tabClassName} key={tab.id}>
            <a href={"#" + tab.id} onClick={this.onTabClick.bind(this, tab.id)}>
              {tab.text}
            </a>
          </li>
        );
      }, this);

      return (
        <ul className="nav nav-tabs">
          {tabs}
        </ul>
      );
    }
  });
});
