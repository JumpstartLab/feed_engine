function MessageBar() {
    // CSS styling:
    var css = function(el,s) {
        for (var i in s) {
            el.style[i] = s[i];
        }
        return el;
    },
    // Create the element:
    bar = css(document.createElement('div'), {
        top: 0,
        left: 0,
        position: 'fixed',
        background: 'orange',
        width: '100%',
        padding: '10px',
        textAlign: 'center'
    });
    // Inject it:
    document.body.appendChild(bar);
    // Provide a way to set the message:
    this.setMessage = function(message) {
        // Clear contents:
        while(bar.firstChild) {
            bar.removeChild(bar.firstChild);
        }
        // Append new message:
        bar.appendChild(document.createTextNode(message));
    };

    //Default the bar to be hidden 
    bar.style.display = bar.style.display === 'none' ? 'block' : 'none';

    // Provide a way to toggle visibility:
    this.toggleVisibility = function() {
        $(bar).slideToggle(); 
    };
}
