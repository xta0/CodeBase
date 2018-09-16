(function jsx() {
  const parent = document.getElementById('jsx-container');
  //   const msg = "Hello JSX!!!";
  //   const child = <p className="root">{msg}</p>;

  const props = {
    className: 'jsx-root',
    children: 'Hello JSX!!!',
  };
  const child = <p {...props} />;
  ReactDOM.render(child, parent);
}());

(function () {
  const parent = document.querySelector('.jsx-root');
  const message = ({ msg }) => <div>
{msg}
</div>;
  const children = (
    <div className="jsx-children">
      {message({ msg: 'Hello Child #1' })}
      {message({ msg: 'Hello Child #2' })}
    </div>
  );
  ReactDOM.render(children, parent);
}());
